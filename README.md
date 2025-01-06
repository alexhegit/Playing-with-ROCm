# Playing-with-ROCm

Here to show my experience about playing with ROCm with runable code, step-by-step tutorial to help you reproduce what I have did. If you have iGPU or dGPU of AMD, you may try Machine Learning with them. 


## Topics
### Training
#### Finetuning
- [LoRA with Radeon](./training/W7900_LoRA_Demo.ipynb)
- [QLoRA with Radeon](./training/W7900_QLoRA_Demo.ipynb)

### Inference
- [Deploy LLM with Radeon iGPU 780M](https://github.com/alexhegit/Playing-with-ROCm/blob/main/inference/LLM/Run%20Ollama%20with%20AMD%20iGPU%20780M-QuickStart.pdf)

### Application/Demo
- [RAG_LLM_QnA_Assistant](https://github.com/alexhegit/RAG_LLM_QnA_Assistant), Step-by-step tutorial repo project to setup RAG Apps with ROCm

- [Ask4ROCm_Chatbot](https://github.com/alexhegit/Ask4ROCm_Chatbot), An chatbot app drive by RAG solution.

- [LLM_Voice_Assistant](https://github.com/alexhegit/Playing-with-ROCm/blob/main/inference/LLM/LLM_Voice_Assistant/Run%20Picovoice%20llm%20voice%20assistant%20with%20ROCm.md) , Use STT/TTS model from Picovoice.

- [Easy-Wav2Lip-ROCm](https://github.com/alexhegit/Easy-Wav2Lip-ROCm), Easy run Wav2Lip with ROCm over AMD GPU. Way2Lip is a project of Generalized Lip Sync Models

- [Run EchoMimic with ROCm](./Digital-Human/EchoMimic.md) EchoMimic: Lifelike Audio-Driven Portrait Animations through Editable Landmark Conditioning

- [Run LLama-3.2-vision with ROCm](https://medium.com/@alexhe.amd/deploy-llama-3-2-vision-quickly-on-amd-rocm-with-ollama-9a23e9a86fea) Ollama+Llama-3.2-vision+ROCm

- [Deploy vLLM service with Kubernetes over AMD ROCm GPU](https://medium.com/@alexhe.amd/deploy-vllm-service-with-kubernetes-over-amd-rocm-gpu-27cd5321271a)
  
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
|     |   |   |   |
|     |    |   |  |

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
 
-------------------------------------------------------------------

```
@misc{ Playing with ROCm,
  author =   {He Ye (Alex)},
  title =    {Playing with ROCm: share my experience and practice},
  howpublished = {\url{https://alexhegit.github.io/}},
  year = {2024--}
}
```
