# Jarvis Local â€” seu assistente de voz 100% na sua mÃ¡quina

[![Jarvis Local](guia/assets/banner.jpg)](https://inematds.github.io/jarvis-local/guia/)

**ðŸ‡§ðŸ‡· [PortuguÃªs](README.md) Â· ðŸ‡ºðŸ‡¸ [English](README.en.md) Â· ðŸ‡ªðŸ‡¸ [EspaÃ±ol](README.es.md)**

## O que Ã©

O Jarvis Local Ã© um kit aberto do INEMA para montar um assistente pessoal que vocÃª chama pela voz ("Jarvis, â€¦") e que roda inteiro no seu computador: o cÃ©rebro (um modelo de IA aberto no Ollama), a voz clonada (VoiceStudio) e os ouvidos (Whisper). Ele responde a partir das suas prÃ³prias notas, mostradas numa galÃ¡xia 3D, e anota coisas novas quando vocÃª pede. Sem assinatura, sem conta de API e sem mandar o Ã¡udio para fora. **Precisa de GPU** (placa NVIDIA, Mac com Apple Silicon ou mini PC de memÃ³ria unificada) e do Claude Code ou Codex para construir, uma vez, com os 8 prompts do kit.

## ðŸ“– Guia de uso

Guia completo (landing + passo a passo): **https://inematds.github.io/jarvis-local/guia/**

ðŸŽ¬ VÃ­deo: https://www.youtube.com/shorts/dCPinV8Djn0

## âš ï¸ Roda em GPU â€” leia antes

| Roda bem | NÃ£o serve para conversar por voz |
|---|---|
| Mac com Apple Silicon (16 GB+, ideal 32 GB) | VPS / servidor na nuvem sem GPU |
| PC com placa NVIDIA (12 GB+ de VRAM, ideal 16â€“32 GB) | Notebook de 8 GB sem placa de vÃ­deo |
| Mini PC de memÃ³ria unificada (AMD Ryzen AI Max+, NVIDIA DGX Spark) | Placa com menos de 12 GB de VRAM (sÃ³ conversa simples) |

Sem GPU, o cÃ©rebro responde a 2â€“5 palavras por segundo â€” lento demais para conversa. O instalador confere sozinho e para com uma explicaÃ§Ã£o. Detalhes em [REQUISITOS.md](REQUISITOS.md).

## Qual cÃ©rebro para qual mÃ¡quina

| MemÃ³ria (unificada ou VRAM) | CÃ©rebro que o instalador baixa |
|---|---|
| 16 GB | `qwen3.5:9b` |
| 24 GB | `gemma4:12b` |
| 32 GB | `qwen3.8:27b` |
| 64 GB | `gemma4:31b` |
| 96 GB ou mais | `gpt-oss:120b` (+ `qwen3.5:9b` para conversa rÃ¡pida) |

Tabela completa (gpt-oss:20b, gemma4:26b-a4b, llama4:scout, qwen3.5:122b-a10bâ€¦) em [MODELOS.md](MODELOS.md).

## O processo, do inÃ­cio ao fim

ðŸ§  = vocÃª no Claude Code/Codex (uma vez) Â· ðŸ™‹ = vocÃª, Ã  mÃ£o Â· âš™ï¸ = script do kit Â· ðŸ—£ï¸ = vocÃª usando o assistente

| # | Passo | Comando / o que acontece | Quem |
|---|---|---|---|
| 0 | PrÃ©-requisitos | Python 3.10+ e curl; no Ubuntu/Debian `sudo apt install -y python3-venv curl` (o instalador confere e avisa) | ðŸ™‹ |
| 1 | Baixar o kit | `git clone https://github.com/inematds/jarvis-local.git && cd jarvis-local` | âš™ï¸ |
| 2 | Simular a instalaÃ§Ã£o | `bash instalar/instalar.sh --simular` (Mac/Linux) ou `powershell -ExecutionPolicy Bypass -File instalar\instalar.ps1 -Simular` (Windows): mostra a GPU, a memÃ³ria e o modelo escolhido, sem instalar nada | âš™ï¸ |
| 3 | Instalar os 3 motores | o mesmo comando sem `--simular`: Ollama + modelo, Whisper (faster-whisper ou mlx-whisper; na NVIDIA, com cuBLAS/cuDNN) e VoiceStudio; grava `~/.jarvis-local/minha-maquina.json` com a tag do cÃ©rebro e o Python do kit | âš™ï¸ |
| 4 | Criar a voz | no VoiceStudio: instale o motor **VoxCPM2** (fala portuguÃªs, Apache-2.0) e clone a SUA voz num perfil chamado **Jarvis** (10â€“20 s, sem eco) | ðŸ™‹ |
| 5 | Verificar | `python3 instalar/verificar.py` â†’ cÃ©rebro âœ“ (com o tempo de resposta), ouvidos âœ“, voz âœ“ | âš™ï¸ |
| 6 | Construir | abra o Claude Code (ou Codex) numa pasta vazia e cole os prompts **01 â†’ 08** em ordem, um por vez, esperando cada um terminar e se provar | ðŸ§  |
| 7 | Medir | o prompt 07 cria `verificar_tudo.py`: ouvir X s Â· pensar Y s Â· falar Z s na SUA mÃ¡quina | âš™ï¸ |
| 8 | Provar | o prompt 08 roda o teste sem internet: desligue o Wi-Fi, pergunte, e a lista de conexÃµes externas tem que sair vazia | âš™ï¸ |
| 9 | Usar | "Jarvis, â€¦" para perguntar Ã s suas notas; "anota queâ€¦" para guardar; "muda para o grande" para trocar de cÃ©rebro | ðŸ—£ï¸ |

## Os 8 prompts

| # | Prompt | O que constrÃ³i |
|---|---|---|
| 01 | [A galÃ¡xia e o cÃ©rebro local](prompts/01-galaxia-e-cerebro.md) | GalÃ¡xia 3D das suas notas + perguntas respondidas pelo modelo local |
| 02 | [A voz clonada](prompts/02-voz-clonada.md) | Cada resposta falada na sua voz, em blocos sem engasgar |
| 03 | [Os ouvidos locais](prompts/03-ouvidos-locais.md) | "Jarvis" para chamar, "para" para interromper, Ã¡udio que nÃ£o sai da sala |
| 04 | [Personalidade enxuta](prompts/04-personalidade-enxuta.md) | Um personagem que cabe num modelo pequeno, com prompt curto e rÃ¡pido |
| 05 | [MemÃ³ria que cresce](prompts/05-memoria-que-cresce.md) | "Anota queâ€¦" vira nota nova na galÃ¡xia, ao vivo |
| 06 | [Trocar de cÃ©rebro falando](prompts/06-troca-de-cerebro.md) | Local, grande ou nuvem (opcional) â€” por voz, com selo na tela |
| 07 | [O verificador](prompts/07-verificador-de-latencia.md) | Testa tudo de verdade e mede o tempo da sua mÃ¡quina |
| 08 | [O teste sem internet](prompts/08-teste-sem-internet.md) | Prova que nada sai da mÃ¡quina, com o Wi-Fi desligado |

## O que tem neste repositÃ³rio

```
instalar/instalar.sh     instalador Mac + Linux (detecta GPU e memÃ³ria, escolhe o modelo)
instalar/instalar.ps1    instalador Windows (NVIDIA)
instalar/verificar.py    confere cÃ©rebro, ouvidos e voz, e mede a primeira resposta
prompts/01..08           os prompts de construÃ§Ã£o (PT; versÃµes em prompts/en e prompts/es)
config.exemplo.json      modelo do config.json que o assistente usa
REQUISITOS.md            GPU, memÃ³ria e onde nÃ£o roda
MODELOS.md               tabela de modelos por mÃ¡quina
guia/                    pÃ¡gina de guia (PT/EN/ES)
```

## Cuidados

- **Clone sÃ³ a sua voz** ou a de quem autorizou. Clonar voz famosa para algo pÃºblico Ã© problema jurÃ­dico, nÃ£o tÃ©cnico.
- **Fixe versÃµes** (modelo, motor de voz). "Latest" Ã© como um assistente que funcionava quebra numa terÃ§a-feira.
- **Tags `-cloud` do Ollama rodam na nuvem**: o instalador recusa.
- O Claude Code/Codex sÃ³ Ã© usado para **construir**. Depois de pronto, o assistente roda sem eles e sem internet.

## LicenÃ§a

MIT â€” veja [LICENSE](LICENSE). Os modelos e o VoiceStudio tÃªm licenÃ§as prÃ³prias (VoiceStudio: AGPL-3.0; VoxCPM2: Apache-2.0).

---

Feito pelo **[INEMA.CLUB](https://inema.club)**.

---

Projeto adaptado da comunidade INEMA TDS - Marca Arckhe