#!/usr/bin/env python3
"""Jarvis Local — verifica os 3 motores (cérebro, ouvidos, voz) sem instalar nada.

Uso: python3 instalar/verificar.py [--modelo TAG] [--sem-teste-chat]
Lê ~/.jarvis-local/minha-maquina.json (gravado pelo instalador) quando existe.
Sai com código 1 se o cérebro falhar; voz e ouvidos ausentes são só aviso.
"""
import argparse, json, os, platform, shutil, subprocess, sys, time, urllib.request
from pathlib import Path

PASTA = Path(os.environ.get("JARVIS_PASTA", Path.home() / ".jarvis-local"))
OK, FALHA, AVISO = "✓", "✗", "!"
placar = {OK: 0, FALHA: 0, AVISO: 0}


def linha(marca, texto):
    placar[marca] += 1
    print(f"  {marca} {texto}")


def pega(url, corpo=None, espera=5):
    dados = json.dumps(corpo).encode() if corpo is not None else None
    req = urllib.request.Request(url, data=dados, headers={"Content-Type": "application/json"})
    with urllib.request.urlopen(req, timeout=espera) as r:
        return json.loads(r.read() or b"{}")


def gpu():
    if platform.system() == "Darwin" and platform.machine() == "arm64":
        return "Apple Silicon"
    if shutil.which("nvidia-smi"):
        r = subprocess.run(["nvidia-smi", "-L"], capture_output=True, text=True)
        if r.returncode == 0 and r.stdout.strip():
            return r.stdout.strip().splitlines()[0].split(" (UUID")[0].split(": ", 1)[-1]
    if Path("/dev/kfd").exists():
        return "AMD ROCm"
    return ""


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--modelo")
    ap.add_argument("--sem-teste-chat", action="store_true")
    a = ap.parse_args()
    info = {}
    arq = PASTA / "minha-maquina.json"
    if arq.exists():
        info = json.loads(arq.read_text())
    modelo = a.modelo or info.get("cerebro") or "qwen3.5:9b"

    print("\nMáquina")
    g = gpu()
    linha(OK, f"GPU: {g}") if g else linha(AVISO, "sem GPU detectada — o cérebro vai ser lento (veja REQUISITOS.md)")

    print("\nCérebro (Ollama, porta 11434)")
    try:
        tags = [m["id"] for m in pega("http://localhost:11434/v1/models")["data"]]
        linha(OK, f"Ollama no ar com {len(tags)} modelo(s)")
        if modelo in tags or f"{modelo}:latest" in tags:
            linha(OK, f"modelo {modelo} baixado")
            if not a.sem_teste_chat:
                t = time.time()
                r = pega("http://localhost:11434/v1/chat/completions", {
                    "model": modelo, "reasoning_effort": "none", "max_tokens": 600,
                    "messages": [{"role": "user", "content": "Diga olá em uma frase curta."}]}, espera=300)
                txt = (r["choices"][0]["message"].get("content") or "").strip()
                s = time.time() - t
                if txt:
                    linha(OK, f"respondeu em {s:.1f} s: {txt[:70]}")
                else:
                    linha(FALHA, "resposta vazia — o modelo gastou tudo 'pensando'; confira reasoning_effort none")
        else:
            linha(FALHA, f"modelo {modelo} não está baixado → ollama pull {modelo}")
    except Exception as e:
        linha(FALHA, f"Ollama não respondeu ({e.__class__.__name__}) → instale/abra o Ollama")

    print("\nOuvidos (Whisper)")
    venv = PASTA / "venv"
    candidatos = [Path(info["python"])] if info.get("python") else []
    candidatos += [venv / "bin" / "python", venv / "Scripts" / "python.exe"]
    py = next((str(c) for c in candidatos if c.exists()), sys.executable)
    pacote = "mlx_whisper" if platform.system() == "Darwin" else "faster_whisper"
    r = subprocess.run([py, "-c", f"import {pacote}"], capture_output=True)
    linha(OK, f"{pacote} instalado ({py})") if r.returncode == 0 else linha(AVISO, f"{pacote} ausente em {py} → rode o instalador")

    print("\nVoz (VoiceStudio, porta 3900)")
    try:
        pega("http://127.0.0.1:3900/health", espera=2)
        linha(OK, "VoiceStudio no ar")
        perfis = pega("http://127.0.0.1:3900/profiles", espera=3)
        perfis = perfis if isinstance(perfis, list) else perfis.get("profiles", [])
        nomes = [p.get("name") for p in perfis if isinstance(p, dict)]
        linha(OK, "perfil 'Jarvis' encontrado") if "Jarvis" in nomes else linha(AVISO, "crie o perfil de voz 'Jarvis' (Profiles → New → Clone)")
    except Exception:
        linha(AVISO, "VoiceStudio fechado — abra o app (sem ele o assistente usa a voz do navegador)")

    print(f"\nResumo: {placar[OK]} ok, {placar[FALHA]} falha, {placar[AVISO]} aviso")
    sys.exit(1 if placar[FALHA] else 0)


if __name__ == "__main__":
    main()
