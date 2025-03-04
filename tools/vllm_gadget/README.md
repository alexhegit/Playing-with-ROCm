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
