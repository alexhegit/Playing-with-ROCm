import os
os.environ["HIP_VISIBLE_DEVICES"]="0"

import torch
use_cuda = torch.cuda.is_available()
if use_cuda:
    print('__CUDNN VERSION:', torch.backends.cudnn.version())
    print('__Number CUDA Devices:', torch.cuda.device_count())
    cunt = torch.cuda.device_count()
