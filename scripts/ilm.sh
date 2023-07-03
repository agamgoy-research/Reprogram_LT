#!/bin/bash
#SBATCH --job-name=ilm_vp
#SBATCH --gres=gpu:rtx8000:1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=3:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --partition=long
#SBATCH --output=/home/mila/d/diganta.misra/projects/ILM-VP/logs/ILM.out
#SBATCH --error=/home/mila/d/diganta.misra/projects/ILM-VP/logs/ILM.err

module load anaconda/3

conda activate /home/mila/d/diganta.misra/.conda/envs/sparse

wandb login bd67cef57b7227730fe3edf96e11d954558a9d0d

ulimit -Sn $(ulimit -Hn)

python3 /home/mila/d/diganta.misra/projects/ILM-VP/experiments/cnn/ilm_vp.py \
        --network LT \
        --dataset cifar10 \
        --pretrained_dir /home/mila/d/diganta.misra/scratch/ImageNetCheckpoint \
        --results_path /home/mila/d/diganta.misra/scratch/vp_results \
        --sparsity 9 \
        --seed 1 \
        --train_data_fraction 0.5 \
        --wandb \
        --run_name ilm_vp \
