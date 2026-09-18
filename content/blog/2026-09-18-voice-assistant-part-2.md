+++
title = "Always-on listening for an offline voice assistant"
date = "2026-09-18T17:07:00.000Z"
tags = [ "ai", "llm", "voice", "audio", "python", "c++" ]
+++

This is the second post in the series on creating an offline voice assistant. The [first post](https://arashtaher.com/blog/learning-local-llms-for-an-offline-voice-assistant/) covered the learning path. This one covers the initial steps for an always-on listening application.

## Capture, then transcribe

I started by recording audio in 5-second blocks after a wake word, saving each block as a `.wav` file, then sending it to another process to be transcribed with `whisper.cpp`. I used `PyAudio` for capture and a locally compiled `whisper.cpp` binary with the `tiny.en` model. The Whisper call was a new process via Python's `subprocess` module.

That worked. I then sat down with an AI pair-programmer and listed the obvious shortcomings:

1. **Constant writes to disk.** Each chunk was written to a temporary `.wav` and read back for transcription. That is I/O overhead on a path that needs to stay snappy.
2. **Reloading model weights on every request.** Forking `whisper.cpp` per request meant the process had to load the whole model into RAM every time.

To remove the file I/O, I wrote a small C++ library (`whisper_edge.so`) that loads the model once at startup. `pybind11` is the bridge from the Python app into that library. If you have not used it: [this video](https://www.youtube.com/watch?v=_5T70cAXDJ0) is a solid walkthrough.

From Python I now pass a pointer to the in-memory audio buffer. No temp file. That zero-copy path dropped overall transcription latency from \~400ms to \~80ms.

While chasing latency I also cut the memory footprint. Whisper weights in `whisper.cpp` can be quantized after training. I used the project's quantize tool to go from FP16 weights to 8-bit integers (`q8_0`). The quantized model dropped the active footprint from \~240MB to \~190MB. Moving from 16-bit floats to 8-bit ints also cuts the volume of weight data that has to move through memory during inference roughly in half.

## No need to wake up

The original idea was an Alexa clone. For that I started with [openWakeWord](https://github.com/dscripka/openWakeWord): The system would activate on a wake word, then send whatever followed to Whisper (one unresolved challenge here was to stop recording when there's a pause)

I got that working, then changed the objective: an always-listening device that captures all conversations. If you own the hardware and there's no internet connection, why not listen to everything?

That meant swapping the wake-word detector for voice activity detection ([VAD](https://en.wikipedia.org/wiki/Voice_activity_detection)). The best model I found was [Silero VAD](https://github.com/snakers4/silero-vad). The samples worked as expected: Audio capture started when I started speaking.

The problem: the default Silero path depends on PyTorch. That is not acceptable here. I want this on a small edge device. PyTorch takes roughly 300MB sitting idle, and startup is slow. Good news is, Silero also ships an ONNX model at about 2MB.

I tried the ONNX file first and hit an error: `Invalid input tensor shape: expected 'state' tensor of shape [2, 1, 128] text`

So the model expects a recurrent `state` tensor across frames. That led me to the ONNX path in `load_silero_vad`, then to the `OnnxWrapper`[ class](https://github.com/snakers4/silero-vad/blob/master/src/silero_vad/utils_vad.py#L10), and from there to `VADIterator`.

How it actually splits:

- The ONNX graph is stateful. Each frame needs the previous state, shape `[2, 1, 128]`, plus a short audio context window. `OnnxWrapper` is what feeds that state in and writes the updated state back out.
- `VADIterator` sits on top of the model. It does not store the state weights or hidden state. It tracks speech onset/offset (triggered flag, silence timer, sample cursor) and decides when an audio starts and ends. (There's keyword here to check: LSTM. I didn't spend much time it. Something for the future)

A bit of back and forth with AI, and I replaced the PyTorch stack: `onnxruntime` runs the model; a NumPy array of zeros with shape `[2, 1, 128]` is the state block across frames. That array is passed in as `state` on every call, and the output state is written back into the same buffer for the next frame.

The result is an always-running process that listens to the room. When there is speech it captures the segment and transcribes it. That closes the first phase of the project.

[Here's](https://github.com/arashThr/voice-assistance/tree/b02881e3c1e9ee900ee9e16327c9d9d7eca68871) the codebase at the current commit of everything I'm gone through so far that you can check.

Two paths from here:

1. A local LLM that consumes the text.
2. A way to answer specific actions in voice.

Let's see how it goes.