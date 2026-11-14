# Jarvis Local — tu asistente de voz 100% en tu máquina

[![Jarvis Local](guia/assets/banner-es.jpg)](https://inematds.github.io/jarvis-local/guia/es/)

**🇧🇷 [Português](README.md) · 🇺🇸 [English](README.en.md) · 🇪🇸 [Español](README.es.md)**

## Qué es

Jarvis Local es un kit abierto de INEMA para crear un asistente personal al que llamas por voz («Jarvis, …») y que funciona por completo en tu computadora: el cerebro (un modelo de IA abierto en Ollama), la voz clonada (VoiceStudio) y los oídos (Whisper). Responde a partir de tus propias notas, que se muestran en una galaxia 3D, y guarda notas nuevas cuando se lo pides. Sin suscripción, sin cuenta de API y sin enviar el audio al exterior. **Necesitas una GPU** (tarjeta NVIDIA, Mac con Apple Silicon o mini PC con memoria unificada) y Claude Code o Codex para construirlo una sola vez con los 8 prompts del kit.

## 📖 Guía de uso

Guía completa (página de presentación + paso a paso): **https://inematds.github.io/jarvis-local/guia/es/**

🎬 Video: https://www.youtube.com/shorts/dCPinV8Djn0

## ⚠️ Funciona con GPU: lee antes de continuar

| Funciona bien | No sirve para conversar por voz |
|---|---|
| Mac con Apple Silicon (16 GB+, idealmente 32 GB) | VPS / servidor en la nube sin GPU |
| PC con tarjeta NVIDIA (12 GB+ de VRAM, idealmente 16–32 GB) | Portátil de 8 GB sin tarjeta gráfica |
| Mini PC con memoria unificada (AMD Ryzen AI Max+, NVIDIA DGX Spark) | Tarjeta con menos de 12 GB de VRAM (solo conversaciones sencillas) |

Sin GPU, el cerebro responde de 2 a 5 palabras por segundo: demasiado lento para conversar. El instalador lo comprueba automáticamente y se detiene con una explicación. Más detalles en [REQUISITOS.es.md](REQUISITOS.es.md).

## Qué cerebro elegir para cada máquina

| Memoria (unificada o VRAM) | Cerebro que descarga el instalador |
|---|---|
| 16 GB | `qwen3.5:9b` |
| 24 GB | `gemma4:12b` |
| 32 GB | `qwen3.8:27b` |
| 64 GB | `gemma4:31b` |
| 96 GB o más | `gpt-oss:120b` (+ `qwen3.5:9b` para conversaciones rápidas) |

Tabla completa (gpt-oss:20b, gemma4:26b-a4b, llama4:scout, qwen3.5:122b-a10b…) en [MODELOS.es.md](MODELOS.es.md).

## El proceso, de principio a fin

🧠 = tú en Claude Code/Codex (una vez) · 🙋 = tú, manualmente · ⚙️ = script del kit · 🗣️ = tú usando el asistente

| # | Paso | Comando / qué sucede | Quién |
|---|---|---|---|
| 0 | Requisitos previos | Python 3.10+ y curl; en Ubuntu/Debian, `sudo apt install -y python3-venv curl` (el instalador lo comprueba y avisa) | 🙋 |
| 1 | Descargar el kit | `git clone https://github.com/inematds/jarvis-local.git && cd jarvis-local` | ⚙️ |
| 2 | Simular la instalación | `bash instalar/instalar.sh --simular` (Mac/Linux) o `powershell -ExecutionPolicy Bypass -File instalar\instalar.ps1 -Simular` (Windows): muestra la GPU, la memoria y el modelo elegido, sin instalar nada | ⚙️ |
| 3 | Instalar los 3 motores | El mismo comando sin `--simular`: Ollama + modelo, Whisper (faster-whisper o mlx-whisper; en NVIDIA, con cuBLAS/cuDNN) y VoiceStudio; guarda `~/.jarvis-local/minha-maquina.json` con la etiqueta del cerebro y el Python del kit | ⚙️ |
| 4 | Crear la voz | En VoiceStudio: instala el motor **VoxCPM2** (habla portugués, Apache-2.0) y clona TU voz en un perfil llamado **Jarvis** (10–20 s, sin eco) | 🙋 |
| 5 | Verificar | `python3 instalar/verificar.py` → cerebro ✓ (con el tiempo de respuesta), oídos ✓, voz ✓ | ⚙️ |
| 6 | Construir | Abre Claude Code (o Codex) en una carpeta vacía y pega los prompts **01 → 08** en orden, uno a la vez; espera a que cada uno termine y demuestre que funciona | 🧠 |
| 7 | Medir | El prompt 07 crea `verificar_tudo.py`: escuchar X s · pensar Y s · hablar Z s en TU máquina | ⚙️ |
| 8 | Comprobar | El prompt 08 ejecuta la prueba sin internet: apaga el Wi-Fi, haz una pregunta y la lista de conexiones externas debe quedar vacía | ⚙️ |
| 9 | Usar | «Jarvis, …» para preguntar sobre tus notas; «anota que…» para guardar; «cambia al grande» para cambiar de cerebro | 🗣️ |

## Los 8 prompts

| # | Prompt | Qué construye |
|---|---|---|
| 01 | [La galaxia y el cerebro local](prompts/es/01-galaxia-e-cerebro.md) | Galaxia 3D de tus notas + preguntas respondidas por el modelo local |
| 02 | [La voz clonada](prompts/es/02-voz-clonada.md) | Cada respuesta se habla con tu voz, en bloques y sin tartamudeos |
| 03 | [Los oídos locales](prompts/es/03-ouvidos-locais.md) | «Jarvis» para llamar, «para» para interrumpir; el audio no sale de la habitación |
| 04 | [Personalidad compacta](prompts/es/04-personalidade-enxuta.md) | Un personaje que cabe en un modelo pequeño, con un prompt corto y rápido |
| 05 | [Memoria que crece](prompts/es/05-memoria-que-cresce.md) | «Anota que…» se convierte en una nota nueva en la galaxia, en tiempo real |
| 06 | [Cambiar de cerebro por voz](prompts/es/06-troca-de-cerebro.md) | Local, grande o en la nube (opcional): por voz, con una etiqueta en pantalla |
| 07 | [El verificador](prompts/es/07-verificador-de-latencia.md) | Lo prueba todo de verdad y mide el tiempo de tu máquina |
| 08 | [La prueba sin internet](prompts/es/08-teste-sem-internet.md) | Comprueba que nada sale de la máquina, con el Wi-Fi apagado |

## Qué hay en este repositorio

```
instalar/instalar.sh     instalador Mac + Linux (detecta GPU y memoria, elige el modelo)
instalar/instalar.ps1    instalador Windows (NVIDIA)
instalar/verificar.py    comprueba cerebro, oídos y voz, y mide la primera respuesta
prompts/01..08           los prompts de construcción (PT; versiones en prompts/en y prompts/es)
config.exemplo.json      modelo del config.json que usa el asistente
REQUISITOS.md            GPU, memoria y dónde no funciona
MODELOS.md               tabla de modelos por máquina
guia/                    página de guía (PT/EN/ES)
```

## Precauciones

- **Clona solo tu voz** o la de alguien que haya dado su autorización. Clonar la voz de una persona famosa para algo público es un problema legal, no técnico.
- **Fija las versiones** (modelo, motor de voz). «Latest» es como una forma de que un asistente que funcionaba deje de hacerlo un martes.
- **Las etiquetas `-cloud` de Ollama funcionan en la nube**: el instalador las rechaza.
- Claude Code/Codex solo se usa para **construir**. Una vez listo, el asistente funciona sin ellos y sin internet.

## Licencia

MIT: consulta [LICENSE](LICENSE). Los modelos y VoiceStudio tienen sus propias licencias (VoiceStudio: AGPL-3.0; VoxCPM2: Apache-2.0).

---

Hecho por **[INEMA.CLUB](https://inema.club)**.
