# History

[中文](README.zh.md) · [Catalog](../README.md)

Reproduction steps from 2024–2025 that were actually run on ROCm and left in this repo as notes or scripts.

**Not retested against current ROCm in 2026-10.** Install commands, PyTorch wheels, and container tags are whatever each file says. Copying them today can fail. Links that never had a reproduction write-up are not listed here.

## Fine-tuning

**LoRA / QLoRA on Radeon Pro W7900**

- Window: about 2024–2025. The notebook names say W7900. The text does not pin a ROCm minor version
- Try it:
  - [W7900 LoRA Demo](training/W7900_LoRA_Demo.ipynb)
  - [W7900 QLoRA Demo](training/W7900_QLoRA_Demo.ipynb)
  - [LoRA Llama-3.1](training/LoRA_Llama-3.1.ipynb)
  - [LoRA Llama-3.2-3B](training/LoRA_Llama-3.2-3B_RadeonW7900.ipynb)
  - [QLoRA Llama-3.1](training/QLoRA_Llama-3.1.ipynb)
  - [QLoRA Llama-3.1, 10 epochs](training/QLoRA_Llama-3.1-10epochs.ipynb)
  - [QLoRA Llama-3.1, W7900](training/QLoRA_Llama-3.1_RadeonW7900.ipynb)
  - [run_lora.py](training/run_lora.py)
  - [run_qlora_bs4.py](training/run_qlora_bs4.py)

## Inference

**Ollama on Ryzen iGPU 780M**

- Window: ROCm 6.0. Requires `HSA_OVERRIDE_GFX_VERSION=11.0.0` and BIOS memory carved out for the iGPU. The note says Windows and WSL2 do not work
- Try it: [Markdown](inference/LLM/Run_Ollama_with_AMD_iGPU780M-QuickStart.md) · [PDF](inference/LLM/Run%20Ollama%20with%20AMD%20iGPU%20780M-QuickStart.pdf)

**vLLM containers**

- Window: image `rocm/vllm:rocm6.3.1_mi300_ubuntu22.04_py3.12_vllm_0.6.6`. The `rocm-smi` log in the scripts is dated 2025-03-04, on a machine with 8 MI300-class GPUs
- Try it: [vLLM gadget](tools/vllm_gadget/README.md) (multi-container, Compose, and curl examples)

**Deployment articles from that period** (the steps live on Medium; this repo has no second copy)

- Window: published in 2024–2025 and not rerun for this page
- [Deploy DeepSeek-R1 on one MI300X](https://medium.com/@alexhe.amd/deploy-deepseek-r1-in-one-gpu-amd-instinct-mi300x-7a9abeb85f78)
- [Llama 3.2 Vision with Ollama](https://medium.com/@alexhe.amd/deploy-llama-3-2-vision-quickly-on-amd-rocm-with-ollama-9a23e9a86fea)
- [vLLM on Kubernetes](https://medium.com/@alexhe.amd/deploy-vllm-service-with-kubernetes-over-amd-rocm-gpu-27cd5321271a)

## Applications

**EchoMimic** — Audio-driven portrait animation. Upstream does not mention ROCm. The practice was to install the PyTorch ROCm wheel and then follow the original repo.

- Window: Ubuntu 22.04, ROCm ≥ 6.0, PyTorch wheel `rocm6.1`, Python 3.10. GPUs: Radeon Pro W7900 / MI300X
- Try it: [EchoMimic.md](Digital-Human/EchoMimic.md)
- Upstream: [BadToBest/EchoMimic](https://github.com/BadToBest/EchoMimic)

**CosyVoice** — TTS.

- Window: the certificate package date in the env file is 2025-02. The ROCm version is whatever the Medium article says
- Try it: [conda env](conda-env/cosyvoice-env.yml) · [Medium](https://medium.com/@alexhe.amd/play-cosyvoice-on-amd-rocm-gpu-459c942f7214)
- Upstream: [FunAudioLLM/CosyVoice](https://github.com/FunAudioLLM/CosyVoice)

**Wav2Lip** — Lip sync.

- Window: the companion repo was last updated in 2024-08 and was not rerun for this page
- Try it: [Easy-Wav2Lip-ROCm](https://github.com/alexhegit/Easy-Wav2Lip-ROCm)

**Picovoice voice assistant** — Replaces the cloud GPT call in the Orca sample with Ollama on the iGPU.

- Window: Ryzen 7 8845HS iGPU 780M, Ubuntu 22.04, torch 2.3.0+rocm6.0
- Try it: [steps](inference/LLM/LLM_Voice_Assistant/Run%20Picovoice%20llm%20voice%20assistant%20with%20ROCm.md) · [patch](inference/LLM/LLM_Voice_Assistant/0001-deploy-LLM-local-with-Ollama.patch)

**RAG Q&A**

- Window: the notebook title says AMD Radeon and does not pin a ROCm minor version
- Try it: [Running RAG on AMD Radeon GPU](inference/LLM/Running%20RAG%20on%20AMD%20Radeon%20GPU.ipynb)
- Companion repos (2024): [RAG_LLM_QnA_Assistant](https://github.com/alexhegit/RAG_LLM_QnA_Assistant) · [Ask4ROCm Chatbot](https://github.com/alexhegit/Ask4ROCm_Chatbot)

**Qwen2.5-Omni**

- Window: a Medium article. This repo has no local copy of the steps, and this page did not rerun them
- Try it: [Play Qwen2.5-Omni with AMD GPU](https://medium.com/@alexhe.amd/play-qwen2-5-omni-with-amd-gpu-9d80de58589a)

## Helpers from the same period

Same window as the entries above. **Not retested in 2026-10.**

- [verify_rocm_env.md](tools/verify_rocm_env.md) — check whether PyTorch sees the GPU
- [test_gpu.py](tools/test_gpu.py), [query_gpu.py](tools/query_gpu.py)
- [hf_dl.sh](tools/hf_dl.sh) — download a Hugging Face model
- [iphi-2.py](tools/iphi-2.py) — one local attempt to load Phi-2
