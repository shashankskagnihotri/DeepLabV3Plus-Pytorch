from tqdm import tqdm
import network
from network.pspnet import PSPNet
import utils
import os
import random
import argparse
import numpy as np

from torch.utils import data
from datasets import VOCSegmentation, Cityscapes
from utils import ext_transforms as et
from metrics import StreamSegMetrics

import torch
import torch.nn as nn
import torch.nn.functional as F
from utils.visualizer import Visualizer

from PIL import Image
import matplotlib
import matplotlib.pyplot as plt


def get_argparser():
    parser = argparse.ArgumentParser()

    # Datset Options
    parser.add_argument("--data_root", type=str, default='./datasets/data',
                        help="path to Dataset")
    parser.add_argument("--dataset", type=str, default='voc',
                        choices=['voc', 'cityscapes'], help='Name of dataset')
    parser.add_argument("--num_classes", type=int, default=None,
                        help="num classes (default: None)")

    # Deeplab Options
    available_models = sorted(name for name in network.modeling.__dict__ if name.islower() and \
                              not (name.startswith("__") or name.startswith('_')) and callable(
                              network.modeling.__dict__[name])
                              )
    parser.add_argument("--model", type=str, default='deeplabv3_resnet50',
                        choices=available_models, help='model name')
    parser.add_argument("--separable_conv", action='store_true', default=False,
                        help="apply separable conv to decoder and aspp")
    parser.add_argument("--output_stride", type=int, default=16, choices=[8, 16])

    # Train Options
    parser.add_argument("--test_only", action='store_true', default=False)
    parser.add_argument("--save_val_results", action='store_true', default=False,
                        help="save segmentation results to \"./results\"")
    parser.add_argument("--save_dir", type=str, default='./testing_new_neurips_results/final_transfer_attack/',
                        help="dir to save results")
    parser.add_argument("--total_itrs", type=int, default=30e3,
                        help="epoch number (default: 30k)")
    parser.add_argument("--lr", type=float, default=0.01,
                        help="learning rate (default: 0.01)")
    parser.add_argument("--lr_policy", type=str, default='poly', choices=['poly', 'step'],
                        help="learning rate scheduler policy")
    parser.add_argument("--step_size", type=int, default=10000)
    parser.add_argument("--crop_val", action='store_true', default=False,
                        help='crop validation (default: False)')
    parser.add_argument("--batch_size", type=int, default=16,
                        help='batch size (default: 16)')
    parser.add_argument("--val_batch_size", type=int, default=4,
                        help='batch size for validation (default: 4)')
    parser.add_argument("--crop_size", type=int, default=513)

    parser.add_argument("--ckpt", default="checkpoints/best_deeplabv3_resnet50_voc_os16.pth", type=str,
                        help="restore from checkpoint")
    parser.add_argument("--continue_training", action='store_true', default=False)

    parser.add_argument("--loss_type", type=str, default='cross_entropy',
                        choices=['cross_entropy', 'focal_loss'], help="loss type (default: False)")
    parser.add_argument("--gpu_id", type=str, default='0',
                        help="GPU ID")
    parser.add_argument("--weight_decay", type=float, default=1e-4,
                        help='weight decay (default: 1e-4)')
    parser.add_argument("--random_seed", type=int, default=1,
                        help="random seed (default: 1)")
    parser.add_argument("--print_interval", type=int, default=10,
                        help="print interval of loss (default: 10)")
    parser.add_argument("--val_interval", type=int, default=100,
                        help="epoch interval for eval (default: 100)")
    parser.add_argument("--download", action='store_true', default=False,
                        help="download datasets")

    # PASCAL VOC Options
    parser.add_argument("--year", type=str, default='2012',
                        choices=['2012_aug', '2012', '2011', '2009', '2008', '2007'], help='year of VOC')

    # Visdom options
    parser.add_argument("--enable_vis", action='store_true', default=False,
                        help="use visdom for visualization")
    parser.add_argument("--vis_port", type=str, default='13570',
                        help='port for visdom')
    parser.add_argument("--vis_env", type=str, default='main',
                        help='env for visdom')
    parser.add_argument("--vis_num_samples", type=int, default=8,
                        help='number of samples for visualization (default: 8)')

    # Adversarial attack options
    parser.add_argument("--attack", type=str, default="cospgd", choices=["segpgd", "cospgd"],
                        help="SegPGD attack or CosPGD attack")
    parser.add_argument("--epsilon", type=float, default="0.03",
                        help="epsilon for attack")
    parser.add_argument("--alpha", type=float, default="0.03",
                        help="alpha for attack")
    parser.add_argument("--iterations", type=int, default="10",
                        help="number of attack iterations")
    parser.add_argument("--attacked_model", type=str, default="deeplabv3_resnet50", choices=["deeplabv3_resnet50", "pspnet_resnet50"],
                        help="model to be attacked")
    parser.add_argument("--attacking_model", type=str, default="pspnet_resnet50", choices=["deeplabv3_resnet50", "pspnet_resnet50"],
                        help="model used to generate the adversarial examples")                        
    return parser


def get_dataset(opts):
    """ Dataset And Augmentation
    """
    if opts.dataset == 'voc':
        train_transform = et.ExtCompose([
            # et.ExtResize(size=opts.crop_size),
            et.ExtRandomScale((0.5, 2.0)),
            et.ExtRandomCrop(size=(opts.crop_size, opts.crop_size), pad_if_needed=True),
            et.ExtRandomHorizontalFlip(),
            et.ExtToTensor(),
            et.ExtNormalize(mean=[0.485, 0.456, 0.406],
                            std=[0.229, 0.224, 0.225]),
        ])
        if opts.crop_val:
            val_transform = et.ExtCompose([
                et.ExtResize(opts.crop_size),
                et.ExtCenterCrop(opts.crop_size),
                et.ExtToTensor(),
                et.ExtNormalize(mean=[0.485, 0.456, 0.406],
                                std=[0.229, 0.224, 0.225]),
            ])
        else:
            val_transform = et.ExtCompose([
                et.ExtToTensor(),
                et.ExtNormalize(mean=[0.485, 0.456, 0.406],
                                std=[0.229, 0.224, 0.225]),
            ])
        train_dst = VOCSegmentation(root=opts.data_root, year=opts.year,
                                    image_set='train', download=opts.download, transform=train_transform)
        val_dst = VOCSegmentation(root=opts.data_root, year=opts.year,
                                  image_set='val', download=False, transform=val_transform)

    if opts.dataset == 'cityscapes':
        train_transform = et.ExtCompose([
            # et.ExtResize( 512 ),
            et.ExtRandomCrop(size=(opts.crop_size, opts.crop_size)),
            et.ExtColorJitter(brightness=0.5, contrast=0.5, saturation=0.5),
            et.ExtRandomHorizontalFlip(),
            et.ExtToTensor(),
            et.ExtNormalize(mean=[0.485, 0.456, 0.406],
                            std=[0.229, 0.224, 0.225]),
        ])

        val_transform = et.ExtCompose([
            # et.ExtResize( 512 ),
            et.ExtToTensor(),
            et.ExtNormalize(mean=[0.485, 0.456, 0.406],
                            std=[0.229, 0.224, 0.225]),
        ])

        train_dst = Cityscapes(root=opts.data_root,
                               split='train', transform=train_transform)
        val_dst = Cityscapes(root=opts.data_root,
                             split='val', transform=val_transform)
    return train_dst, val_dst

# FGSM attack code
def fgsm_attack(image, epsilon, data_grad, clip_min, clip_max, alpha):
    # Collect the element-wise sign of the data gradient
    sign_data_grad = data_grad.sign()
    # Create the perturbed image by adjusting each pixel of the input image
    perturbed_image = image + alpha*sign_data_grad
    # Adding clipping to maintain [0,1] range
    perturbed_image = torch.clamp(perturbed_image, clip_min, clip_max)
    # Return the perturbed image
    return perturbed_image

def validate(opts, deeplab_model, pspnet_model, loader, device, metrics, ret_samples_ids=None, criterion=None):
    """Do validation and return specified samples"""
    metrics.reset()
    ret_samples = []
    if opts.attacked_model == 'deeplabv3_resnet50':
        attacked_model = deeplab_model
        #attacking_model = pspnet_model
    elif opts.attacked_model == 'pspnet_resnet50':
        attacked_model = pspnet_model
        #attacking_model = deeplab_model
    if opts.attacking_model == 'deeplabv3_resnet50':
        attacking_model = deeplab_model
        #attacking_model = pspnet_model
    elif opts.attacking_model == 'pspnet_resnet50':
        attacking_model = pspnet_model
        #attacking_model = deeplab_model
    if opts.save_val_results:
        if not os.path.exists(opts.save_dir + '/results'):
            os.makedirs(opts.save_dir + '/results', exist_ok=True)
        denorm = utils.Denormalize(mean=[0.485, 0.456, 0.406],
                                   std=[0.229, 0.224, 0.225])
        img_id = 0

    attacking_model.eval()
    attacked_model.eval()

    with torch.enable_grad():
        for i, (images, labels) in enumerate(tqdm(loader)):

            images = images.to(device, dtype=torch.float32)
            labels = labels.to(device, dtype=torch.long)

            clip_min = images.min() - opts.epsilon
            clip_max = images.max() + opts.epsilon
            
            if opts.attack == 'segpgd' or opts.attack == 'cospgd':
                images = images + torch.FloatTensor(images.shape).uniform_(-1*opts.epsilon, opts.epsilon).cuda()

            images.requires_grad = True
            images.retain_grad()

            outputs = attacking_model(images)
            

            for t in range(opts.iterations):
                loss = criterion(outputs, labels)

                if opts.attack == 'segpgd':
                    lambda_t = t/(2*opts.iterations)
                    output_idx = torch.argmax(outputs, dim=1)
                    loss=torch.sum(torch.where(output_idx==labels, (1-lambda_t)*loss, lambda_t*loss))/(outputs.shape[-2]*outputs.shape[-1])
                elif opts.attack == "cospgd":
                    #import ipdb;ipdb.set_trace()
                    one_hot_target = torch.nn.functional.one_hot(torch.clamp(labels, labels.min(), opts.num_classes-1), num_classes=opts.num_classes).permute(0,3,1,2)
                    eps=10**-8
                    cossim=F.cosine_similarity(torch.sigmoid(outputs)+eps, one_hot_target+eps, dim=1, eps=10**-20)
                    #loss = torch.sum(cossim*loss)/(outputs.shape[-2]*outputs.shape[-1])
                    loss = cossim.detach()*loss
                    #with torch.no_grad():
                    #    loss *= torch.sum(cossim)
                    #    loss /= outputs.shape[-2]*outputs.shape[-1]

                #model.zero_grad()
                loss = loss.mean()
                loss.backward(retain_graph=True)
                data_grad = images.grad
                images = fgsm_attack(images, opts.epsilon, data_grad, clip_min, clip_max, opts.alpha)
                outputs = attacking_model(images)
                images.retain_grad()

            with torch.no_grad():
                outputs = attacked_model(images)
            preds = outputs.detach().max(dim=1)[1].cpu().numpy()
            targets = labels.cpu().numpy()

            metrics.update(targets, preds)
            if ret_samples_ids is not None and i in ret_samples_ids:  # get vis samples
                ret_samples.append(
                    (images[0].detach().cpu().numpy(), targets[0], preds[0]))

            if opts.save_val_results:
                for i in range(len(images)):
                    image = images[i].detach().cpu().numpy()
                    target = targets[i]
                    pred = preds[i]

                    image = (denorm(image) * 255).transpose(1, 2, 0).astype(np.uint8)
                    target = loader.dataset.decode_target(target).astype(np.uint8)
                    pred = loader.dataset.decode_target(pred).astype(np.uint8)

                    Image.fromarray(image).save(opts.save_dir + '/results/%d_image.png' % img_id)
                    Image.fromarray(target).save(opts.save_dir + '/results/%d_target.png' % img_id)
                    Image.fromarray(pred).save(opts.save_dir + '/results/%d_pred.png' % img_id)

                    fig = plt.figure()
                    plt.imshow(image)
                    plt.axis('off')
                    plt.imshow(pred, alpha=0.7)
                    ax = plt.gca()
                    ax.xaxis.set_major_locator(matplotlib.ticker.NullLocator())
                    ax.yaxis.set_major_locator(matplotlib.ticker.NullLocator())
                    plt.savefig(opts.save_dir + '/results/%d_overlay.png' % img_id, bbox_inches='tight', pad_inches=0)
                    plt.close()
                    img_id += 1

        score = metrics.get_results()
    return score, ret_samples


def main():
    opts = get_argparser().parse_args()
    if opts.dataset.lower() == 'voc':
        opts.num_classes = 21
    elif opts.dataset.lower() == 'cityscapes':
        opts.num_classes = 19

    # Setup visualization
    if opts.attack == 'cospgd':
        opts.alpha = 0.04
    elif opts.attack == 'segpgd':
        opts.alpha = 0.01
    opts.save_dir = os.path.join(opts.save_dir,  'Attacked_'+opts.attacked_model, 'used_'+ opts.attacking_model, opts.dataset, opts.attack, str(opts.iterations), str(opts.alpha), str(opts.epsilon))
    opts.vis_env = 'Attacked_' + opts.attacked_model + '_Using_' + opts.attacking_model + '_' + opts.dataset +'_'+ opts.attack +'_'+ str(opts.iterations) +'_'+ str(opts.alpha) +'_'+ str(opts.epsilon)
    vis = Visualizer(port=opts.vis_port,
                     env=opts.vis_env) if opts.enable_vis else None
    if vis is not None:  # display options
        vis.vis_table("Options", vars(opts))

    print("Save Dir: {}".format(opts.save_dir))

    os.environ['CUDA_VISIBLE_DEVICES'] = opts.gpu_id
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    print("Device: %s" % device)

    # Setup random seed
    torch.manual_seed(opts.random_seed)
    np.random.seed(opts.random_seed)
    random.seed(opts.random_seed)

    # Setup dataloader
    if opts.dataset == 'voc' and not opts.crop_val:
        opts.val_batch_size = 1

    train_dst, val_dst = get_dataset(opts)
    train_loader = data.DataLoader(
        train_dst, batch_size=opts.batch_size, shuffle=True, num_workers=128,
        drop_last=True)  # drop_last=True to ignore single-image batches.
    val_loader = data.DataLoader(
        val_dst, batch_size=opts.val_batch_size, shuffle=True, num_workers=128)
    print("Dataset: %s, Train set: %d, Val set: %d" %
          (opts.dataset, len(train_dst), len(val_dst)))

    # Set up model (all models are 'constructed at network.modeling)
    deeplab_model = network.modeling.__dict__[opts.model](num_classes=opts.num_classes, output_stride=opts.output_stride)
    if opts.separable_conv and 'plus' in opts.model:
        network.convert_to_separable_conv(deeplab_model.classifier)
    utils.set_bn_momentum(deeplab_model.backbone, momentum=0.01)

    # Set up metrics
    metrics = StreamSegMetrics(opts.num_classes)

    # Set up optimizer
    optimizer = torch.optim.SGD(params=[
        {'params': deeplab_model.backbone.parameters(), 'lr': 0.1 * opts.lr},
        {'params': deeplab_model.classifier.parameters(), 'lr': opts.lr},
    ], lr=opts.lr, momentum=0.9, weight_decay=opts.weight_decay)
    # optimizer = torch.optim.SGD(params=model.parameters(), lr=opts.lr, momentum=0.9, weight_decay=opts.weight_decay)
    # torch.optim.lr_scheduler.StepLR(optimizer, step_size=opts.lr_decay_step, gamma=opts.lr_decay_factor)
    if opts.lr_policy == 'poly':
        scheduler = utils.PolyLR(optimizer, opts.total_itrs, power=0.9)
    elif opts.lr_policy == 'step':
        scheduler = torch.optim.lr_scheduler.StepLR(optimizer, step_size=opts.step_size, gamma=0.1)

    # Set up criterion
    # criterion = utils.get_loss(opts.loss_type)
    if opts.loss_type == 'focal_loss':
        criterion = utils.FocalLoss(ignore_index=255, size_average=True)
    elif opts.loss_type == 'cross_entropy':
        criterion = nn.CrossEntropyLoss(ignore_index=255, reduction='none')

    def save_ckpt(path):
        """ save current model
        """
        torch.save({
            "cur_itrs": cur_itrs,
            "model_state": deeplab_model.module.state_dict(),
            "optimizer_state": optimizer.state_dict(),
            "scheduler_state": scheduler.state_dict(),
            "best_score": best_score,
        }, path)
        print("Model saved as %s" % path)

    utils.mkdir(opts.save_dir+'/checkpoints')
    # Restore
    best_score = 0.0
    cur_itrs = 0
    cur_epochs = 0
    if opts.ckpt is not None and os.path.isfile(opts.ckpt):
        # https://github.com/VainF/DeepLabV3Plus-Pytorch/issues/8#issuecomment-605601402, @PytaichukBohdan
        checkpoint = torch.load(opts.ckpt, map_location=torch.device('cpu'))
        deeplab_model.load_state_dict(checkpoint["model_state"])
        deeplab_model = nn.DataParallel(deeplab_model)
        deeplab_model.to(device)
        if opts.continue_training:
            optimizer.load_state_dict(checkpoint["optimizer_state"])
            scheduler.load_state_dict(checkpoint["scheduler_state"])
            cur_itrs = checkpoint["cur_itrs"]
            best_score = checkpoint['best_score']
            print("Training state restored from %s" % opts.ckpt)
        print("Model restored from %s" % opts.ckpt)
        del checkpoint  # free memory
    else:
        print("[!] Retrain")
        deeplab_model = nn.DataParallel(deeplab_model)
        deeplab_model.to(device)

    
    pspnet_model = PSPNet(layers=50, classes=opts.num_classes, zoom_factor=8, pretrained=False)
    
    pspnet_model = nn.DataParallel(pspnet_model)
    pspnet_model.module.cls[0]=torch.nn.Conv2d(in_channels=pspnet_model.module.cls[0].in_channels, out_channels=pspnet_model.module.cls[0].out_channels, 
                                            kernel_size=pspnet_model.module.cls[0].kernel_size, stride=pspnet_model.module.cls[0].stride, 
                                            padding=pspnet_model.module.cls[0].padding, groups=1).cuda()
    checkpoint = torch.load("checkpoints/train_epoch_50.pth")
    pspnet_model.load_state_dict(checkpoint['state_dict'], strict=False)
    print("PSPNet Model restored from checkpoints/train_epoch_50.pth")
    pspnet_model.to(device)

    # ==========   Train Loop   ==========#
    vis_sample_id = np.random.randint(0, len(val_loader), opts.vis_num_samples,
                                      np.int32) if opts.enable_vis else None  # sample idxs for visualization
    denorm = utils.Denormalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225])  # denormalization for ori images

    if opts.test_only:
        deeplab_model.eval()
        val_score, ret_samples = validate(
            opts=opts, deeplab_model=deeplab_model, pspnet_model=pspnet_model, loader=val_loader, device=device, metrics=metrics, ret_samples_ids=vis_sample_id, criterion=criterion)
        print(metrics.to_str(val_score))
        if vis is not None:
            vis.vis_table("Metrics", val_score)
            #vis.vis_table("Overall Acc", val_score['Overall Acc'])
            #vis.vis_table("Mean Acc", val_score['Mean Acc'])
            #vis.vis_table("FreqW Acc", val_score['FreqW Acc'])
            #vis.vis_table("Mean IoU", val_score['Mean IoU'])
            #vis.vis_table("Class IoU", val_score['Class IoU'])
        return

    interval_loss = 0
    while True:  # cur_itrs < opts.total_itrs:
        # =====  Train  =====
        model = deeplab_model
        model.train()
        cur_epochs += 1
        for (images, labels) in train_loader:
            cur_itrs += 1

            images = images.to(device, dtype=torch.float32)
            labels = labels.to(device, dtype=torch.long)

            optimizer.zero_grad()
            outputs = model(images)
            loss = criterion(outputs, labels)
            loss.backward()
            optimizer.step()

            np_loss = loss.detach().cpu().numpy()
            interval_loss += np_loss
            if vis is not None:
                vis.vis_scalar('Loss', cur_itrs, np_loss)

            if (cur_itrs) % 10 == 0:
                interval_loss = interval_loss / 10
                print("Epoch %d, Itrs %d/%d, Loss=%f" %
                      (cur_epochs, cur_itrs, opts.total_itrs, interval_loss))
                interval_loss = 0.0

            if (cur_itrs) % opts.val_interval == 0:
                save_ckpt(opts.save_dir + '/checkpoints/latest_%s_%s_os%d.pth' %
                          (opts.model, opts.dataset, opts.output_stride))
                print("validation...")
                model.eval()
                val_score, ret_samples = validate(
                    opts=opts, deeplab_model=model, pspnet_model=model, loader=val_loader, device=device, metrics=metrics,
                    ret_samples_ids=vis_sample_id)
                print(metrics.to_str(val_score))
                if val_score['Mean IoU'] > best_score:  # save best model
                    best_score = val_score['Mean IoU']
                    save_ckpt(opts.save_dir + '/checkpoints/best_%s_%s_os%d.pth' %
                              (opts.model, opts.dataset, opts.output_stride))

                if vis is not None:  # visualize validation score and samples
                    vis.vis_scalar("[Val] Overall Acc", cur_itrs, val_score['Overall Acc'])
                    vis.vis_scalar("[Val] Mean IoU", cur_itrs, val_score['Mean IoU'])
                    vis.vis_table("[Val] Class IoU", val_score['Class IoU'])

                    for k, (img, target, lbl) in enumerate(ret_samples):
                        img = (denorm(img) * 255).astype(np.uint8)
                        target = train_dst.decode_target(target).transpose(2, 0, 1).astype(np.uint8)
                        lbl = train_dst.decode_target(lbl).transpose(2, 0, 1).astype(np.uint8)
                        concat_img = np.concatenate((img, target, lbl), axis=2)  # concat along width
                        vis.vis_image('Sample %d' % k, concat_img)
                model.train()
            scheduler.step()

            if cur_itrs >= opts.total_itrs:
                return


if __name__ == '__main__':
    main()
