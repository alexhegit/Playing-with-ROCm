
Picovoice show a LLM Voice Assistant demo at [orca/demo/llm_voice_assistant at main · Picovoice/orca (github.com)](https://github.com/Picovoice/orca/tree/main/demo/llm_voice_assistant) . The orginal demo depends on calling GPT3.5-turbo from Cloud with OpenAI API. 

Here I will guide you to modify it and run [orca/demo/llm_voice_assistant at main · Picovoice/orca (github.com)](https://github.com/Picovoice/orca/tree/main/demo/llm_voice_assistant) with LLM deploy at local with AMD iGPU-780M.

## Platform:
**HW**: AMD Ryzen 7 8845HS(iGPU-780M)
**OS**: Ubuntu22.04
**SW**: 
- torch v2.3.0+rocm6.0
- Ollama
## Steps:
1. Setup Ollama with ROCm
	 Refer to [Playing-with-ROCm/inference/LLM/Run_Ollama_with_AMD_iGPU780M-QuickStart.md at main · alexhegit/Playing-with-ROCm (github.com)](https://github.com/alexhegit/Playing-with-ROCm/blob/main/inference/LLM/Run_Ollama_with_AMD_iGPU780M-QuickStart.md) 

2. Setup  [orca/demo/llm_voice_assistant at main · Picovoice/orca (github.com)](https://github.com/Picovoice/orca/tree/main/demo/llm_voice_assistant) 
	- Clone the repo
	- Refer to the README to install the requirements(pip packages)

3. Patch to  [orca/demo/llm_voice_assistant at main · Picovoice/orca (github.com)](https://github.com/Picovoice/orca/tree/main/demo/llm_voice_assistant) 
   Run the commands
	 ```
	 cd [orca repo root dir]
	 git am 0001-deploy-LLM-local-with-Ollama.patch
	 ```
   This patch file is provided at [here](https://github.com/alexhegit/Playing-with-ROCm/blob/main/inference/LLM/LLM_Voice_Assistant/0001-deploy-LLM-local-with-Ollama.patch).

4. Request AccessKey from https://picovoice.ai/ 

5. Connect the micphone to the PC

6.  Run the demo in ./orca/demo/llm_voice_assistant/ in terminal
	`python3 llm_voice_assistant_demo.py --picovoice-access-key [your AccessKey] --openai-access-key ollama` 
	
	The terminal output "Listening ..." . Please start the talking with your micphone. 


