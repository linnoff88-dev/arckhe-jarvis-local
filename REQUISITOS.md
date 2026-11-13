# Requisitos — precisa de GPU (ou memória unificada)

O Jarvis Local roda três coisas **ao mesmo tempo** e todas ficam na memória: o **cérebro** (modelo de linguagem), a **voz** (motor de fala) e os **ouvidos** (Whisper). O cérebro é de longe o maior. Por isso a pergunta não é "qual computador é mais rápido", e sim **quanta memória o modelo enxerga**.

## Onde roda bem

| Máquina | O que conta | Observação |
|---|---|---|
| **Mac com Apple Silicon** (M1 em diante) | memória unificada | CPU, GPU e motor neural dividem a mesma memória. 16 GB é o piso; 32 GB é o ponto doce. |
| **PC com placa NVIDIA** (Windows ou Linux) | **VRAM da placa** | Só a memória da placa conta, a RAM do PC não. 16 GB de VRAM = modelos de 9B–12B; 32 GB (RTX 5090) = 27B. |
| **Mini PC com memória unificada** (AMD Ryzen AI Max+ 395, NVIDIA DGX Spark/GB10) | memória unificada | 128 GB cabem modelos de 100B+. Mais lento por palavra que uma placa dedicada, mas cabe cérebro muito maior. No AMD, libere o máximo de memória para a GPU na BIOS. |

## Onde NÃO roda (para conversa por voz)

- **VPS / servidor na nuvem sem GPU.** A maioria tem 2–4 vCPU e 4–16 GB de RAM. Um modelo de 9B nem cabe em 4 GB, e na CPU responde a 2–5 palavras por segundo — lento demais para conversar. Ouvidos (Whisper pequeno) e uma voz pronta leve até rodam; o cérebro, não.
- **Notebook comum com 8 GB e sem GPU dedicada.** Só modelos de 2–4B, que servem para conversa fiada, não para um assistente de verdade.
- **Placa de vídeo com menos de 12 GB de VRAM.** Só cabe modelo de conversa simples; com 8 GB ou menos o modelo transborda para a RAM e tudo fica lento.

O instalador confere isso sozinho: sem GPU NVIDIA, sem Apple Silicon e sem GPU AMD com ROCm, ele **para e explica** em vez de instalar algo que vai decepcionar. Para forçar mesmo assim (só para testar): `--forcar-cpu`.

## A regra de bolso

Um modelo em 4 bits ocupa **~0,6 GB por bilhão de parâmetros**. Deixe **~30% da memória livre** para o sistema, a conversa (o contexto cresce enquanto você fala), a voz e o Whisper. Por estimativa, a voz (VoxCPM2) e os dois Whisper (large-v3-turbo + small) ocupam juntos uns 4–6 GB na mesma placa; meça com `nvidia-smi` depois de tudo carregado.

| Memória (unificada ou VRAM) | Maior cérebro confortável |
|---|---|
| 8 GB | ~4B (só conversa simples) |
| 16 GB | ~9B a 12B |
| 32 GB | ~27B a 35B |
| 64 GB | ~31B + espaço para um 2º modelo |
| 96–128 GB | ~120B (mistura de especialistas) |
| 256 GB | 120B+ com toda a equipe carregada ao lado |

**O que mais importa depois da memória é a velocidade de leitura dela (largura de banda).** O modelo gera palavras tão rápido quanto o chip consegue ler a própria memória. Por isso um Mac Studio com chip Ultra ou uma RTX 5090 respondem mais rápido que um mini PC com a mesma memória. Núcleos de CPU quase não fazem diferença.

## Disco

Cada modelo ocupa de 2 a 80 GB. Modelos podem morar num SSD externo sem problema.

## Software

- **Placa NVIDIA:** driver instalado (o comando `nvidia-smi` tem de funcionar).
- **VoiceStudio no Linux:** é um AppImage em `~/.local/bin/VoiceStudio`; no Ubuntu precisa de `libfuse2t64` (24.04) ou `libfuse2` (22.04).
- Python 3.10+, curl e Google Chrome (ou outro navegador com microfone). No Ubuntu/Debian: `sudo apt install -y python3-venv curl` (o instalador do Ollama pede `sudo`).
- **Placa NVIDIA no Linux/Windows:** o instalador põe no venv as bibliotecas CUDA do Whisper (`nvidia-cublas-cu12`, `nvidia-cudnn-cu12` 9.x). Sem elas o faster-whisper dá `libcudnn_ops.so.9 not found` ou cai para a CPU.
- **Claude Code ou Codex** só para **construir** o assistente com os prompts (uma vez). Depois de pronto, o assistente roda sem eles e sem internet.
