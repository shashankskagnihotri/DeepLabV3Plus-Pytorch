#!/bin/bash

echo "cospgd 3 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28354 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --ckpt checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 3
echo "cospgd 5 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28354 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --ckpt checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 5
echo "cospgd 10 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28354 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --ckpt checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 10
echo "cospgd 20 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28354 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --ckpt checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 20
echo "cospgd 40 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28354 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --ckpt checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 40





echo "segpgd 3 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28354 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --ckpt checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack segpgd --iterations 3
echo "segpgd 5 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28354 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --ckpt checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack segpgd --iterations 5
echo "segpgd 10 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28354 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --ckpt checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack segpgd --iterations 10
echo "segpgd 20 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28354 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --ckpt checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack segpgd --iterations 20
echo "segpgd 40 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28354 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --ckpt checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack segpgd --iterations 40
#python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28340 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --ckpt checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack segpgd --iterations 10
#python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28340 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --ckpt checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack segpgd --iterations 20
#python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28340 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --ckpt checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack segpgd --iterations 40
