#!/bin/bash

# You should install it if not 
# pip install -U huggingface_hub

#export HF_ENDPOINT=https://hf-mirror.com

# Check if the correct number of arguments was passed
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <model-id> <save-dir>"
    exit 1
fi

# Assign the script arguments to variables
MODEL_ID=$1
SAVE_DIR=$2

# Set the Hugging Face cache environment variable to the save directory
#export TRANSFORMERS_CACHE=$SAVE_DIR

# Create the directory if it does not exist
mkdir -p "$SAVE_DIR"

# Use transformers-cli to download the model
huggingface-cli download --resume-download --local-dir-use-symlinks False $MODEL_ID --local-dir $SAVE_DIR

# Check if the download was successful
if [ $? -eq 0 ]; then
    echo "Model downloaded successfully."
else
    echo "Failed to download the model."
    exit 1
fi
