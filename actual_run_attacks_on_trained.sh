#!/bin/bash

echo "Attacking CosPGD3AT with CosPGD 3 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model CosPGD3AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/cospgd/3/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 3

echo "Attacking CosPGD3AT with CosPGD 5 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model CosPGD3AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/cospgd/3/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 5

echo "Attacking CosPGD3AT with CosPGD 10 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model CosPGD3AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/cospgd/3/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 10

echo "Attacking CosPGD3AT with CosPGD 20 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model CosPGD3AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/cospgd/3/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 20

echo "Attacking CosPGD3AT with CosPGD 40 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model CosPGD3AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/cospgd/3/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 40


echo "Attacking CosPGD5AT with CosPGD 3 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model CosPGD5AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/cospgd/5/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 3

echo "Attacking CosPGD5AT with CosPGD 5 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model CosPGD5AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/cospgd/5/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 5

echo "Attacking CosPGD5AT with CosPGD 10 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model CosPGD5AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/cospgd/5/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 10

echo "Attacking CosPGD5AT with CosPGD 20 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model CosPGD5AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/cospgd/5/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 20

echo "Attacking CosPGD5AT with CosPGD 40 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model CosPGD5AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/cospgd/5/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 40





echo "Attacking CosPGD3AT with SegPGD 3 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model CosPGD3AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/cospgd/3/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack segpgd --iterations 3

echo "Attacking CosPGD3AT with SegPGD 5 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model CosPGD3AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/cospgd/3/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack segpgd --iterations 5

echo "Attacking CosPGD3AT with SegPGD 10 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model CosPGD3AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/cospgd/3/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack segpgd --iterations 10

echo "Attacking CosPGD3AT with SegPGD 20 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model CosPGD3AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/cospgd/3/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack segpgd --iterations 20

echo "Attacking CosPGD3AT with SegPGD 40 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model CosPGD3AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/cospgd/3/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack segpgd --iterations 40


echo "Attacking CosPGD5AT with SegPGD 3 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model CosPGD5AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/cospgd/5/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack segpgd --iterations 3

echo "Attacking CosPGD5AT with SegPGD 5 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model CosPGD5AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/cospgd/5/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack segpgd --iterations 5

echo "Attacking CosPGD5AT with SegPGD 10 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model CosPGD5AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/cospgd/5/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack segpgd --iterations 10

echo "Attacking CosPGD5AT with SegPGD 20 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model CosPGD5AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/cospgd/5/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack segpgd --iterations 20

echo "Attacking CosPGD5AT with SegPGD 40 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model CosPGD5AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/cospgd/5/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack segpgd --iterations 40





echo "Attacking SegPGD3AT with CosPGD 3 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model SegPGD3AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/segpgd/3/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 3

echo "Attacking SegPGD3AT with CosPGD 5 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model SegPGD3AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/segpgd/3/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 5

echo "Attacking SegPGD3AT with CosPGD 10 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model SegPGD3AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/segpgd/3/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 10

echo "Attacking SegPGD3AT with CosPGD 20 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model SegPGD3AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/segpgd/3/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 20

echo "Attacking SegPGD3AT with CosPGD 40 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model SegPGD3AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/segpgd/3/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 40




echo "Attacking SegPGD5AT with CosPGD 3 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model SegPGD5AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/segpgd/5/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 3

echo "Attacking SegPGD5AT with CosPGD 5 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model SegPGD5AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/segpgd/5/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 5

echo "Attacking SegPGD5AT with CosPGD 10 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model SegPGD5AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/segpgd/5/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 10

echo "Attacking SegPGD5AT with CosPGD 20 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model SegPGD5AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/segpgd/5/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 20

echo "Attacking SegPGD5AT with CosPGD 40 iterations"
python -W ignore attack.py --model deeplabv3_resnet50 --enable_vis --vis_port 28350 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --attacked_model SegPGD5AT_0.01 --ckpt testing_new_neurips_results/training/deeplabv3_resnet50/voc/segpgd/5/0.01/0.03/checkpoints/best_deeplabv3_resnet50_voc_os16.pth --test_only --save_val_results --attack cospgd --iterations 40