# Jarvis Local - instalador para Windows com placa NVIDIA.
# Instala os 3 motores: cérebro (Ollama + modelo), ouvidos (faster-whisper) e voz (VoiceStudio).
# Uso (PowerShell normal): powershell -ExecutionPolicy Bypass -File instalar\instalar.ps1 [-Modelo TAG] [-SemVoz] [-SemOuvidos] [-ForcarCpu] [-Simular]
param(
  [string]$Modelo = "",
  [switch]$SemVoz,
  [switch]$SemOuvidos,
  [switch]$ForcarCpu,
  [switch]$Simular
)
$ErrorActionPreference = "Stop"
$Pasta = if ($env:JARVIS_PASTA) { $env:JARVIS_PASTA } else { Join-Path $HOME ".jarvis-local" }

function Ok($t)    { Write-Host "  [ok] $t" -ForegroundColor Green }
function Aviso($t) { Write-Host "  [!]  $t" -ForegroundColor Yellow }
function Erro($t)  { Write-Host "  [x]  $t" -ForegroundColor Red }
function Titulo($t){ Write-Host "`n$t" -ForegroundColor White }
function Roda($cmd){ Write-Host "  > $cmd"; if (-not $Simular) { Invoke-Expression $cmd } }

Titulo "1/5 - Sua maquina"
$Gpu = ""; $MemGB = 0
$smi = Get-Command nvidia-smi -ErrorAction SilentlyContinue
if ($smi) {
  $nome = (& nvidia-smi --query-gpu=name --format=csv,noheader | Select-Object -First 1).Trim()
  $vram = (& nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits | Select-Object -First 1) -replace '[^0-9]', ''
  if ($vram) { $Gpu = "NVIDIA $nome"; $MemGB = [math]::Round([int]$vram / 1024) }
}
if (-not $Gpu) {
  Erro "Nao achei placa NVIDIA (nvidia-smi)."
  Write-Host "    Tem placa NVIDIA? Instale o driver primeiro: o comando nvidia-smi tem de funcionar."
  Write-Host "    O Jarvis Local precisa de GPU para conversar por voz. Veja REQUISITOS.md."
  Write-Host "    Mini PC AMD Ryzen AI Max+: o Ollama usa a GPU integrada; rode com -ForcarCpu e confira a BIOS."
  if (-not $ForcarCpu) { exit 1 }
  $MemGB = [math]::Floor((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB)
  Aviso "Seguindo por causa de -ForcarCpu."
} else { Ok "GPU: $Gpu" }
Ok "Memoria que o modelo enxerga: ~$MemGB GB"

Titulo "2/5 - Escolhendo o cerebro"
$Rapido = ""
if (-not $Modelo) {
  if     ($MemGB -lt 12) { $Modelo = "gemma4:e4b"; Aviso "Pouca memoria: este cerebro so serve para conversa simples." }
  elseif ($MemGB -lt 20) { $Modelo = "qwen3.5:9b" }
  elseif ($MemGB -lt 28) { $Modelo = "gemma4:12b";   $Rapido = "qwen3.5:9b" }
  elseif ($MemGB -lt 60) { $Modelo = "qwen3.8:27b";  $Rapido = "qwen3.5:9b" }
  elseif ($MemGB -lt 90) { $Modelo = "gemma4:31b";   $Rapido = "qwen3.5:9b" }
  else                   { $Modelo = "gpt-oss:120b"; $Rapido = "qwen3.5:9b" }
}
if ($Modelo -like "*-cloud") { Erro "A tag $Modelo roda na nuvem do Ollama. Escolha uma tag local."; exit 1 }
Ok "Cerebro principal: $Modelo"
if ($Rapido) { Ok "Cerebro de conversa rapida: $Rapido" }

Titulo "3/5 - Cerebro (Ollama)"
if (Get-Command ollama -ErrorAction SilentlyContinue) { Ok "Ollama ja instalado" }
else { Roda "winget install --id Ollama.Ollama -e --accept-source-agreements --accept-package-agreements" }
Roda "ollama pull $Modelo"
if ($Rapido) { Roda "ollama pull $Rapido" }

Titulo "4/5 - Ouvidos (Whisper local)"
if ($SemOuvidos) { Aviso "Pulado (-SemOuvidos)." }
else {
  Roda "py -3 -m venv `"$Pasta\venv`""
  Roda "& `"$Pasta\venv\Scripts\pip.exe`" install -q faster-whisper"
  # o faster-whisper usa cuBLAS 12 e cuDNN 9 na placa NVIDIA
  if ($Gpu) { Roda "& `"$Pasta\venv\Scripts\pip.exe`" install -q nvidia-cublas-cu12 nvidia-cudnn-cu12==9.*" }
  Ok "Whisper fica em $Pasta\venv (o modelo large-v3-turbo baixa ~1,5 GB no primeiro uso)."
  Write-Host "    O assistente tem de rodar com ESTE Python: $Pasta\venv\Scripts\python.exe (os prompts ja pedem isso)."
}

Titulo "5/5 - Voz (VoiceStudio)"
if ($SemVoz) { Aviso "Pulado (-SemVoz). O assistente usa a voz do navegador." }
else {
  Roda "irm https://voicestudio.sh/install.ps1 | iex"
  Write-Host "    Abra o VoiceStudio pelo menu Iniciar (no 1o uso ele baixa o proprio motor e demora)."
  Write-Host "    Depois, no app: Model Catalogue -> instale VoxCPM2 (fala portugues, Apache-2.0) e selecione."
  Write-Host "    Profiles -> New -> Clone, com 10-20 s da SUA voz, sem musica nem eco. Nome do perfil: Jarvis"
}

$Resumo = @{ gpu = $Gpu; memoria_gb = $MemGB; cerebro = $Modelo; cerebro_rapido = $Rapido;
   ollama = "http://localhost:11434/v1"; voz = "http://127.0.0.1:3900"; python = "$Pasta\venv\Scripts\python.exe" } | ConvertTo-Json -Compress
Titulo "Pronto"
if ($Simular) { Ok "Simulacao: nada foi instalado nem gravado. O resumo seria:"; Write-Host "    $Resumo" }
else {
  New-Item -ItemType Directory -Force -Path $Pasta | Out-Null
  Set-Content -Encoding UTF8 -Path (Join-Path $Pasta "minha-maquina.json") -Value $Resumo
  Ok "Resumo gravado em $Pasta\minha-maquina.json (a tag do cerebro e o Python que os prompts usam)"
}
Write-Host "    Proximo: py -3 instalar\verificar.py  ->  depois abra o Claude Code numa pasta vazia e cole prompts\01."
