# Prompt 08 · The Offline Test

```text
Prove that a conversation with the assistant never leaves this machine, then make sure it works with Wi-Fi turned off.

1. BUNDLE THE LIBRARIES LOCALLY — the dashboard still loads 3D libraries from a CDN. Download the pinned versions once into painel/vendor/, switch the imports to those local files, and remove any other CDN references. Record the versions and source URLs in painel/vendor/VERSOES.txt. After that, the page must open with no network connection.

2. THE WATCHER — wrap the server’s outgoing HTTP connections to log each connection opened, along with its host and reason, and read the browser’s “resource timing” entries after each turn. Create GET /teste/conexoes to return both lists from the last turn.

3. THE TEST, IN A SCRIPT — start a new turn, send a real question to /chat, speak the answer with /falar, send that WAV back to /ouvir, fetch /teste/conexoes, and PRINT every host other than localhost or 127.0.0.1. The test passes only if that list is empty. If “cloud mode” is enabled, the test MUST fail and name the cloud host — that proves the watcher works.

4. THE HONEST LIST — the test ends by printing, based on the code and not memory, what still needs internet: the cloud if configured, web search if available, and anything else you find. No feature may depend on the internet without being on that list.

5. THE CHECKER GETS TWO MORE ITEMS — no CDN references in painel/, and the offline test passing in local mode.

6. PROOF — run the test in local mode and paste the empty list; run it in cloud mode and paste the failure; run verificar_tudo.py and paste the two lines. Then give me a 4-step plan to record this: turn off Wi-Fi, reload the page, ask a question whose answer is in a note, and tell me what I should see and hear.
```

**The scene:** a crossed-out Wi-Fi icon in the corner, a question, the galaxy flying to the note, the answer in your voice. No one can argue with that.
