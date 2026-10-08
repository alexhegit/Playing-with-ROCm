# Verify PyTorch installation 
(refer to https://rocm.docs.amd.com/projects/radeon/en/latest/docs/install/install-pytorch.html#verify-pytorch-installation)

Confirm if PyTorch is correctly installed.

1. Verify if Pytorch is installed and detecting the GPU compute device.

`python3 -c 'import torch' 2> /dev/null && echo 'Success' || echo 'Failure'`

**Expected result:**

`Success`

2. Enter command to test if the GPU is available.

`python3 -c 'import torch; print(torch.cuda.is_available())'`

**Expected result:**
`True`

3. Enter command to display installed GPU device name.

`python3 -c "import torch; print(f'device name [0]:', torch.cuda.get_device_name(0))"`

**Expected result:** Example: device name [0]: Radeon RX 7900 XTX

`device name [0]: <Supported AMD GPU>`

4. Enter command to display component information within the current PyTorch environment.

`python3 -m torch.utils.collect_env`

**Expected result:**

```
PyTorch version
 
ROCM used to build PyTorch
 
OS
 
Is CUDA available
 
GPU model and configuration
 
HIP runtime version
 
MIOpen runtime version
```

Environment set-up is complete, and the system is ready for use with PyTorch to work with machine learning models, and algorithms.
