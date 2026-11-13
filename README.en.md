# Jarvis Local — your 100% on-device voice assistant

[![Jarvis Local](guia/assets/banner-en.jpg)](https://inematds.github.io/jarvis-local/guia/en/)

**🇧🇷 [Português](README.md) · 🇺🇸 [English](README.en.md) · 🇪🇸 [Español](README.es.md)**

## What it is

Jarvis Local is an open kit from ARCKHÉ for building a personal assistant you call by voice (“Jarvis, …”) that runs entirely on your computer: the brain (an open AI model in Ollama), the cloned voice (VoiceStudio), and the ears (Whisper). It answers using your own notes, shown in a 3D galaxy, and adds new notes when you ask. No subscription, no API account, and no sending audio outside your machine. **Requires a GPU** (NVIDIA graphics card, Apple Silicon Mac, or unified-memory mini PC) and Claude Code or Codex to build it once using the kit’s 8 prompts.

## 📖 User guide

Complete guide (landing page + walkthrough): **https://inematds.github.io/jarvis-local/guia/en/**

## ⚠️ Runs on a GPU — read first

| Runs well | Not suitable for voice conversations |
|---|---|
| Apple Silicon Mac (16 GB+, ideally 32 GB) | Cloud VPS / server without a GPU |
| PC with an NVIDIA graphics card (12 GB+ VRAM, ideally 16–32 GB) | 8 GB laptop without a graphics card |
| Unified-memory mini PC (AMD Ryzen AI Max+, NVIDIA DGX Spark) | Graphics card with less than 12 GB VRAM (simple conversation only) |

Without a GPU, the brain responds at 2–5 words per second — too slow for conversation. The installer checks automatically and stops with an explanation. Details in [REQUISITOS.en.md](REQUISITOS.en.md).

## Which brain for which machine

| Memory (unified or VRAM) | Brain the installer downloads |
|---|---|
| 16 GB | `qwen3.5:9b` |
| 24 GB | `gemma4:12b` |
| 32 GB | `qwen3.8:27b` |
| 64 GB | `gemma4:31b` |
| 96 GB or more | `gpt-oss:120b` (+ `qwen3.5:9b` for quick conversation) |

Full table (gpt-oss:20b, gemma4:26b-a4b, llama4:scout, qwen3.5:122b-a10b…) in [MODELOS.en.md](MODELOS.en.md).

## The process, start to finish

🧠 = you in Claude Code/Codex (once) · 🙋 = you, hands-on · ⚙️ = kit script · 🗣️ = you using the assistant

| # | Step | Command / what happens | Who |
|---|---|---|---|
| 0 | Prerequisites | Python 3.10+ and curl; on Ubuntu/Debian, `sudo apt install -y python3-venv curl` (the installer checks and notifies you) | 🙋 |
| 1 | Download the kit | `git clone https://github.com/inematds/jarvis-local.git && cd jarvis-local` | ⚙️ |
| 2 | Simulate the installation | `bash instalar/instalar.sh --simular` (Mac/Linux) or `powershell -ExecutionPolicy Bypass -File instalar\instalar.ps1 -Simular` (Windows): shows the GPU, memory, and selected model without installing anything | ⚙️ |
| 3 | Install the 3 engines | Same command without `--simular`: Ollama + model, Whisper (faster-whisper or mlx-whisper; with cuBLAS/cuDNN on NVIDIA), and VoiceStudio; saves `~/.jarvis-local/minha-maquina.json` with the brain tag and kit Python | ⚙️ |
| 4 | Create the voice | In VoiceStudio: install the **VoxCPM2** engine (speaks Portuguese, Apache-2.0) and clone YOUR voice in a profile called **Jarvis** (10–20 s, no echo) | 🙋 |
| 5 | Verify | `python3 instalar/verificar.py` → brain ✓ (with response time), ears ✓, voice ✓ | ⚙️ |
| 6 | Build | Open Claude Code (or Codex) in an empty folder and paste prompts **01 → 08** in order, one at a time, waiting for each to finish and prove itself | 🧠 |
| 7 | Measure | Prompt 07 creates `verificar_tudo.py`: listen X s · think Y s · speak Z s on YOUR machine | ⚙️ |
| 8 | Prove it | Prompt 08 runs the test offline: turn off Wi-Fi, ask a question, and the list of external connections must be empty | ⚙️ |
| 9 | Use it | “Jarvis, …” to ask about your notes; “make a note that…” to save one; “switch to the large one” to change brains | 🗣️ |

## The 8 prompts

| # | Prompt | What it builds |
|---|---|---|
| 01 | [The galaxy and the local brain](prompts/en/01-galaxia-e-cerebro.md) | 3D galaxy of your notes + questions answered by the local model |
| 02 | [The cloned voice](prompts/en/02-voz-clonada.md) | Every answer spoken in your voice, in chunks without stuttering |
| 03 | [Local ears](prompts/en/03-ouvidos-locais.md) | Say “Jarvis” to call it, “stop” to interrupt, audio that stays in the room |
| 04 | [Lean personality](prompts/en/04-personalidade-enxuta.md) | A character that fits in a small model, with a short, fast prompt |
| 05 | [Growing memory](prompts/en/05-memoria-que-cresce.md) | “Make a note that…” becomes a new note in the galaxy, live |
| 06 | [Switch brains by speaking](prompts/en/06-troca-de-cerebro.md) | Local, large, or cloud (optional) — by voice, with an on-screen badge |
| 07 | [The verifier](prompts/en/07-verificador-de-latencia.md) | Tests everything for real and measures your machine’s response time |
| 08 | [The offline test](prompts/en/08-teste-sem-internet.md) | Proves nothing leaves your machine, with Wi-Fi turned off |

## What’s in this repository

```
instalar/instalar.sh     Mac + Linux installer (detects GPU and memory, selects the model)
instalar/instalar.ps1    Windows installer (NVIDIA)
instalar/verificar.py    checks brain, ears, and voice, and measures the first response
prompts/01..08           build prompts (PT; versions in prompts/en and prompts/es)
config.exemplo.json      sample config.json used by the assistant
REQUISITOS.md            GPU, memory, and where it doesn’t run
MODELOS.md               model table by machine
guia/                    user guide page (PT/EN/ES)
```

## Precautions

- **Clone only your own voice** or someone else’s with their permission. Cloning a famous person’s voice for something public is a legal problem, not a technical one.
- **Pin versions** (model, voice engine). “Latest” is how an assistant that worked breaks on a Tuesday.
- Ollama `-cloud` tags run in the cloud: the installer refuses them.
- Claude Code/Codex is used only to **build**. Once it’s ready, the assistant runs without them and without internet.

## License

MIT — see [LICENSE](LICENSE). The models and VoiceStudio have their own licenses (VoiceStudio: AGPL-3.0; VoxCPM2: Apache-2.0).

---

Made by **[ARCKHÉ.AI](https://linnoff88-dev.github.io/arckhe-ai)**.
