#!/usr/bin/env bash
# Jarvis Local — instalador para Mac (Apple Silicon) e Linux (NVIDIA / AMD ROCm / memória unificada).
# Instala os 3 motores: cérebro (Ollama + modelo), ouvidos (Whisper) e voz (VoiceStudio).
# Uso: bash instalar/instalar.sh [--modelo TAG] [--sem-voz] [--sem-ouvidos] [--forcar-cpu] [--simular]
set -euo pipefail

MODELO=""; SEM_VOZ=0; SEM_OUVIDOS=0; FORCAR_CPU=0; SIMULAR=0
PASTA="${JARVIS_PASTA:-$HOME/.jarvis-local}"
while [ $# -gt 0 ]; do
  case "$1" in
    --modelo) MODELO="${2:?falta a tag do modelo}"; shift 2 ;;
    --sem-voz) SEM_VOZ=1; shift ;;
    --sem-ouvidos) SEM_OUVIDOS=1; shift ;;
    --forcar-cpu) FORCAR_CPU=1; shift ;;
    --simular|--dry-run) SIMULAR=1; shift ;;
    -h|--help) sed -n '2,5p' "$0"; exit 0 ;;
    *) echo "opção desconhecida: $1" >&2; exit 2 ;;
  esac
done

AQUI="$(cd "$(dirname "$0")" && pwd)"
ok()   { printf '  \033[32m✓\033[0m %s\n' "$*"; }
aviso(){ printf '  \033[33m!\033[0m %s\n' "$*"; }
erro() { printf '  \033[31m✗\033[0m %s\n' "$*" >&2; }
titulo(){ printf '\n\033[1m%s\033[0m\n' "$*"; }
roda() { printf '  $ %s\n' "$*"; [ "$SIMULAR" = 1 ] || bash -c "$*"; }

SO="$(uname -s)"; ARQ="$(uname -m)"
titulo "1/5 · Sua máquina ($SO $ARQ)"

# pré-requisitos do próprio instalador
FALTA=""
command -v curl >/dev/null 2>&1 || FALTA="$FALTA curl"
command -v python3 >/dev/null 2>&1 || FALTA="$FALTA python3"
if command -v python3 >/dev/null 2>&1 && ! python3 -c "import ensurepip, venv" >/dev/null 2>&1; then FALTA="$FALTA python3-venv"; fi
if [ -n "$FALTA" ]; then
  erro "Falta:$FALTA"
  [ "$SO" = "Linux" ] && echo "    Ubuntu/Debian: sudo apt install -y$FALTA"
  [ "$SO" = "Darwin" ] && echo "    Mac: instale o Python 3 em https://www.python.org/downloads/ (o curl já vem no sistema)"
  [ "$SIMULAR" = 1 ] || exit 1
fi

GPU=""; MEM_GB=0
if [ "$SO" = "Darwin" ]; then
  if [ "$ARQ" = "arm64" ]; then
    GPU="Apple Silicon (memória unificada)"
    MEM_GB=$(( $(sysctl -n hw.memsize) / 1073741824 ))
  fi
elif [ "$SO" = "Linux" ]; then
  RAM_GB=$(( $(awk '/MemTotal/{print $2}' /proc/meminfo) / 1048576 ))
  if command -v nvidia-smi >/dev/null 2>&1 && nvidia-smi -L >/dev/null 2>&1; then
    NOME="$(nvidia-smi --query-gpu=name --format=csv,noheader | head -1 | sed "s/^NVIDIA //")"
    VRAM_MB="$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits | head -1 | tr -dc '0-9')"
    if [ -n "$VRAM_MB" ] && [ "$VRAM_MB" -gt 0 ]; then
      GPU="NVIDIA $NOME"; MEM_GB=$(( (VRAM_MB + 512) / 1024 ))
    else
      # GB10 / DGX Spark / Jetson: a GPU usa a memória do sistema (unificada)
      GPU="NVIDIA $NOME (memória unificada)"; MEM_GB=$RAM_GB
    fi
  elif [ -e /dev/kfd ]; then
    GPU="AMD com ROCm (memória da GPU definida na BIOS)"; MEM_GB=$RAM_GB
    aviso "AMD: libere o máximo de memória para a GPU na BIOS; o número abaixo é a RAM total."
  fi
fi

if [ -z "$GPU" ]; then
  erro "Não achei GPU (NVIDIA, AMD com ROCm) nem Apple Silicon."
  echo "    Tem placa NVIDIA? Instale o driver primeiro: o comando nvidia-smi tem de funcionar."
  echo "    O Jarvis Local precisa de GPU ou memória unificada para conversar por voz."
  echo "    Em CPU (ex.: VPS comum) o cérebro responde a 2–5 palavras por segundo. Veja REQUISITOS.md."
  if [ "$FORCAR_CPU" = 0 ]; then echo "    Para instalar mesmo assim (só teste): --forcar-cpu"; exit 1; fi
  aviso "Seguindo em CPU por causa de --forcar-cpu."
  MEM_GB=$(( $( [ "$SO" = "Darwin" ] && sysctl -n hw.memsize || awk '/MemTotal/{print $2*1024}' /proc/meminfo ) / 1073741824 ))
else
  ok "GPU: $GPU"
fi
ok "Memória que o modelo enxerga: ~${MEM_GB} GB"

titulo "2/5 · Escolhendo o cérebro"
RAPIDO=""
if [ -z "$MODELO" ]; then
  if   [ "$MEM_GB" -lt 12 ]; then MODELO="gemma4:e4b"; aviso "Pouca memória: este cérebro só serve para conversa simples."
  elif [ "$MEM_GB" -lt 20 ]; then MODELO="qwen3.5:9b"
  elif [ "$MEM_GB" -lt 28 ]; then MODELO="gemma4:12b";   RAPIDO="qwen3.5:9b"
  elif [ "$MEM_GB" -lt 60 ]; then MODELO="qwen3.8:27b";  RAPIDO="qwen3.5:9b"
  elif [ "$MEM_GB" -lt 90 ]; then MODELO="gemma4:31b";   RAPIDO="qwen3.5:9b"
  else                            MODELO="gpt-oss:120b"; RAPIDO="qwen3.5:9b"
  fi
fi
case "$MODELO" in *-cloud) erro "A tag $MODELO roda na nuvem do Ollama. Escolha uma tag local."; exit 1 ;; esac
ok "Cérebro principal: $MODELO"
[ -n "$RAPIDO" ] && ok "Cérebro de conversa rápida: $RAPIDO"

titulo "3/5 · Cérebro (Ollama)"
if command -v ollama >/dev/null 2>&1; then
  ok "Ollama já instalado ($(ollama --version 2>/dev/null | tail -1))"
else
  if [ "$SO" = "Darwin" ]; then
    if command -v brew >/dev/null 2>&1; then roda "brew install --cask ollama"
    else erro "Baixe o Ollama em https://ollama.com/download, abra uma vez e rode este instalador de novo."; [ "$SIMULAR" = 1 ] || exit 1; fi
  else
    roda "curl -fsSL https://ollama.com/install.sh | sh"
  fi
fi
if [ "$SIMULAR" = 0 ] && ! curl -fsS http://127.0.0.1:11434/api/version >/dev/null 2>&1; then
  aviso "Ollama parado; subindo em segundo plano."
  (ollama serve >/dev/null 2>&1 &) ; sleep 3
fi
roda "ollama pull $MODELO"
[ -n "$RAPIDO" ] && roda "ollama pull $RAPIDO"

titulo "4/5 · Ouvidos (Whisper local)"
if [ "$SEM_OUVIDOS" = 1 ]; then aviso "Pulado (--sem-ouvidos)."
else
  roda "python3 -m venv '$PASTA/venv'"
  if [ "$SO" = "Darwin" ]; then
    roda "'$PASTA/venv/bin/pip' install -q mlx-whisper"
  else
    roda "'$PASTA/venv/bin/pip' install -q faster-whisper"
    case "$GPU" in NVIDIA*)
      # o faster-whisper usa cuBLAS 12 e cuDNN 9 na GPU; sem eles cai para a CPU ou dá 'libcudnn_ops.so.9 not found'
      roda "'$PASTA/venv/bin/pip' install -q nvidia-cublas-cu12 'nvidia-cudnn-cu12==9.*'" ;;
    esac
  fi
  ok "Whisper fica em $PASTA/venv (o modelo large-v3-turbo baixa ~1,5 GB no primeiro uso)."
  echo "    O assistente tem de rodar com ESTE Python: $PASTA/venv/bin/python (os prompts já pedem isso)."
fi

titulo "5/5 · Voz (VoiceStudio)"
if [ "$SEM_VOZ" = 1 ]; then aviso "Pulado (--sem-voz). O assistente usa a voz do navegador."
elif [ "$SO" = "Linux" ] && [ "$ARQ" = "aarch64" ]; then
  aviso "Linux ARM64 (ex.: DGX Spark): o VoiceStudio instala pelo código-fonte:"
  echo  "    git clone https://github.com/debpalash/VoiceStudio.git && cd VoiceStudio"
  echo  "    bun install && bun run setup:api && bun run dev"
else
  roda "curl -fsSL https://voicestudio.sh/install | sh"
  if [ "$SO" = "Linux" ]; then
    echo "    Abra o app com: ~/.local/bin/VoiceStudio  (é um AppImage; no 1º uso ele baixa o próprio motor e demora)"
    if ! ldconfig -p 2>/dev/null | grep -q "libfuse.so.2"; then
      aviso "AppImage precisa da libfuse2. Ubuntu 24.04: sudo apt install -y libfuse2t64 · 22.04: sudo apt install -y libfuse2"
    fi
  else
    echo "    Abra o app VoiceStudio na pasta Aplicativos."
  fi
fi
if [ "$SEM_VOZ" = 0 ]; then
  echo "    Depois, no app: Model Catalogue → instale VoxCPM2 (fala português, Apache-2.0) e selecione."
  echo "    Profiles → New → Clone, com 10–20 s da SUA voz, sem música nem eco. Nome do perfil: Jarvis"
fi

RESUMO="{\"gpu\": \"$GPU\", \"memoria_gb\": $MEM_GB, \"cerebro\": \"$MODELO\", \"cerebro_rapido\": \"$RAPIDO\", \"ollama\": \"http://localhost:11434/v1\", \"voz\": \"http://127.0.0.1:3900\", \"python\": \"$PASTA/venv/bin/python\"}"
titulo "Pronto"
if [ "$SIMULAR" = 1 ]; then
  ok "Simulação: nada foi instalado nem gravado. O resumo seria:"
  echo "    $RESUMO"
else
  mkdir -p "$PASTA"; printf '%s\n' "$RESUMO" > "$PASTA/minha-maquina.json"
  ok "Resumo gravado em $PASTA/minha-maquina.json (a tag do cérebro e o Python que os prompts usam)"
fi
echo "    Próximo: python3 '$AQUI/verificar.py'  →  depois abra o Claude Code numa pasta vazia e cole prompts/01."
