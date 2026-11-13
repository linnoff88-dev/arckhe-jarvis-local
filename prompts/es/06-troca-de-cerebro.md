# Prompt 06 · Cambiar de cerebro hablando

> Lo local es lo predeterminado y todo funciona sin internet. La nube es opcional; solo se usa cuando TÚ lo pides, para tareas pesadas (investigación en la web, trabajar con mucho código).

```text
Quiero cambiar de cerebro y de voz hablando, y ver siempre cuáles están activos.

1. EL ESTANTE — en config.json, un bloque "cerebros" con entradas con nombre, cada una con base_url, modelo, api_key y extra_body opcional. Empieza con:
   - "local": la entrada de Ollama del prompt 01;
   - "grande": otra etiqueta de Ollama que completaré (el modelo más grande que cabe en mi memoria; consulta MODELOS.es.md);
   - "nube": [elige UNA opción: (a) un endpoint compatible con OpenAI con MI clave, que yo mismo escribiré en el archivo; o (b) el CLI al que ya estoy suscrito — `claude -p` o `codex exec` — llamado como subproceso, sin ninguna clave].
   Si la nube no está configurada, "cambia a la nube" responde en una línea breve que no hay una nube configurada y continúa en local. Nunca me pidas la clave en el chat.

2. COMANDOS — "cambia al cerebro local", "cambia al grande", "cambia a la nube", "¿en qué cerebro estás?", "todo local" (cerebro, voz y oídos locales a la vez) y "modo nube". Los cambios solo duran hasta reiniciar: al iniciar, vuelve al cerebro indicado en "cerebro_inicial" de config.json (predeterminado: "local"). Cada cambio se confirma en una línea breve, dicha con la configuración NUEVA.

3. EL SELLO — una línea discreta debajo del estado con CEREBRO y VOZ; por ejemplo: CEREBRO local qwen3.5:9b · VOZ local Jarvis. Permanece oculta y aparece durante 5 segundos cada vez que uno de los dos cambia realmente, incluso cuando la voz pasa a la del navegador porque el motor dejó de funcionar. La misma voz en todas las respuestas nunca activa el sello.

4. HONESTIDAD — cuando una solicitud necesita la nube y está desactivada (investigación web en vivo, algo que el modelo local dice que no puede hacer), avisa en una línea en lugar de fingir. Añade esta regla al bloque de personalidad.

5. CARGANDO — al cambiar a un modelo que Ollama todavía no ha cargado, di "un momento" mientras se carga, en lugar de guardar silencio.

6. PRUEBA — en una pestaña ?mute=1, ejecuta todos los comandos y muestra cómo aparece y desaparece el sello; demuestra que al reiniciar vuelve al cerebro configurado y que ninguna clave aparece en painel/ ni en las solicitudes del navegador (grep).
```

**Dónde destaca la máquina grande:** con memoria de sobra, añade junto al modelo de 9B el más grande que quepa (32 GB → `qwen3.8:27b`; 96 GB o más → `gpt-oss:120b`; consulta MODELOS.es.md) y hazles las mismas 5 preguntas a ambos. La diferencia entre las respuestas es todo el argumento a favor de tener más memoria.
