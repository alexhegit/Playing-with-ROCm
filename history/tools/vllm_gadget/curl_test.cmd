curl http://localhost:8001/v1/models
curl http://localhost:8002/v1/models

curl http://localhost:8001/v1/completions \
-H "Content-Type: application/json" \
-d '{
        "model": "models/models--meta-llama--Llama-3.1-8B-Instruct",
        "prompt": "Write a haiku about artificial intelligence",
        "max_tokens": 128,
        "top_p": 0.95,
        "top_k": 20,
        "temperature": 0.8
      }'

curl http://localhost:8002/v1/completions \
-H "Content-Type: application/json" \
-d '{
        "model": "models/models--meta-llama--Llama-3.1-8B-Instruct",
        "prompt": "Write a haiku about artificial intelligence",
        "max_tokens": 128,
        "top_p": 0.95,
        "top_k": 20,
        "temperature": 0.8
      }'
