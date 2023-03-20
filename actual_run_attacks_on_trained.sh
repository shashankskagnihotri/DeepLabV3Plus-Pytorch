
echo "Attacking CosPGD3AT with CosPGD 3 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28333 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model CosPGD3AT_0.01 --ckpt results/training/deeplabv3_resnet50/voc/cospgd/3/0.01/3/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 3

echo "Attacking CosPGD3AT with CosPGD 5 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28333 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model CosPGD3AT_0.01 --ckpt results/training/deeplabv3_resnet50/voc/cospgd/3/0.01/3/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 5

echo "Attacking CosPGD3AT with CosPGD 10 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28333 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model CosPGD3AT_0.01 --ckpt results/training/deeplabv3_resnet50/voc/cospgd/3/0.01/3/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 10

echo "Attacking CosPGD3AT with CosPGD 20 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28333 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model CosPGD3AT_0.01 --ckpt results/training/deeplabv3_resnet50/voc/cospgd/3/0.01/3/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 20

echo "Attacking CosPGD3AT with CosPGD 40 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28333 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model CosPGD3AT_0.01 --ckpt results/training/deeplabv3_resnet50/voc/cospgd/3/0.01/3/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 40
