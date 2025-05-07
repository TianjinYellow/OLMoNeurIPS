#!/bin/bash
#SBATCH --partition=gpu_h100
#SBATCH --gpus=4
#SBATCH --job-name=BF16_adam
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=32
#SBATCH --time=5-00:00:00
#SBATCH --output=./logs/BF_adam_3_10norm.out


# export NCCL_ASYNC_ERROR_HANDLING=1
# export NCCL_IB_DISABLE=1  # Disable Infiniband if relevant

# source activate olmo2

# wandb login 0831d62c2353a87b23a963dcb28ecc86cef378ee
# torchrun  --nproc_per_node=4 --rdzv_backend=c10d --rdzv_endpoint=localhost:29400 scripts/train.py \
#   ./configs/OLMo-1B.yaml \
#   --save_overwrite \
#   --save_folder=/scratch-shared/HTJ/20B_New/ \
#   --try_load_latest_save
export NCCL_ASYNC_ERROR_HANDLING=1
export NCCL_IB_DISABLE=1  # Disable Infiniband if relevant

source activate olmo2

wandb login 0831d62c2353a87b23a963dcb28ecc86cef378ee
torchrun  --nproc_per_node=4 --rdzv_backend=c10d --rdzv_endpoint=localhost:29400 scripts/train.py \
  ./configs/OLMo-1B.yaml \
  --save_overwrite \
  --save_folder=/scratch-shared/HTJ/20B_New_10norm/ \
  --try_load_latest_save
