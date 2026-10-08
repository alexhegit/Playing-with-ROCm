## EchoMimic

[EchoMimic](https://github.com/BadToBest/EchoMimic): Lifelike Audio-Driven Portrait Animations through Editable Landmark Conditioning

The orignal project never mentioned support AMD ROCm GPU. Actually it is depends on PyTorch and ROCm is already one part of PyTorch. That means you could run it with AMD ROCm GPU(MI series and Radeon Series GPU).

**Here** I show the steps for running it with ROCm

## Installation

### Download the Codes

```bash
  git clone https://github.com/BadToBest/EchoMimic
  cd EchoMimic
```

### Python Environment Setup

- Tested System Environment: Ubuntu 22.04, ROCm >= 6.0
- Tested GPUs: Radeon Pro W7900 / MI300X
- Tested Python Version: 3.10

```bash
  conda create -n echomimic python=3.10
  conda activate echomimic
```

Comments the top three lines of requirements.txt and save. (do not install torch cuda version)
```
#torch>=2.0.1,<=2.2.2
#torchvision>=0.15.2,<=0.17.2
#torchaudio>=2.0.2,<=2.2.2
```

Install PyTorch ROCm version
```bash
pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/rocm6.1
```

Install packages with `pip`
```bash
  pip install -r requirements.txt
```

**Then do it as same as cuda what the original repo README.md say **

### Download ffmpeg-static
Download and decompress [ffmpeg-static](https://www.johnvansickle.com/ffmpeg/old-releases/ffmpeg-4.4-amd64-static.tar.xz), then
```
export FFMPEG_PATH=/path/to/ffmpeg-4.4-amd64-static
```

### Download pretrained weights

```shell
git lfs install
git clone https://huggingface.co/BadToBest/EchoMimic pretrained_weights
```

The **pretrained_weights** is organized as follows.

```
./pretrained_weights/
├── denoising_unet.pth
├── reference_unet.pth
├── motion_module.pth
├── face_locator.pth
├── sd-vae-ft-mse
│   └── ...
├── sd-image-variations-diffusers
│   └── ...
└── audio_processor
    └── whisper_tiny.pt
```

In which **denoising_unet.pth** / **reference_unet.pth** / **motion_module.pth** / **face_locator.pth** are the main checkpoints of **EchoMimic**. Other models in this hub can be also downloaded from it's original hub, thanks to their brilliant works:
- [sd-vae-ft-mse](https://huggingface.co/stabilityai/sd-vae-ft-mse)
- [sd-image-variations-diffusers](https://huggingface.co/lambdalabs/sd-image-variations-diffusers)
- [audio_processor(whisper)](https://openaipublic.azureedge.net/main/whisper/models/65147644a518d12f04e32d6f3b26facc3f8dd46e5390956a9424a650c0ce22b9/tiny.pt)

### Audio-Drived Algo Inference 
Run the python inference script:

```bash
  python -u infer_audio2vid.py
  python -u infer_audio2vid_pose.py
```

### Audio-Drived Algo Inference On Your Own Cases 

Edit the inference config file **./configs/prompts/animation.yaml**, and add your own case:

```bash
test_cases:
  "path/to/your/image":
    - "path/to/your/audio"
```

The run the python inference script:
```bash
  python -u infer_audio2vid.py
```

### Motion Alignment between Ref. Img. and Driven Vid.

(Firstly download the checkpoints with '_pose.pth' postfix from huggingface)

Edit driver_video and ref_image to your path in demo_motion_sync.py, then run
```bash
  python -u demo_motion_sync.py
```

### Audio&Pose-Drived Algo Inference
Edit ./configs/prompts/animation_pose.yaml, then run
```bash
  python -u infer_audio2vid_pose.py
```

### Pose-Drived Algo Inference
Set draw_mouse=True in line 135 of infer_audio2vid_pose.py. Edit ./configs/prompts/animation_pose.yaml, then run
```bash
  python -u infer_audio2vid_pose.py
```

### Run the Gradio UI

Thanks to the contribution from @Robin021:

```bash

python -u webgui.py --server_port=3000

```
