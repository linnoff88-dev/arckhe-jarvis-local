# Modelos — qual cérebro para qual máquina

Todos abertos, gratuitos e baixados pelo [Ollama](https://ollama.com/library). Tamanhos conferidos na biblioteca do Ollama em 04/11/2026 (versões em 4 bits). O instalador escolhe sozinho pela sua memória; você pode trocar com `--modelo <tag>`.

> ⚠️ **Não use tags terminadas em `-cloud`** (ex.: `gpt-oss:120b-cloud`): elas rodam nos servidores do Ollama, não na sua máquina.

## Tabela

| Modelo (tag do Ollama) | Parâmetros | Download | Roda bem em | Por que escolher |
|---|---|---|---|---|
| `gemma4:e4b` | ~4B | ~7 GB | 8–12 GB | Conversa simples. Deixe o pensamento pesado para um cérebro maior. |
| `qwen3.5:9b` | 9B denso | ~7 GB | **16 GB** (piso) | O cérebro padrão do kit. Assistente de verdade, responde das suas notas e segura personalidade. Pensa escondido: o kit desliga isso com `reasoning_effort: none`. |
| `gemma4:12b` | 12B denso | ~8 GB | 24 GB (numa placa de 16 GB fica no limite com voz e Whisper: use `--modelo`) | Mais esperto, segue melhor as regras e **enxerga imagens** (pode olhar um print). |
| `gpt-oss:20b` | 21B, 3,6B ativos | 14 GB | 24–32 GB | Rápido porque só uma fatia do modelo trabalha a cada palavra. |
| `qwen3.8:27b` | 27B denso | 18 GB | **32 GB** (ponto doce), RTX 5090 | O melhor cérebro que cabe numa máquina de 32 GB. Licença Apache 2.0. |
| `gemma4:26b-a4b` | 26B, 4B ativos | 16–19 GB | 32 GB | Para quem quer velocidade em vez de profundidade. Contexto longo (256K). |
| `gemma4:31b` | 31B denso | ~20 GB | 64 GB | Cabe em 32 GB no limite; confortável em 64 GB. |
| `gpt-oss:120b` | 117B, 5,1B ativos | 65 GB | 96–128 GB | Raciocínio de classe "nuvem" em casa. |
| `llama4:scout` | 109B, 17B ativos | 67 GB | 96 GB+ | Multimodal, contexto muito longo. |
| `qwen3.5:122b-a10b` | 122B, 10B ativos | 81 GB | 128 GB+ | O maior cérebro desta lista que ainda responde rápido. |

## Denso × ativos

"27B denso" = os 27 bilhões de parâmetros trabalham em toda palavra. "117B, 5,1B ativos" = **mistura de especialistas**: o modelo inteiro precisa caber na memória, mas só ~5 bilhões trabalham por palavra, então ele responde mais rápido do que o tamanho sugere. Para conversar por voz, um modelo grande de especialistas costuma ser melhor compra que um denso médio.

## O que o instalador escolhe

| Memória detectada | Cérebro principal | Cérebro de conversa rápida |
|---|---|---|
| < 12 GB | `gemma4:e4b` (com aviso) | — |
| 12–19 GB | `qwen3.5:9b` | — |
| 20–27 GB | `gemma4:12b` | `qwen3.5:9b` |
| 28–59 GB | `qwen3.8:27b` | `qwen3.5:9b` |
| 60–89 GB | `gemma4:31b` | `qwen3.5:9b` |
| 90 GB ou mais | `gpt-oss:120b` | `qwen3.5:9b` |

`llama4:scout` e `qwen3.5:122b-a10b` o instalador não escolhe sozinho: use `--modelo` se tiver 128 GB ou mais.

"Memória detectada" = VRAM da placa NVIDIA, ou a memória total em Mac e máquinas de memória unificada.

## Dois cuidados

1. **"Cabe com 2 GB sobrando" não cabe.** O contexto cresce durante a conversa, a voz e o Whisper precisam de alguns GB, e a máquina começa a usar o disco — tudo trava. Use a regra dos 30% livres.
2. **Maior nem sempre é melhor assistente.** Um 27B segue um regulamento curto melhor do que um 120B segue um longo. O prompt 04 existe por isso.
