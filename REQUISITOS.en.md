# Requirements — needs a GPU (or unified memory)

Jarvis Local runs three things **at the same time**, and they all stay in memory: the **brain** (language model), the **voice** (speech engine), and the **ears** (Whisper). The brain is by far the largest. So the question isn’t “which computer is faster?” but **how much memory the model can see**.

## Where it runs well

| Machine | What counts | Notes |
|---|---|---|
| **Apple Silicon Mac** (M1 or later) | unified memory | The CPU, GPU, and neural engine share the same memory. 16 GB is the minimum; 32 GB is the sweet spot. |
| **PC with an NVIDIA card** (Windows or Linux) | **card VRAM** | Only the card’s memory counts; the PC’s RAM doesn’t. 16 GB VRAM = 9B–12B models; 32 GB (RTX 5090) = 27B. |
| **Mini PC with unified memory** (AMD Ryzen AI Max+ 395, NVIDIA DGX Spark/GB10) | unified memory | 128 GB can fit 100B+ models. Slower per word than a dedicated card, but it can fit a much larger brain. On AMD, allocate as much memory as possible to the GPU in the BIOS. |

## Where it does NOT run (for voice conversations)

- **VPS / cloud server without a GPU.** Most have 2–4 vCPUs and 4–16 GB of RAM. A 9B model won’t even fit in 4 GB, and on the CPU it responds at 2–5 words per second — too slow for a conversation. The ears (small Whisper) and a lightweight ready-made voice can still run; the brain can’t.
- **Regular laptop with 8 GB and no dedicated GPU.** Only 2–4B models, which are fine for small talk, not for a real assistant.
- **Graphics card with less than 12 GB VRAM.** It can only fit a simple conversation model; with 8 GB or less, the model spills over into RAM and everything gets slow.

The installer checks this automatically: without an NVIDIA GPU, Apple Silicon, or an AMD GPU with ROCm, it **stops and explains** instead of installing something that will disappoint. To force it anyway (for testing only): `--forcar-cpu`.

## The rule of thumb

A 4-bit model takes up **~0.6 GB per billion parameters**. Leave **~30% of memory free** for the system, the conversation (the context grows as you talk), the voice, and Whisper. By estimate, the voice (VoxCPM2) and the two Whisper models (large-v3-turbo + small) together use about 4–6 GB on the same card; measure with `nvidia-smi` after everything has loaded.

| Memory (unified or VRAM) | Largest comfortable brain |
|---|---|
| 8 GB | ~4B (simple conversations only) |
| 16 GB | ~9B to 12B |
| 32 GB | ~27B to 35B |
| 64 GB | ~31B + room for a 2nd model |
| 96–128 GB | ~120B (mixture of experts) |
| 256 GB | 120B+ with the whole team loaded alongside it |

**After memory, the most important factor is its read speed (bandwidth).** The model generates words as fast as the chip can read its own memory. That’s why a Mac Studio with an Ultra chip or an RTX 5090 responds faster than a mini PC with the same memory. CPU cores make almost no difference.

## Disk

Each model takes up 2 to 80 GB. Models can live on an external SSD without any problem.

## Software

- **NVIDIA card:** driver installed (the `nvidia-smi` command must work).
- **VoiceStudio on Linux:** it is an AppImage at `~/.local/bin/VoiceStudio`; Ubuntu needs `libfuse2t64` (24.04) or `libfuse2` (22.04).
- Python 3.10+, curl, and Google Chrome (or another browser with a microphone). On Ubuntu/Debian: `sudo apt install -y python3-venv curl` (the Ollama installer asks for `sudo`).
- **NVIDIA card on Linux/Windows:** the installer puts the Whisper CUDA libraries in the venv (`nvidia-cublas-cu12`, `nvidia-cudnn-cu12` 9.x). Without them, faster-whisper reports `libcudnn_ops.so.9 not found` or falls back to the CPU.
- **Claude Code or Codex** only to **build** the assistant with the prompts (once). Once it’s ready, the assistant runs without them and without internet.
