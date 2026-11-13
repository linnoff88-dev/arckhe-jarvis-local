# Jarvis Local — seu assistente de voz 100% na sua máquina

[![Jarvis Local](guia/assets/banner.jpg)](https://~~ARCKHÉTDS~~.github.io/jarvis-local/guia/)

**🇧🇷 [Português](README.md) · 🇺🇸 [English](README.en.md) · 🇪🇸 [Español](README.es.md)**

## O que é

O Jarvis Local é um kit aberto do ARCKHÉ para montar um assistente pessoal que você chama pela voz ("Jarvis, …") e que roda inteiro no seu computador: o cérebro (um modelo de IA aberto no Ollama), a voz clonada (VoiceStudio) e os ouvidos (Whisper). Ele responde a partir das suas próprias notas, mostradas numa galáxia 3D, e anota coisas novas quando você pede. Sem assinatura, sem conta de API e sem mandar o áudio para fora. **Precisa de GPU** (placa NVIDIA, Mac com Apple Silicon ou mini PC de memória unificada) e do Claude Code ou Codex para construir, uma vez, com os 8 prompts do kit.

## 📖 Guia de uso

Guia completo (landing + passo a passo): **https://~~ARCKHÉTDS~~.github.io/jarvis-local/guia/**

## ⚠️ Roda em GPU — leia antes

| Roda bem | Não serve para conversar por voz |
|---|---|
| Mac com Apple Silicon (16 GB+, ideal 32 GB) | VPS / servidor na nuvem sem GPU |
| PC com placa NVIDIA (12 GB+ de VRAM, ideal 16–32 GB) | Notebook de 8 GB sem placa de vídeo |
| Mini PC de memória unificada (AMD Ryzen AI Max+, NVIDIA DGX Spark) | Placa com menos de 12 GB de VRAM (só conversa simples) |

Sem GPU, o cérebro responde a 2–5 palavras por segundo — lento demais para conversa. O instalador confere sozinho e para com uma explicação. Detalhes em [REQUISITOS.md](REQUISITOS.md).

## Qual cérebro para qual máquina

| Memória (unificada ou VRAM) | Cérebro que o instalador baixa |
|---|---|
| 16 GB | `qwen3.5:9b` |
| 24 GB | `gemma4:12b` |
| 32 GB | `qwen3.8:27b` |
| 64 GB | `gemma4:31b` |
| 96 GB ou mais | `gpt-oss:120b` (+ `qwen3.5:9b` para conversa rápida) |

Tabela completa (gpt-oss:20b, gemma4:26b-a4b, llama4:scout, qwen3.5:122b-a10b…) em [MODELOS.md](MODELOS.md).

## O processo, do início ao fim

🧠 = você no Claude Code/Codex (uma vez) · 🙋 = você, à mão · ⚙️ = script do kit · 🗣️ = você usando o assistente

| # | Passo | Comando / o que acontece | Quem |
|---|---|---|---|
| 0 | Pré-requisitos | Python 3.10+ e curl; no Ubuntu/Debian `sudo apt install -y python3-venv curl` (o instalador confere e avisa) | 🙋 |
| 1 | Baixar o kit | `git clone https://github.com/~~ARCKHÉTDS~~/jarvis-local.git && cd jarvis-local` | ⚙️ |
| 2 | Simular a instalação | `bash instalar/instalar.sh --simular` (Mac/Linux) ou `powershell -ExecutionPolicy Bypass -File instalar\instalar.ps1 -Simular` (Windows): mostra a GPU, a memória e o modelo escolhido, sem instalar nada | ⚙️ |
| 3 | Instalar os 3 motores | o mesmo comando sem `--simular`: Ollama + modelo, Whisper (faster-whisper ou mlx-whisper; na NVIDIA, com cuBLAS/cuDNN) e VoiceStudio; grava `~/.jarvis-local/minha-maquina.json` com a tag do cérebro e o Python do kit | ⚙️ |
| 4 | Criar a voz | no VoiceStudio: instale o motor **VoxCPM2** (fala português, Apache-2.0) e clone a SUA voz num perfil chamado **Jarvis** (10–20 s, sem eco) | 🙋 |
| 5 | Verificar | `python3 instalar/verificar.py` → cérebro ✓ (com o tempo de resposta), ouvidos ✓, voz ✓ | ⚙️ |
| 6 | Construir | abra o Claude Code (ou Codex) numa pasta vazia e cole os prompts **01 → 08** em ordem, um por vez, esperando cada um terminar e se provar | 🧠 |
| 7 | Medir | o prompt 07 cria `verificar_tudo.py`: ouvir X s · pensar Y s · falar Z s na SUA máquina | ⚙️ |
| 8 | Provar | o prompt 08 roda o teste sem internet: desligue o Wi-Fi, pergunte, e a lista de conexões externas tem que sair vazia | ⚙️ |
| 9 | Usar | "Jarvis, …" para perguntar às suas notas; "anota que…" para guardar; "muda para o grande" para trocar de cérebro | 🗣️ |

## Os 8 prompts

| # | Prompt | O que constrói |
|---|---|---|
| 01 | [A galáxia e o cérebro local](prompts/01-galaxia-e-cerebro.md) | Galáxia 3D das suas notas + perguntas respondidas pelo modelo local |
| 02 | [A voz clonada](prompts/02-voz-clonada.md) | Cada resposta falada na sua voz, em blocos sem engasgar |
| 03 | [Os ouvidos locais](prompts/03-ouvidos-locais.md) | "Jarvis" para chamar, "para" para interromper, áudio que não sai da sala |
| 04 | [Personalidade enxuta](prompts/04-personalidade-enxuta.md) | Um personagem que cabe num modelo pequeno, com prompt curto e rápido |
| 05 | [Memória que cresce](prompts/05-memoria-que-cresce.md) | "Anota que…" vira nota nova na galáxia, ao vivo |
| 06 | [Trocar de cérebro falando](prompts/06-troca-de-cerebro.md) | Local, grande ou nuvem (opcional) — por voz, com selo na tela |
| 07 | [O verificador](prompts/07-verificador-de-latencia.md) | Testa tudo de verdade e mede o tempo da sua máquina |
| 08 | [O teste sem internet](prompts/08-teste-sem-internet.md) | Prova que nada sai da máquina, com o Wi-Fi desligado |

## O que tem neste repositório

```
instalar/instalar.sh     instalador Mac + Linux (detecta GPU e memória, escolhe o modelo)
instalar/instalar.ps1    instalador Windows (NVIDIA)
instalar/verificar.py    confere cérebro, ouvidos e voz, e mede a primeira resposta
prompts/01..08           os prompts de construção (PT; versões em prompts/en e prompts/es)
config.exemplo.json      modelo do config.json que o assistente usa
REQUISITOS.md            GPU, memória e onde não roda
MODELOS.md               tabela de modelos por máquina
guia/                    página de guia (PT/EN/ES)
```

## Cuidados

- **Clone só a sua voz** ou a de quem autorizou. Clonar voz famosa para algo público é problema jurídico, não técnico.
- **Fixe versões** (modelo, motor de voz). "Latest" é como um assistente que funcionava quebra numa terça-feira.
- **Tags `-cloud` do Ollama rodam na nuvem**: o instalador recusa.
- O Claude Code/Codex só é usado para **construir**. Depois de pronto, o assistente roda sem eles e sem internet.

## Licença

MIT — veja [LICENSE](LICENSE). Os modelos e o VoiceStudio têm licenças próprias (VoiceStudio: AGPL-3.0; VoxCPM2: Apache-2.0).

---

Feito pelo **[ARCKHÉ.CLUB](https://linnoff88-dev.github.io/arckhe-ai)**.
