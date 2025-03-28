#!/bin/bash

#DIMG="rocm/vllm-dev:base"
DIMG="rocm/vllm:rocm6.3.1_mi300_ubuntu22.04_py3.12_vllm_0.6.6"

docker pull $DIMG

alias drun="docker run -d --rm \
    --ipc=host \
    --network host \
    --privileged \
    --shm-size 16g \
    --device=/dev/kfd \
    --device=/dev/dri \
    --device=/dev/mem \
    --group-add video \
    --cap-add=SYS_PTRACE \
    --cap-add=CAP_SYS_ADMIN \
    --security-opt seccomp=unconfined \
    --security-opt apparmor=unconfined \
    -v ${HOME}:/ws -w /ws \
    "
#drun --name vllm-s1 -e HIP_VISIBLE_DEVICES="0,1" $DIMG &
#drun --name vllm-s2 -e HIP_VISIBLE_DEVICES="6,7" $DIMG &

#MODEL="models/models--meta-llama--Llama-3.1-8B-Instruct"
MODEL="models/models--amd--Llama-3.1-70B-Instruct-FP8-KV"

VARGS=" --trust-remote-code \
        --max-model-len=65536 \
        --max-num-batched-token=65536 \
        --max-num-seqs=1024 \
        --gpu-memory-utilization=0.9 \
        --enable-prefix-caching \
        --disable-log-requests \
        --kv-cache-dtype=fp8 \
        --tensor-parallel-size 2
        "

echo "Starting container vllm-s1"
#drun --name vllm-s1 -e HIP_VISIBLE_DEVICES="0,1" $DIMG vllm serve $MODEL -tp 2 --port 8001 &
drun --name vllm-s1 -e HIP_VISIBLE_DEVICES="0,1" ${DIMG} vllm serve ${MODEL} ${VARGS} --port 8001 &
echo "Container vllm-s1 started"

echo "Starting container vllm-s2"
#drun --name vllm-s2 -e HIP_VISIBLE_DEVICES="6,7" $DIMG vllm serve $MODEL -tp 2 --port 8002 &
drun --name vllm-s2 -e HIP_VISIBLE_DEVICES="6,7" ${DIMG} vllm serve ${MODEL} ${VARGS} --port 8002 &
echo "Container vllm-s2 started"

wait

echo "All containers have been started"
