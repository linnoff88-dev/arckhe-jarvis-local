# Modelos — qué cerebro elegir para cada máquina

Todos son abiertos, gratuitos y se descargan con [Ollama](https://ollama.com/library). Tamaños comprobados en la biblioteca de Ollama el 04/11/2026 (versiones de 4 bits). El instalador elige automáticamente según tu memoria; puedes cambiarlo con `--modelo <tag>`.

> ⚠️ **No uses tags terminados en `-cloud`** (por ejemplo, `gpt-oss:120b-cloud`): se ejecutan en los servidores de Ollama, no en tu máquina.

## Tabla

| Modelo (tag de Ollama) | Parámetros | Descarga | Funciona bien en | Por qué elegirlo |
|---|---|---|---|---|
| `gemma4:e4b` | ~4B | ~7 GB | 8–12 GB | Conversación sencilla. Deja el trabajo pesado de razonamiento para un cerebro más grande. |
| `qwen3.5:9b` | 9B denso | ~7 GB | **16 GB** (mínimo) | El cerebro predeterminado del kit. Un asistente de verdad: responde a partir de tus notas y mantiene su personalidad. Piensa en segundo plano: el kit lo desactiva con `reasoning_effort: none`. |
| `gemma4:12b` | 12B denso | ~8 GB | 24 GB (en una tarjeta de 16 GB queda al límite con voz y Whisper: usa `--modelo`) | Más inteligente, sigue mejor las reglas y **ve imágenes** (puede mirar una captura). |
| `gpt-oss:20b` | 21B, 3,6B activos | 14 GB | 24–32 GB | Es rápido porque solo una parte del modelo trabaja en cada palabra. |
| `qwen3.8:27b` | 27B denso | 18 GB | **32 GB** (punto ideal), RTX 5090 | El mejor cerebro que cabe en una máquina de 32 GB. Licencia Apache 2.0. |
| `gemma4:26b-a4b` | 26B, 4B activos | 16–19 GB | 32 GB | Para quienes prefieren velocidad a profundidad. Contexto largo (256K). |
| `gemma4:31b` | 31B denso | ~20 GB | Cabe en 32 GB al límite; funciona cómodamente con 64 GB. |
| `gpt-oss:120b` | 117B, 5,1B activos | 65 GB | 96–128 GB | Razonamiento de nivel «nube» en casa. |
| `llama4:scout` | 109B, 17B activos | 67 GB | 96 GB+ | Multimodal, contexto muy largo. |
| `qwen3.5:122b-a10b` | 122B, 10B activos | 81 GB | 128 GB+ | El cerebro más grande de esta lista que aún responde rápido. |

## Denso × activos

«27B denso» = los 27.000 millones de parámetros trabajan en cada palabra. «117B, 5,1B activos» = **mezcla de expertos**: el modelo completo debe caber en la memoria, pero solo ~5.000 millones trabajan por palabra, así que responde más rápido de lo que su tamaño sugiere. Para conversar por voz, un modelo grande de expertos suele ser mejor opción que uno denso mediano.

## Qué elige el instalador

| Memoria detectada | Cerebro principal | Cerebro para conversar rápido |
|---|---|---|
| < 12 GB | `gemma4:e4b` (con aviso) | — |
| 12–19 GB | `qwen3.5:9b` | — |
| 20–27 GB | `gemma4:12b` | `qwen3.5:9b` |
| 28–59 GB | `qwen3.8:27b` | `qwen3.5:9b` |
| 60–89 GB | `gemma4:31b` | `qwen3.5:9b` |
| 90 GB o más | `gpt-oss:120b` | `qwen3.5:9b` |

El instalador no elige automáticamente `llama4:scout` ni `qwen3.5:122b-a10b`: usa `--modelo` si tienes 128 GB o más.

«Memoria detectada» = VRAM de la tarjeta NVIDIA, o la memoria total en Mac y máquinas con memoria unificada.

## Dos precauciones

1. **«Cabe y sobran 2 GB» no significa que vaya a funcionar.** El contexto crece durante la conversación, la voz y Whisper necesitan algunos GB, y la máquina empieza a usar el disco: todo se ralentiza. Usa la regla del 30 % libre.
2. **Un modelo más grande no siempre es mejor asistente.** Un 27B sigue mejor un reglamento corto que un 120B uno largo. El prompt 04 existe por eso.
