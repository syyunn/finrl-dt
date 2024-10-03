#!/bin/bash

# Environment parameters
env=stock_trading
dataset=your_dataset_name
sample_ratio=1
K=20  # Context length
state_dim=291
act_dim=29
dataset_path="./trajectories_a2c_100_2024-10-02_15-39-10.pkl"

# Model parameters
model_type=dt
dropout=0.1

# Evaluation parameters
num_eval_episodes=10

# Device
device='cuda'

# Pretrained language model
pretrained_lm="/home/gridsan/syun/gpt2_model"

# LoRA checkpoint path
lora_path="/home/gridsan/syun/finrl-dt/checkpoints/stock_trading_your_dataset_name_/home/gridsan/syun/gpt2_model_pretrained-ratio=1_test_run_123/model_5.pt"

# Positional arguments from command line (you might want to pass these as arguments to the script)
description="test_run"
seed=123
gpu=0

# Construct description (similar to training script)
description="${pretrained_lm}_pretrained-ratio=${sample_ratio}_${description}"

# Run the evaluation
CUDA_VISIBLE_DEVICES=${gpu} python eval.py \
    --device ${device} \
    --env ${env} \
    --dataset ${dataset} \
    --dataset_path ${dataset_path} \
    --model_type ${model_type} \
    --seed ${seed} \
    --K ${K} \
    --sample_ratio ${sample_ratio} \
    --pretrained_lm ${pretrained_lm} \
    --dropout ${dropout} \
    --description ${description} \
    --mlp_embedding \
    --adapt_mode \
    --adapt_embed \
    --lora \
    --lora_path "${lora_path}" \
    --num_eval_episodes ${num_eval_episodes} \
    --state_dim ${state_dim} \
    --act_dim ${act_dim}