# Prompt 03 · Local Ears

> Before: `faster-whisper` (Linux/Windows, uses the NVIDIA GPU) or `mlx-whisper` (Mac Apple Silicon) installed in the kit’s Python environment (`~/.jarvis-local/venv`) — the installer already handles this. The server must run with that Python (the `iniciar.sh` from prompt 01).

```text
Give the assistant running on this machine ears. Do not use the browser’s speech recognition in this project: it sends audio to the cloud.

1. LISTENING MODULE — `ouvir.py`, using `mlx_whisper` on Mac Apple Silicon and `faster_whisper` elsewhere (with the NVIDIA GPU when available), imported optionally — but if the import fails, the dashboard must show it and the assistant must say out loud, "I can't hear: run me with the kit's Python," never fail silently. On Linux with NVIDIA, `iniciar.sh` from prompt 01 must export `LD_LIBRARY_PATH` with the `lib` directories for `nvidia.cublas` and `nvidia.cudnn` (pip packages the installer put in the venv) BEFORE starting Python; otherwise `faster-whisper` can't find `libcudnn`. If the GPU still fails, fall back to the CPU with `compute_type int8` and show a warning. Add to `config.json`:
   "audicao": {"modelo": "large-v3-turbo", "modelo_ativacao": "small", "idioma": "en"}
   (on Mac: "mlx-community/whisper-large-v3-turbo" and "mlx-community/whisper-small-mlx").
   Load both models ONCE at startup, keep them in memory, and warm each up with 1 second of silence. POST /ouvir receives a WAV and returns {"texto", "segundos"}.

2. MICROPHONE — in the dashboard, capture audio with `getUserMedia` and generate 16 kHz, mono, 16-bit WAV directly in the browser, without ffmpeg. Measure volume continuously. Speech starts when the volume exceeds a threshold and ends after SILENCIO_MS of quiet (constant at the top of the file, starting at 700). Ignore segments shorter than 300 ms. Then apply the COMPLETION WINDOW: keep the text and wait FIM_MS (starts at 900) for more speech before sending, because I stop mid-sentence. More speech means join it and restart the timer.

3. WAKE WORD — a "hands-free" button. When enabled, all speech goes through the SMALL Whisper (small) first. If the text starts with "Jarvis" (or "hey Jarvis", "hi Jarvis"), remove the name and send the rest to the LARGE Whisper (large-v3-turbo; not the brain), then to /chat. If I only said the name, reply "Yes?" and treat the next utterance as a command. Speech without the name is discarded: never recorded, never sent. A "push to talk" button skips the wake word and goes straight to the large Whisper.

4. INTERRUPTION — while the assistant speaks, keep listening, but only for "stop" and "wait", which immediately cut off the audio. Raise the volume threshold while it speaks so its own voice coming from the speakers doesn't trigger anything, and tell me clearly if my setup requires headphones.

5. STATUS — a status line showing listening / heard (with the text) / thinking / speaking, so I always know whose turn it is. Tabs with ?mute=1 keep listening; they just don't speak.

6. PROOF — a test script listing what I should say and what I should see, including a pause mid-sentence (to prove the completion window), a sentence without "Jarvis" that should be discarded, and the measured seconds between the end of my speech and the text appearing on screen.
```

**Fine-tuning:** SILENCIO_MS and FIM_MS are the most personal settings in the project. Adjust them after a day of use, one at a time: one reflects how you pause, the other how you think.
