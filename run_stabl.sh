#!/bin/bash
#SBATCH --partition=gpu_h100
#SBATCH --gpus=4
#SBATCH --nodes=1
#SBATCH --job-name=BF16_StableSPAM_50norm
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=5-00:00:00
#SBATCH --output=./logs/BF4_Stablespam_new1_50norm.out


# export NCCL_DEBUG=INFO
# export NCCL_DEBUG_SUBSYS=ALL
export NCCL_ASYNC_ERROR_HANDLING=1
export NCCL_IB_DISABLE=1  # Disable Infiniband if relevant

source activate olmo2

wandb login 0831d62c2353a87b23a963dcb28ecc86cef378ee
torchrun  --nproc_per_node=4 --rdzv_backend=c10d --rdzv_endpoint=localhost:29401 scripts/train.py \
  ./configs/OLMo-1B_Stablespam.yaml \
  --save_overwrite \
  --save_folder=/scratch-shared/HTJ/20B_StableSPAM_new1_50norm/ \
  --optimizer.name=adamwour \
  --try_load_latest_save \
  --quantization.quantize=True \
  --optimizer.gamma1=0.7 \
  --optimizer.gamma2=0.9 \
  --optimizer.theta=0.999 

  
  
