
# Templates of vllm commands

## vllm serve

```shell
HF_MODEL="models/models--amd--Llama-3.1-70B-Instruct-FP8-KV"

vllm serve $HF_MODEL \
  --trust-remote-code \
  --max-model-len=65536 \
  --max-num-batched-token=65536  \
  --max-num-seqs=1024 \
  --gpu-memory-utilization=0.9  \
  --enable-prefix-caching \
  --disable-log-requests \
  --kv-cache-dtype=fp8 \
  --tensor-parallel-size 2
```
