# Models — which brain for which machine

All open and free, downloaded through [Ollama](https://ollama.com/library). Sizes verified in the Ollama library on 11/04/2026 (4-bit versions). The installer chooses automatically based on your memory; you can switch with `--modelo <tag>`.

> ⚠️ **Do not use tags ending in `-cloud`** (e.g., `gpt-oss:120b-cloud`): they run on Ollama’s servers, not on your machine.

## Table

| Model (Ollama tag) | Parameters | Download | Runs well on | Why choose it |
|---|---|---|---|---|
| `gemma4:e4b` | ~4B | ~7 GB | 8–12 GB | Simple conversation. Leave the heavy thinking to a bigger brain. |
| `qwen3.5:9b` | 9B dense | ~7 GB | **16 GB** (minimum) | The kit’s default brain. A real assistant that answers from your notes and maintains a personality. Thinks behind the scenes: the kit disables this with `reasoning_effort: none`. |
| `gemma4:12b` | 12B dense | ~8 GB | 24 GB (on a 16 GB card, it’s tight with voice and Whisper: use `--modelo`) | Smarter, follows rules better, and **can see images** (it can look at a screenshot). |
| `gpt-oss:20b` | 21B, 3.6B active | 14 GB | 24–32 GB | Fast because only a slice of the model works on each word. |
| `qwen3.8:27b` | 27B dense | 18 GB | **32 GB** (sweet spot), RTX 5090 | The best brain that fits on a 32 GB machine. Apache 2.0 license. |
| `gemma4:26b-a4b` | 26B, 4B active | 16–19 GB | 32 GB | For those who want speed over depth. Long context (256K). |
| `gemma4:31b` | 31B dense | ~20 GB | 64 GB | Fits in 32 GB at the limit; comfortable in 64 GB. |
| `gpt-oss:120b` | 117B, 5.1B active | 65 GB | 96–128 GB | “Cloud-class” reasoning at home. |
| `llama4:scout` | 109B, 17B active | 67 GB | 96 GB+ | Multimodal, very long context. |
| `qwen3.5:122b-a10b` | 122B, 10B active | 81 GB | 128 GB+ | The biggest brain on this list that still responds quickly. |

## Dense × active

“27B dense” = all 27 billion parameters work on every word. “117B, 5.1B active” = **mixture of experts**: the whole model has to fit in memory, but only ~5 billion parameters work per word, so it responds faster than its size suggests. For voice conversations, a large mixture-of-experts model is often a better buy than a medium-sized dense model.

## What the installer chooses

| Detected memory | Main brain | Fast conversation brain |
|---|---|---|
| < 12 GB | `gemma4:e4b` (with warning) | — |
| 12–19 GB | `qwen3.5:9b` | — |
| 20–27 GB | `gemma4:12b` | `qwen3.5:9b` |
| 28–59 GB | `qwen3.8:27b` | `qwen3.5:9b` |
| 60–89 GB | `gemma4:31b` | `qwen3.5:9b` |
| 90 GB or more | `gpt-oss:120b` | `qwen3.5:9b` |

The installer does not choose `llama4:scout` or `qwen3.5:122b-a10b` automatically: use `--modelo` if you have 128 GB or more.

“Detected memory” = NVIDIA GPU VRAM, or total memory on Macs and unified-memory machines.

## Two cautions

1. **“It fits with 2 GB to spare” means it doesn’t fit.** Context grows during the conversation, voice and Whisper need a few GB, and the machine starts using disk storage — everything freezes. Use the 30% free rule.
2. **Bigger doesn’t always mean a better assistant.** A 27B model follows a short set of regulations better than a 120B model follows a long one. Prompt 04 exists for this reason.
