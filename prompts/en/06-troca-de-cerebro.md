# Prompt 06 · Switch Brains by Voice

> Local is the default, and everything works offline. The cloud is optional, only when YOU ask for it, for heavy tasks (web research, working with large codebases).

```text
I want to switch brains and voices by speaking, and always see which ones are active.

1. THE SHELF — in config.json, add a "cerebros" block with named entries, each with base_url, modelo, api_key, and optional extra_body. Start with:
   - "local": the Ollama entry from prompt 01;
   - "grande": another Ollama tag that I’ll fill in (the largest model that fits in my memory — see MODELOS.en.md);
   - "nuvem": [choose ONE: (a) an OpenAI-compatible endpoint with MY key, which I’ll write into the file myself; or (b) the CLI I already subscribe to — `claude -p` or `codex exec` — called as a subprocess, with no key at all].
   If the cloud isn’t configured, “switch to the cloud” responds with one plain line saying no cloud is configured and continues locally. Never ask me for a key in chat.

2. COMMANDS — “switch to the local brain,” “switch to the large one,” “switch to the cloud,” “which brain are you using?”, “all local” (brain, voice, and ears all local at once), and “cloud mode.” Switches last only until restart: on startup, it returns to the brain in "cerebro_inicial" in config.json (default "local"). Confirm each switch with one short line, spoken using the NEW configuration.

3. THE BADGE — a discreet line below the status showing BRAIN and VOICE, e.g.: BRAIN local qwen3.5:9b · VOICE local Jarvis. It stays hidden and appears for 5 seconds whenever either one actually changes, including when the voice falls back to the browser’s because the engine died. The same voice on every response never triggers the badge.

4. HONESTY — when a request needs the cloud and it’s turned off (live web research, something the local model says it can’t do), it says so in one line instead of pretending. Put this rule in the personality block.

5. LOADING — when switching to a model Ollama hasn’t loaded yet, say “one moment” while it loads instead of staying silent.

6. PROOF — in a ?mute=1 tab, run all the commands and show the badge appearing and disappearing, prove that restarting returns to the configured brain, and prove that no key appears in painel/ or in browser requests (grep).
```

**Where the big machine shines:** with memory to spare, add the largest model that fits alongside the 9B one (`qwen3.8:27b` with 32 GB; `gpt-oss:120b` with 96 GB+, see MODELOS.en.md) and ask both the same 5 questions. The difference in their answers is the whole argument for more memory.
