# Prompt 02 · The Cloned Voice

> Before you start: VoiceStudio is open (port 3900), a motor with a free license is installed (VoxCPM2 speaks English), and a voice profile named **Jarvis** has been cloned from 10–20 seconds of YOUR voice (or someone else’s voice with their permission).

```text
Now give the assistant a voice using VoiceStudio, which is open on this machine at http://127.0.0.1:3900.

1. VOICE MODULE — voz.py, standard library only, imported optionally by servidor.py (the assistant starts normally without it). Add this to config.json:
   "voz": {"url": "http://127.0.0.1:3900", "motor": "[engine ID, e.g.: voxcpm2]", "modelo": "[model ID, e.g.: openbmb/VoxCPM2 — check Model Catalogue]", "perfil": "Jarvis", "idioma": "en"}
   On startup (and once each time the engine restarts), send POST /engines/select with {"family": "tts", "backend_id": MOTOR, "model_id": MODELO} to keep the engine fixed so it is never switched without notice. Find the profile ID by name using GET /profiles.

2. ROUTE — POST /falar with {"texto"} returns audio/wav by calling POST /v1/audio/speech with {"model": MODELO, "input": texto, "voice": ID_DO_PERFIL, "response_format": "wav", "language": IDIOMA}. Maximum 600 characters per request. Save each WAV to disk using a hash of the text+profile (repeated phrases, like the greeting, are ready immediately). Every response includes the X-Jarvis-Voz: local:NOME_DO_PERFIL header.

3. KEEP THE ENGINE WARM — every 10 minutes of inactivity, generate "At your service." and discard the audio so the model doesn’t cool down and the first spoken line of the day doesn’t take 7 seconds.

4. PLAYER (and the golden rule) — split each response into blocks of ~170 characters made of COMPLETE sentences. Request the first block, play it, and fetch the next while the first is playing so there’s no gap. Do NOT shorten the first block to start faster: a voice that stops mid-sentence sounds broken; I’d rather wait an extra second.

5. PLAN B — if GET /health doesn’t respond within 1 second, speak with the browser’s voice (Web Speech API) and set X-Jarvis-Voz: browser. Never fail silently, never hang.

6. MUTE — if the URL contains ?mute=1, nothing in that tab speaks. Put the check inside the ONE function that plays audio so nothing can bypass it.

7. VOICE COMMANDS — a list of routes (phrase pattern + action) checked BEFORE the phrase goes to the brain. Start with "use the local voice" and "use the browser voice". The next prompts will add routes to this list.

8. PROOF — play a 10-word phrase and an 80-word response, show the seconds until the first sound for each, confirm that the 2nd block was ready when the 1st ended, and that a tab with ?mute=1 stayed silent.
```

**Tip:** the reference audio determines everything. Record with the microphone and in the room you’ll use, reading 2 or 3 calm sentences. A short, clean clip clones better than a long one with breathing or chair noise.
