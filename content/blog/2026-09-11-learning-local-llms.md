+++
title = "Learning local LLMs for an offline voice assistant"
date = "2026-09-11T11:35:00.000Z"
tags = [
  "llm",
  "local-llm",
  "inference",
  "quantization",
  "whisper",
  "whisper.cpp",
  "edge",
  "raspberry-pi",
  "pytorch",
  "voice-assistant"
]
+++

With the recent developments in local LLMs, building an offline voice assistant that actually works started to feel like a plausible idea. I was also looking for a project that would teach me how to build LLM-based applications that can run on the edge.

This is a short summary of that journey: from knowing very little about running inference to having a quantized, optimized voice assistant running on my machine.

There will be two parts:

- In this post, I'll go through the resources I used to learn about neural networks, LLMs, and inference.
- In the next post, I'll walk through building and optimizing the application.

The first thing I did was pick the paper that started all of this: "[**Attention Is All You Need**](https://arxiv.org/abs/1706.03762)." I used NotebookLM to go deep on it. Highly recommended. Reading that paper opened up a lot of questions, and from there I knew what to look for.

**PyTorch** was next. I had heard a lot about it, but never actually looked into it. [The docs](https://docs.pytorch.org/tutorials/beginner/basics/intro.html) are great. Previous experience with `numpy` made the ideas easy to pick up, but the best part was the pointer to [3Blue1Brown's neural networks playlist](https://www.youtube.com/watch?v=aircAruvnKk&list=PLZHQObOWTQDNU6R1_67000Dx_ZCJB-3pi). That one is essential. It gave me the foundation I needed to read further and actually understand the material.

A lot of reading followed. Most of my focus was on running models on the edge. These were the most useful resources I found:

- Inference
  - [What is LLM inference?](https://handbook.modular.com/llm-inference-basics/what-is-llm-inference/)
  - [Training vs. inference](https://handbook.modular.com/llm-inference-basics/training-inference-differences/)
  - [What is LLM Inference, its challenges and solutions for it - Hugging Face](https://huggingface.co/blog/Kseniase/inference)
  - [TensorFlow.js](https://www.tensorflow.org/js)
- Neural networks
  - [Why are Transformers replacing CNNs? (Video)](https://www.youtube.com/watch?v=KnCRTP11p5U&list=LL&index=46)
- Models
  - [How to Use Hugging Face: Beginner's Guide to AI Models](https://www.codecademy.com/article/getting-started-with-hugging-face)
  - [How to Use Hugging Face Pretrained Model](https://www.geeksforgeeks.org/deep-learning/how-to-use-hugging-face-pretrained-model/)
  - [Let's build GPT: from scratch, in code, spelled out (Video)](https://www.youtube.com/watch?v=kCc8FmEb1nY&list=PLdZ_SnQNrIjE&index=10)
  - [gguf-docs](https://github.com/iuliaturc/gguf-docs)
  - [Reverse-engineering GGUF | Post-Training Quantization (Video)](https://www.youtube.com/watch?v=vW30o4U9BFE)
  - [Use and share pre-trained models - Kaggle](https://www.kaggle.com/docs/models)
  - [How LLMs survive in low precision | Quantization Fundamentals (Video)](https://www.youtube.com/watch?v=qoQJq5UwV1c)
- Hardware
  - [CUDA vs ROCm vs Vulkan vs Metal](https://orchestrator.dev/blog/2026-05-24-gpu-compute-platforms-comparison/)
  - [Mastering LLM Techniques: Training - NVIDIA](https://developer.nvidia.com/blog/mastering-llm-techniques-training/)
- Inference engines
  - [How the vLLM inference engine works? (Video)](https://www.youtube.com/watch?v=5Y_JM6C9xOA)
  - [What Is Llama.cpp? The LLM Inference Engine for Local AI (Video)](https://www.youtube.com/watch?v=P8m5eHAyrFM)
  - [Llama.cpp vs vLLM: Which Local LLM Engine Actually Scales? (Video)](https://www.youtube.com/watch?v=0ujh7hfutq0)
  - [The KV Cache: Memory Usage in Transformers (Video)](https://www.youtube.com/watch?v=80bIUggRJf4)
  - [Inference at the edge](https://github.com/ggml-org/llama.cpp/discussions/205)
  - [ONNX Runtime for Inferencing](https://onnxruntime.ai/docs/)

---

With that base, I shifted toward voice models, specifically **Whisper**. The plan was to run this on a small SoC like a Raspberry Pi, so I focused on [whisper.cpp](https://github.com/ggml-org/whisper.cpp) from the start. It's easy to build and run, and the bundled tools make it straightforward to try quantization.

These were the most useful materials on that side:

- Voice models
  - [Quantization for OpenAI's Whisper Models: A Comparative Analysis](https://www.alphaxiv.org/abs/2503.09905)
  - [Speech LLMs: Models that listen and talk back (Video)](https://www.youtube.com/watch?v=MyxgEx4_Moo)
  - [Voice activity detection (VAD)](https://developers.openai.com/api/docs/guides/realtime-vad)
  - [Speech Commands: A Dataset for Limited-Vocabulary Speech Recognition](https://arxiv.org/pdf/1804.03209)
  - [Google Speech Commands](https://www.kaggle.com/datasets/neehakurelli/google-speech-commands)
- Projects
  - [Moonshine Voice](https://github.com/moonshine-ai/moonshine)
  - [Silero VAD: pre-trained enterprise-grade Voice Activity Detector](https://github.com/snakers4/silero-vad)

These resources did the most to get the theory off the ground. In the next post, I'll cover the process of building an optimized voice assistant.