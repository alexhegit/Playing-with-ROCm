# Playing-with-ROCm

Here to show my experience about playing with ROCm with runable code, step-by-step tutorial to help you reproduce what I have did. If you have iGPU or dGPU of AMD, you may try Machine Learning with them. 

**NOTICE** : For more easier tracking my update, I use 🆕 and 🔥 to flag the new hot topics.

## Topics

### Training

#### Finetuning

- [LoRA with Radeon](./training/W7900_LoRA_Demo.ipynb)
- [QLoRA with Radeon](./training/W7900_QLoRA_Demo.ipynb)

### Inference

- [Deploy Deepseek-R1 in one GPU -AMD Instinct™ MI300X](https://medium.com/@alexhe.amd/deploy-deepseek-r1-in-one-gpu-amd-instinct-mi300x-7a9abeb85f78) 🔥
- [Deploy Llama 3.2 Vision quickly on AMD ROCm with Ollama](https://medium.com/@alexhe.amd/deploy-llama-3-2-vision-quickly-on-amd-rocm-with-ollama-9a23e9a86fea)
- [Deploy vLLM service with Kubernetes over AMD ROCm GPU](https://medium.com/@alexhe.amd/deploy-vllm-service-with-kubernetes-over-amd-rocm-gpu-27cd5321271a)
- [Deploy LLM with Radeon iGPU 780M](https://github.com/alexhegit/Playing-with-ROCm/blob/main/inference/LLM/Run%20Ollama%20with%20AMD%20iGPU%20780M-QuickStart.pdf)
- [Examples of using vLLM with ROCm](https://github.com/alexhegit/Playing-with-ROCm/blob/main/tools/vllm_gadget/README.md)  🆕 🔥
    - Help scripts to fast use vLLM with ROCm
    - Example: using docker compose to run multiple containers of vllm serve. e.g. gpu=0,1 for container-1 and gpu=6,7 for container-2.
 
### MLOPS with ROCm

- vLLM
    - [Neural Magic vLLM, nm-vllm](https://docs.neuralmagic.com)
    - [AIBrix](https://aibrix.readthedocs.io/latest/index.html)
    - [KubeAI](https://github.com/substratusai/kubeai) : AI Inferencing Operator
    - [vLLM Production Stack](https://docs.vllm.ai/en/latest/deployment/integrations/production-stack.html)

### Application/Demo

- [RAG_LLM_QnA_Assistant](https://github.com/alexhegit/RAG_LLM_QnA_Assistant), Step-by-step tutorial repo project to setup RAG Apps with ROCm
- [Ask4ROCm_Chatbot](https://github.com/alexhegit/Ask4ROCm_Chatbot), An chatbot app drive by RAG solution.
- [LLM_Voice_Assistant](https://github.com/alexhegit/Playing-with-ROCm/blob/main/inference/LLM/LLM_Voice_Assistant/Run%20Picovoice%20llm%20voice%20assistant%20with%20ROCm.md) , Use STT/TTS model from Picovoice.
- [Easy-Wav2Lip-ROCm](https://github.com/alexhegit/Easy-Wav2Lip-ROCm), Easy run Wav2Lip with ROCm over AMD GPU. Way2Lip is a project of Generalized Lip Sync Models
- [Run EchoMimic with ROCm](./Digital-Human/EchoMimic.md) EchoMimic: Lifelike Audio-Driven Portrait Animations through Editable Landmark Conditioning
- [Run LLama-3.2-vision with ROCm](https://medium.com/@alexhe.amd/deploy-llama-3-2-vision-quickly-on-amd-rocm-with-ollama-9a23e9a86fea) Ollama+Llama-3.2-vision+ROCm
- [Deploy vLLM service with Kubernetes over AMD ROCm GPU](https://medium.com/@alexhe.amd/deploy-vllm-service-with-kubernetes-over-amd-rocm-gpu-27cd5321271a) , Turoial with sample codes.
- [Play Qwen2.5–Omni with AMD GPU](https://medium.com/@alexhe.amd/play-qwen2-5-omni-with-amd-gpu-9d80de58589a) 🆕 🔥
  
-------------------------------------------------------------------

## Projects work over ROCm

These projects may not offical announce to support ROCm GPU. But they work fine base on my verification.
| Name    | URL     | Category | Hands on |
| -------- | ------- | ------- | ------- |
| CLM-4-Voice | https://github.com/THUDM/GLM-4-Voice | Conversation AI |  |
| EchoMimic | https://github.com/BadToBest/EchoMimic | Digital Human GenAI   | [Run EchoMimic with ROCm](./Digital-Human/EchoMimic.md) |
| Easy-Wav2Lip | https://github.com/anothermartz/Easy-Wav2Lip | Digital Human GenAI | [Easy-Wav2Lip-ROCm](https://github.com/alexhegit/Easy-Wav2Lip-ROCm) |
| GOT-OCR2 | https://github.com/Ucas-HaoranWei/GOT-OCR2.0 | end2end OCR |
| Moshi  | https://github.com/kyutai-labs/moshi  | Conversation AI |  |
| mini-omni | https://github.com/gpt-omni/mini-omni   | Conversation AI  |  |
| mini-omni2 | https://github.com/gpt-omni/mini-omni2   | Conversation AI  |  |
| Picovoice/orca    | https://github.com/Picovoice/orca   | Conversation AI | [LLM_Voice_Assistant](https://github.com/alexhegit/Playing-with-ROCm/blob/main/inference/LLM/LLM_Voice_Assistant/Run%20Picovoice%20llm%20voice%20assistant%20with%20ROCm.md) |
| Retrieval-based-Voice-Conversion-WebUI | https://github.com/RVC-Project/Retrieval-based-Voice-Conversion-WebUI.git | Easily train a good VC model with voice data <= 10 mins!   |   |
| Freeze-Omni 🆕 🔥| https://github.com/VITA-MLLM/Freeze-Omni | A Smart and Low Latency Speech-to-speech Dialogue Model with Frozen LLM | Realtime on Radeon W7900, realtime with good response, feel good than Moshi, mini-omni2 |
| Step-Auido 🆕 🔥| https://github.com/stepfun-ai/Step-Audio | Convseration AI | Too big model, not real time |
| Step-Video-T2V 🆕 🔥| https://github.com/stepfun-ai/Step-Video-T2V | Video GenAI | Run with 1xMI300X |
| UI-TARS | https://github.com/bytedance/UI-TARS | Automated GUI Interaction with Native Agentsfrom ByteDance  |  |
| Qwen2.5-Omni 🆕 🔥|https://github.com/QwenLM/Qwen2.5-Omni | end-to-end multimodal model in the Qwen serie | | 
| CosyVoice| https://github.com/FunAudioLLM/CosyVoice | TTS LLM | [tutorial](https://medium.com/@alexhe.amd/play-cosyvoice-on-amd-rocm-gpu-459c942f7214) , ![conda-env](./conda-env/cosyvoice-env.yml) |



### Wish List

| Name    | URL     | Category | Hands on |
| -------- | ------- | ------- | ------- |
| hertz-dev |https://github.com/Standard-Intelligence/hertz-dev | Conversation AI |
| Freeze-Omni | https://github.com/VITA-MLLM/Freeze-Omni | Conversation AI |  |
| LLaMA-Omni| https://github.com/ictnlp/LLaMA-Omni | Conversation AI |  |
| ichigo Llama 3.1 |https://github.com/homebrewltd/ichigo| Conversation AI||
| ichigo-demo | https://github.com/homebrewltd/ichigo-demo/tree/docker |||
| Exo | https://github.com/exo-explore/exo | heterogeneous distribute inference ||
| Perpleica | https://github.com/ItzCrazyKns/Perplexica | AI Search Engine| issue |
| MiniPerplx| https://github.com/zaidmukaddam/miniperplx | A minimalistic AI-powered search engine | |
| ollama-helm |https://github.com/otwld/ollama-helm|||
| OpenHands |https://github.com/All-Hands-AI/OpenHands| a platform for software development agents powered by AI ||
| HayStack| https://github.com/deepset-ai/haystack | end-to-end LLM framework that allows you to build applications powered by LLMs ||
| Bailing |https://github.com/ictnlp/BayLing|||
| Bailing| https://github.com/wwbin2017/bailing|||
| BabelDuck |https://github.com/Orenoid/BabelDuck|Beginner-friendly AI conversation practice application||
| KubeAI| https://github.com/substratusai/kubeai | deploy and manage AI models on Kubernetes ||
| DSPy | https://dspy.ai | the framework for programming ||
| KServe | https://kserve.github.io/website/latest/ |||
| Camel-ai/OWL | https://github.com/camel-ai/owl |||
| VITA| https://github.com/VITA-MLLM/VITA | VITA-1.5: Towards GPT-4o Level Real-Time Vision and Speech Interaction ||
| DiffRhythm | https://github.com/ASLP-lab/DiffRhythm | End-to-End Full-Length Song Generation with Latent Diffusion | |
| Open-Sora | https://github.com/hpcaitech/Open-Sora | | |
| Real-Time-Voice-Cloning |https://github.com/CorentinJ/Real-Time-Voice-Cloning| | |
| OpenVoice | https://github.com/myshell-ai/OpenVoice |||



### Tracing
- [Awesome-Multimodel-LLM](https://github.com/BradyFU/Awesome-Multimodal-Large-Language-Models)
- [Utiliy scripts of modal-labs/llm-serving](https://github.com/modal-labs/modal-examples/tree/main/06_gpu_and_ml/llm-serving)

### Misc

#### MCP 
- [write-my-first-mcp-server](https://medium.com/@alexhe.amd/write-my-first-mcp-server-e67a747aacc6)


### 3rd Turtorial
- https://ploomber.io/blog/vllm-deploy/
- 
 
-------------------------------------------------------------------

```
@misc{ Playing with ROCm,
  author = {He Ye (Alex)},
  title = {Playing with ROCm: share my experience and practice},
  howpublished = {\url{https://alexhegit.github.io/}},
  year = {2024--}
}
```
