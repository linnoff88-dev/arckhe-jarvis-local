# Prompt 07 · The verifier (the most important one)

> Unit tests pass, but the real pipeline is dead: that’s where it hurts. This prompt creates a verifier that calls the REAL system and measures your machine.

```text
Build a general-purpose verifier. This is the most important prompt in the project, so do it well.

Write verificar_tudo.py to run every REAL end-to-end pipeline and give a verdict. No mocks: make real calls against the running system.

Check these items in order, marking each with ✓ or ✗:
- The server is up and serving the dashboard.
- The graph loads and has more than zero nodes.
- Ollama responds at /v1/models, and the configured brain is in the list. If it isn’t, print the exact `ollama pull` command.
- /chat returns a well-formed response to a real question, along with the node list and how many seconds it took.
- VoiceStudio responds at /health, the selected engine and model match config.json, and /falar returns a real WAV with the number of seconds until the first byte.
- THE CIRCUIT — generate a phrase known in advance with /falar, send that WAV to /ouvir, and check that the same words come back (allow small differences). This proves the voice and ears understand each other.
- /lembrar writes a real file, and /chat finds the note right afterward (then delete the test note).
- The files the browser RECEIVES are the same as those on disk.
- config.json must NOT be accessible to the browser. This check must fail loudly if it does.
- A ?mute=1 tab is truly silent: the single playback function refuses when the flag is enabled.
- No cloud keys appear in painel/.

Finish with two lines. First, the TIME BUDGET: listen X s, think Y s, speak Z s, total — measured this run. Second, the summary: N ok, N failures, N warnings. Exit with a nonzero code if there are any failures. Missing voice and ears are a WARNING, not a FAILURE, because the assistant still works with the browser’s voice.

Now run it and show me the output. If anything fails, fix the cause and run it again until it’s clean. Don’t describe what it would say: run it.

From now on, whenever you say a change is ready, run verificar_tudo.py first and paste the two lines. “Ready” means the verifier is green.
```

**Your numbers:** the time budget is a snapshot of your machine. Compare it with the table in `MODELOS.en.md` and decide whether a larger or smaller model is worthwhile.
