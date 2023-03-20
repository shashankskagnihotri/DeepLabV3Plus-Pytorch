#!/bin/bash

echo "Training SegPGD 3 iterations"
python -W ignore train_adv.py --model deeplabv3_resnet50 --enable_vis --vis_port 28333 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --save_val_results --attack segpgd --iterations 3

echo "Training SegPGD 5 iterations"
python -W ignore train_adv.py --model deeplabv3_resnet50 --enable_vis --vis_port 28333 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --save_val_results --attack cospgd --iterations 3

echo "Training CosPGD 3 iterations"
python -W ignore train_adv.py --model deeplabv3_resnet50 --enable_vis --vis_port 28333 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --save_val_results --attack segpgd --iterations 5

echo "Training CosPGD 5 iterations"
python -W ignore train_adv.py --model deeplabv3_resnet50 --enable_vis --vis_port 28333 --gpu_id 0 --year 2012_aug --crop_val --lr 0.01 --crop_size 513 --batch_size 16 --output_stride 16 --save_val_results --attack cospgd --iterations 5