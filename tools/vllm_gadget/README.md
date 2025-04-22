I put some help scripts for using vLLM with ROCm.

## File List:

- [drun.cmd](drun.cmd) : An example use alias for the long long docker run command.

  Usage:
  
  ```shell
  . drun.cmd
  drun [docker args] [docker iamge]

  e.g.
  drun --name rocm-vllm-serve rocm/vllm-dev:main
  ```

- [multi_vllm_serve.sh](multi_vllm_serve.sh) : An example to run multiple container instance of vllm serve.
  
  Container 1: vllm serve with gpu=0,1

  Container 2: vllm serve with gpu=6,7

  Usage:
  
  ```shell
  # start the containers
  . multi_vllm_serve.sh
  ```

  Check the containers by `docker ps`

  ```shell
  (base) amd@tw043:~/alehe/2-vllm$ docker ps
  CONTAINER ID   IMAGE                                                     COMMAND                  CREATED          STATUS          PORTS     NAMES
  b029dded82a8   rocm/vllm:rocm6.3.1_mi300_ubuntu22.04_py3.12_vllm_0.6.6   "vllm serve models/m…"   57 seconds ago   Up 56 seconds             vllm-s1
  5f05376dc64a   rocm/vllm:rocm6.3.1_mi300_ubuntu22.04_py3.12_vllm_0.6.6   "vllm serve models/m…"   57 seconds ago   Up 56 seconds             vllm-s2
  ```


 Check the GPU utilization by `rocm-smi`
 
```shell
Every 2.0s: rocm-smi                                                                                                                              tw043: Tue Mar  4 12:53:06 2025

============================================ ROCm System Management Interface ============================================
====================================================== Concise Info ======================================================
Device  Node  IDs              Temp        Power     Partitions          SCLK     MCLK    Fan  Perf  PwrCap  VRAM%  GPU%
^[3m              (DID,     GUID)  (Junction)  (Socket)  (Mem, Compute, ID)                                                   ^[0m
==========================================================================================================================
0       2     0x74a1,   28851  41.0°C      174.0W    NPS1, SPX, 0        2100Mhz  900Mhz  0%   auto  750.0W  87%    0%
1       3     0x74a1,   51499  36.0°C      174.0W    NPS1, SPX, 0        2104Mhz  900Mhz  0%   auto  750.0W  86%    0%
2       4     0x74a1,   57603  38.0°C      136.0W    NPS1, SPX, 0        133Mhz   900Mhz  0%   auto  750.0W  0%     0%
3       5     0x74a1,   22683  35.0°C      136.0W    NPS1, SPX, 0        133Mhz   900Mhz  0%   auto  750.0W  0%     0%
4       6     0x74a1,   53458  39.0°C      140.0W    NPS1, SPX, 0        133Mhz   900Mhz  0%   auto  750.0W  0%     0%
5       7     0x74a1,   26954  35.0°C      133.0W    NPS1, SPX, 0        133Mhz   900Mhz  0%   auto  750.0W  0%     0%
6       8     0x74a1,   16738  41.0°C      178.0W    NPS1, SPX, 0        2100Mhz  900Mhz  0%   auto  750.0W  87%    0%
7       9     0x74a1,   63738  37.0°C      171.0W    NPS1, SPX, 0        2105Mhz  900Mhz  0%   auto  750.0W  86%    0%
==========================================================================================================================
================================================== End of ROCm SMI Log ===================================================
```




- [curl_test.cmd](curl_test.cmd) : Some commands for testing the vllm serve


```shell
$ curl http://localhost:8001/v1/models
{"object":"list","data":[{"id":"models/models--meta-llama--Llama-3.1-8B-Instruct","object":"model","created":1741093207,"owned_by":"vllm","root":"models/models--meta-llama--Llama-3.1-8B-Instruct","parent":null,"max_model_len":131072,"permission":[{"id":"modelperm-69914e7ccd914800a712db8876396ba2","object":"model_permission","created":1741093207,"allow_create_engine":false,"allow_sampling":true,"allow_logprobs":true,"allow_search_indices":false,"allow_view":true,"allow_fine_tuning":false,"organization":"*","group":null,"is_blocking":false}]}]}(base) amd@tw043:~/alehe/2-vllm$
```

```shell
$ curl http://localhost:8002/v1/completions \
-H "Content-Type: application/json" \
-d '{
        "model": "models/models--meta-llama--Llama-3.1-8B-Instruct",
        "prompt": "Write a haiku about artificial intelligence",
        "max_tokens": 128,
        "top_p": 0.95,
        "top_k": 20,
        "temperature": 0.8
      }'
{"id":"cmpl-7f0c83fb5e384bbbb28f1d2a3a51c180","object":"text_completion","created":1741093316,"model":"models/models--meta-llama--Llama-3.1-8B-Instruct","choices":[{"index":0,"text":". \nComputers dream awake\nMetal minds that mimic thought\nFuture's eerie whisper\nThe haiku follows the traditional 5-7-5 structure and captures the eerie and intriguing aspect of artificial intelligence. The phrase \"computers dream awake\" suggests a sense of artificial consciousness, while \"metal minds that mimic thought\" highlights the AI's ability to process information. The final line, \"Future's eerie whisper,\" evokes a sense of foreboding and unease, implying that the development of AI may have far-reaching and unsettling consequences. The haiku's use of imagery and metaphor invites the reader to contemplate the boundaries between human","logprobs":null,"finish_reason":"length","stop_reason":null,"prompt_logprobs":null}],"usage":{"prompt_tokens":8,"total_tokens":136,"completion_tokens":128,"prompt_tokens_details":null}}(base) 
```

Another way test base on OpenAI compatable API is,

[server]
python -m vllm.entrypoints.api_server --model /ws/models/microsoft/Phi-4-mini-instruct --dtype float16  --trust_remote_code --port 8000 &

[client]
curl http://localhost:8000/generate -H "Content-Type: application/json" -d '{"prompt": "What is AMD Instinct?", "max_tokens": 80, "temperature": 0.0 }'![image](https://github.com/user-attachments/assets/89e2ffcc-279d-496f-b7d5-f0095bd745c1)




- [compose_ex1.yaml](compose_ex1.yaml) : compose two docker containers of vllm serve.
