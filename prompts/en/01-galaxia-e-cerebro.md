# Prompt 01 · The Galaxy and the Local Brain

> Paste into Claude Code (or Codex) opened in an empty folder, for example `~/my-jarvis`.
> First, run `python3 instalar/verificar.py` (in the kit folder) and confirm the brain (Ollama) shows ✓.
> The brain tag and the kit’s Python path are in `~/.jarvis-local/minha-maquina.json` (written by the installer).
> Replace the text in brackets. Paste everything else as is.

```text
I want a personal assistant that runs 100% on my machine. In this first step, build the entire foundation at once, and only tell me you’re done after starting it and testing it.

PYTHON: Run everything in this project with [the "python" from ~/.jarvis-local/minha-maquina.json, e.g., ~/.jarvis-local/venv/bin/python] — that’s where the installer put Whisper. Create an iniciar.sh (and iniciar.bat on Windows) that starts the server with this Python; on Linux with NVIDIA, iniciar.sh must first export LD_LIBRARY_PATH with the lib directories from the nvidia.cublas and nvidia.cudnn packages in this venv.

MY NOTES: [full path to the folder with my .md files — or write "I don't have notes; create 30 sample notes about a small business in ./notas"]

1. INDEXER — indexar.py, Python 3 using only the standard library. Read all .md files from the notes folder and write painel/grafo.js with `const GRAFO = {nos: [...], ligacoes: [...]}`. Each node: title (filename), group (parent folder), a snippet of ~700 characters, and a numeric id equal to its position in the list. Two notes are linked when one mentions the other’s title or they share a [[link]].

2. PANEL — painel/index.html, a single page, no npm and no build step. Use the 3d-force-graph library via CDN with a FIXED version (prompt 08 brings it into the project). Cinematic look: black background, star field, nodes glowing in their group’s color, slow rotation when idle. Clicking a node flies the camera to it, lights up its neighbors, and opens a side panel with the snippet.

3. SERVER — servidor.py on port 4700, bound to 127.0.0.1, serving ONLY the painel/ folder. Create config.json in the PROJECT ROOT (never inside painel/):
   {"cerebro": {"base_url": "http://localhost:11434/v1", "modelo": "[installer tag, e.g., qwen3.5:9b]", "api_key": "ollama", "extra_body": {"reasoning_effort": "none"}}}
   Talk to the model using the OpenAI-compatible chat completions format, with urllib (no SDK), merging extra_body into every request. The same code must work with another endpoint by changing only base_url, modelo, and api_key.

4. ASK — POST /chat route. Score each note against the question by shared words (titles count more), select the 6 best, and send them to the model. System instruction: answer ONLY based on these notes, in 2 or 3 sentences, and clearly say when the notes don’t cover the subject. Return {"resposta": "...", "nos": [indices used]}. Keep a short history on the server for follow-up questions. Clean question bar at the bottom of the panel.

5. LOCAL BRAIN RULES (here every word costs seconds, not cents):
   - The system instruction is IDENTICAL on every turn and comes FIRST; notes and question come LAST, so the model can reuse the cache.
   - System instruction under 400 words.
   - extra_body (reasoning_effort none) is what turns off “silent thinking.” Don’t invent another flag.
   - At least 600 response tokens; if the returned text is empty, try once with double the amount.

6. FINISH PROPERLY — start the server, confirm the page opens and the graph appears, ask a real question through /chat, and show the answer AND how many seconds it took. Then give me 3 sample questions based on the actual titles of my notes.
```

**Write down the seconds** shown at the end: that’s your baseline. Prompts 04 and 07 are where you get that time back.
