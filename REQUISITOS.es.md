# Requisitos — necesita GPU (o memoria unificada)

Jarvis Local ejecuta tres cosas **al mismo tiempo** y todas permanecen en la memoria: el **cerebro** (modelo de lenguaje), la **voz** (motor de habla) y los **oídos** (Whisper). El cerebro es, por mucho, el componente más grande. Por eso la pregunta no es «qué computadora es más rápida», sino **cuánta memoria puede usar el modelo**.

## Dónde funciona bien

| Máquina | Qué cuenta | Observación |
|---|---|---|
| **Mac con Apple Silicon** (M1 en adelante) | memoria unificada | La CPU, la GPU y el motor neuronal comparten la misma memoria. 16 GB es el mínimo; 32 GB es el punto ideal. |
| **PC con tarjeta NVIDIA** (Windows o Linux) | **VRAM de la tarjeta** | Solo cuenta la memoria de la tarjeta, no la RAM de la PC. 16 GB de VRAM = modelos de 9B–12B; 32 GB (RTX 5090) = 27B. |
| **Mini PC con memoria unificada** (AMD Ryzen AI Max+ 395, NVIDIA DGX Spark/GB10) | memoria unificada | En 128 GB caben modelos de más de 100B. Es más lento por palabra que una tarjeta dedicada, pero permite usar un cerebro mucho más grande. En AMD, libera la mayor cantidad posible de memoria para la GPU en la BIOS. |

## Dónde NO funciona (para conversar por voz)

- **VPS / servidor en la nube sin GPU.** La mayoría tiene entre 2 y 4 vCPU y entre 4 y 16 GB de RAM. Un modelo de 9B ni siquiera cabe en 4 GB y, en la CPU, responde a entre 2 y 5 palabras por segundo: demasiado lento para conversar. Los oídos (Whisper pequeño) y una voz lista y liviana pueden funcionar; el cerebro, no.
- **Notebook común con 8 GB y sin GPU dedicada.** Solo admite modelos de 2–4B, que sirven para una charla trivial, no para un asistente de verdad.
- **Tarjeta de video con menos de 12 GB de VRAM.** Solo admite un modelo para conversaciones simples; con 8 GB o menos, el modelo se desborda a la RAM y todo se vuelve lento.

El instalador lo comprueba automáticamente: si no hay GPU NVIDIA, Apple Silicon ni GPU AMD con ROCm, **se detiene y explica por qué**, en vez de instalar algo que decepcionará. Para forzarlo de todos modos (solo para probar): `--forcar-cpu`.

## La regla práctica

Un modelo de 4 bits ocupa **~0,6 GB por cada mil millones de parámetros**. Deja **~30% de la memoria libre** para el sistema, la conversación (el contexto crece mientras hablas), la voz y Whisper. Se estima que la voz (VoxCPM2) y los dos Whisper (large-v3-turbo + small) ocupan juntos unos 4–6 GB en la misma tarjeta; mide el uso con `nvidia-smi` cuando todo esté cargado.

| Memoria (unificada o VRAM) | Cerebro más grande que funciona cómodamente |
|---|---|
| 8 GB | ~4B (solo conversaciones simples) |
| 16 GB | ~9B a 12B |
| 32 GB | ~27B a 35B |
| 64 GB | ~31B + espacio para un segundo modelo |
| 96–128 GB | ~120B (mezcla de expertos) |
| 256 GB | más de 120B con todo el equipo cargado al mismo tiempo |

**Después de la memoria, lo que más importa es su velocidad de lectura (ancho de banda).** El modelo genera palabras tan rápido como el chip puede leer su propia memoria. Por eso, un Mac Studio con chip Ultra o una RTX 5090 responde más rápido que una mini PC con la misma memoria. Los núcleos de CPU casi no hacen diferencia.

## Disco

Cada modelo ocupa entre 2 y 80 GB. Los modelos pueden guardarse sin problema en un SSD externo.

## Software

- **Tarjeta NVIDIA:** driver instalado (el comando `nvidia-smi` tiene que funcionar).
- **VoiceStudio en Linux:** es un AppImage en `~/.local/bin/VoiceStudio`; Ubuntu necesita `libfuse2t64` (24.04) o `libfuse2` (22.04).
- Python 3.10+, curl y Google Chrome (u otro navegador con micrófono). En Ubuntu/Debian: `sudo apt install -y python3-venv curl` (el instalador de Ollama pide `sudo`).
- **Tarjeta NVIDIA en Linux/Windows:** el instalador coloca en el venv las bibliotecas CUDA de Whisper (`nvidia-cublas-cu12`, `nvidia-cudnn-cu12` 9.x). Sin ellas, faster-whisper muestra `libcudnn_ops.so.9 not found` o recurre a la CPU.
- **Claude Code o Codex** solo para **construir** el asistente con los prompts (una vez). Después de estar listo, el asistente funciona sin ellos y sin internet.
