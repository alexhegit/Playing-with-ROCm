# History

[English](README.md) · [目录](../README.zh.md)

2024–2025 年在 ROCm 上亲手做完、并且仓库里留了步骤或脚本的实践。**2026-10 未复测。** 安装命令、轮子和镜像标签以各文件原文为准。当时没有复现步骤的链接没有收进来。

| | 板块 |
| --- | --- |
| 1 | [微调](#finetune) |
| 2 | [推理](#infer) |
| 3 | [应用](#apps) |
| 4 | [小工具](#helpers) |

<a id="finetune"></a>

## 1 · 微调

**LoRA / QLoRA，Radeon Pro W7900**

- 验证窗口：约 2024–2025。笔记本文件名写的是 W7900，正文没有钉死 ROCm 小版本
- 动手：
  - [W7900 LoRA Demo](training/W7900_LoRA_Demo.ipynb)
  - [W7900 QLoRA Demo](training/W7900_QLoRA_Demo.ipynb)
  - [LoRA Llama-3.1](training/LoRA_Llama-3.1.ipynb)
  - [LoRA Llama-3.2-3B](training/LoRA_Llama-3.2-3B_RadeonW7900.ipynb)
  - [QLoRA Llama-3.1](training/QLoRA_Llama-3.1.ipynb)
  - [QLoRA Llama-3.1，10 epochs](training/QLoRA_Llama-3.1-10epochs.ipynb)
  - [QLoRA Llama-3.1，W7900](training/QLoRA_Llama-3.1_RadeonW7900.ipynb)
  - [run_lora.py](training/run_lora.py)
  - [run_qlora_bs4.py](training/run_qlora_bs4.py)

<a id="infer"></a>

## 2 · 推理

**Ollama，Ryzen iGPU 780M**

- 验证窗口：ROCm 6.0。需要 `HSA_OVERRIDE_GFX_VERSION=11.0.0`，BIOS 给核显划分显存。文档写明 Windows 和 WSL2 不行
- 动手：[Markdown](inference/LLM/Run_Ollama_with_AMD_iGPU780M-QuickStart.md) · [PDF](inference/LLM/Run%20Ollama%20with%20AMD%20iGPU%20780M-QuickStart.pdf)

**vLLM 容器**

- 验证窗口：镜像 `rocm/vllm:rocm6.3.1_mi300_ubuntu22.04_py3.12_vllm_0.6.6`。脚本里的 `rocm-smi` 记录是 2025-03-04，机器上有 8 张 MI300 级 GPU
- 动手：[vLLM gadget](tools/vllm_gadget/README.md)（多容器、Compose、curl 示例）

**当时的部署文章**（步骤在 Medium 上，本仓库没有第二份）

- 验证窗口：文章发表于 2024–2025，本页未再跑
- [在一张 MI300X 上部署 DeepSeek-R1](https://medium.com/@alexhe.amd/deploy-deepseek-r1-in-one-gpu-amd-instinct-mi300x-7a9abeb85f78)
- [用 Ollama 跑 Llama 3.2 Vision](https://medium.com/@alexhe.amd/deploy-llama-3-2-vision-quickly-on-amd-rocm-with-ollama-9a23e9a86fea)
- [在 Kubernetes 上部署 vLLM](https://medium.com/@alexhe.amd/deploy-vllm-service-with-kubernetes-over-amd-rocm-gpu-27cd5321271a)

<a id="apps"></a>

## 3 · 应用

**EchoMimic** — 音频驱动的人像动画。上游没写 ROCm，实践是换上 PyTorch ROCm 轮子后按原仓库步骤跑。

- 验证窗口：Ubuntu 22.04，ROCm ≥ 6.0，PyTorch 轮子 `rocm6.1`，Python 3.10。GPU：Radeon Pro W7900 / MI300X
- 动手：[EchoMimic.md](Digital-Human/EchoMimic.md)
- 上游：[BadToBest/EchoMimic](https://github.com/BadToBest/EchoMimic)

**CosyVoice** — TTS。

- 验证窗口：环境文件里的证书包日期是 2025-02。ROCm 版本以 Medium 原文为准
- 动手：[conda 环境](conda-env/cosyvoice-env.yml) · [Medium](https://medium.com/@alexhe.amd/play-cosyvoice-on-amd-rocm-gpu-459c942f7214)
- 上游：[FunAudioLLM/CosyVoice](https://github.com/FunAudioLLM/CosyVoice)

**Wav2Lip** — 唇形同步。

- 验证窗口：配套仓库最后更新在 2024-08，本页未再跑
- 动手：[Easy-Wav2Lip-ROCm](https://github.com/alexhegit/Easy-Wav2Lip-ROCm)

**Picovoice 语音助手** — 把 Orca 示例里的云端 GPT 换成核显上的 Ollama。

- 验证窗口：Ryzen 7 8845HS iGPU 780M，Ubuntu 22.04，torch 2.3.0+rocm6.0
- 动手：[步骤](inference/LLM/LLM_Voice_Assistant/Run%20Picovoice%20llm%20voice%20assistant%20with%20ROCm.md) · [补丁](inference/LLM/LLM_Voice_Assistant/0001-deploy-LLM-local-with-Ollama.patch)

**RAG 问答**

- 验证窗口：笔记本标题写的是 AMD Radeon，没有钉死 ROCm 小版本
- 动手：[Running RAG on AMD Radeon GPU](inference/LLM/Running%20RAG%20on%20AMD%20Radeon%20GPU.ipynb)
- 配套仓库（2024）：[RAG_LLM_QnA_Assistant](https://github.com/alexhegit/RAG_LLM_QnA_Assistant) · [Ask4ROCm Chatbot](https://github.com/alexhegit/Ask4ROCm_Chatbot)

**Qwen2.5-Omni**

- 验证窗口：Medium 文章，本仓库没有步骤副本，本页未再跑
- 动手：[Play Qwen2.5-Omni with AMD GPU](https://medium.com/@alexhe.amd/play-qwen2-5-omni-with-amd-gpu-9d80de58589a)

<a id="helpers"></a>

## 4 · 当时的小工具

和上面同一时期的脚本，同样 **2026-10 未复测**。

- [verify_rocm_env.md](tools/verify_rocm_env.md) — 检查 PyTorch 能否看到 GPU
- [test_gpu.py](tools/test_gpu.py)、[query_gpu.py](tools/query_gpu.py)
- [hf_dl.sh](tools/hf_dl.sh) — 下载 Hugging Face 模型
- [iphi-2.py](tools/iphi-2.py) — 本地 Phi-2 的一次加载尝试
