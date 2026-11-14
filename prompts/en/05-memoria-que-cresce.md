# Prompt 05 · A Voice-Grown Memory

```text
I want to expand my second brain by speaking.

- When I say or type something that starts with “make a note that” (or “remember that,” “don’t let me forget”), send it to a new POST /lembrar route, which saves a REAL .md file in a capturas/ folder inside my notes folder, with a title taken from the first few words and today’s date inside the file.
- The new note appears in the galaxy LIVE, without reloading the page: it appears at the position of the most similar note, gives a pulse of light, and the camera flies to it.
- Connect the note to the graph the same way indexar.py would, so it’s a real member and can already be a source for the next answer.
- Confirm out loud, in one line, in character and with the cloned voice.

ONE DOOR FOR NEW NOTES — on the server, ONE function (saves the file, adds the node to grafo.js, puts it in the in-memory search index, returns the index). In the panel, ONE function (novaNota: appears, connects, pulses, flies). Every future function that creates a note goes through these two.

THE ANSWER SHOWS ITS WORK — /chat already returns the indices used. Fly the camera to the main note and open its panel while the answer is being spoken, so I can see where it came from. If it used 4 or more notes, light up the whole group instead of flying to just one. Small talk never moves the camera: decide whether the question was about the notes BEFORE deciding to move anything.

Two things to watch out for, because they’ll bite later:
1. Saving the file isn’t the same as indexing it. The new note must be found by /chat in the next question, without running indexar.py again.
2. Capture must never fail silently. If saving fails for any reason, it says so out loud. A second brain that forgets silently is worse than no second brain.

Then have me test it: I say, “Jarvis, make a note that the ideal completion window is 900 milliseconds,” you show me the star appearing, and then I ask something that should bring up that note.
```

**Adjustment:** add the phrases you say without thinking (“make a note of that,” “mental note”). Capture only works if the trigger sounds like the way you actually speak.
