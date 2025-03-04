I put some help scipts to using vLLM with ROCm.

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

  Usage:
  
  ```shell
  # start the containers
  . multi_vllm_serve.sh

  # checking
  docker ps
  rocm-smi
  ```

- [curl_test.cmd](curl_test.cmd) : Some commands for testing the vllm serve
