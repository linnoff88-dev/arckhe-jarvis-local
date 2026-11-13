# Prompt 01 · La galaxia y el cerebro local

> Pégalo en Claude Code (o Codex) abierto en una carpeta vacía, por ejemplo `~/mi-jarvis`.
> Antes, ejecuta `python3 instalar/verificar.py` (en la carpeta del kit) y confirma que el cerebro (Ollama) esté ✓.
> La etiqueta del cerebro y la ruta de Python del kit están en `~/.jarvis-local/minha-maquina.json` (guardado por el instalador).
> Reemplaza lo que está entre corchetes. El resto, pégalo completo.

```text
Quiero un asistente personal que funcione 100 % en mi máquina. En esta primera etapa, monta toda la base de una vez y dime que terminaste solo después de iniciarlo y probarlo.

PYTHON: ejecuta todo este proyecto con [el "python" de ~/.jarvis-local/minha-maquina.json, p. ej.: ~/.jarvis-local/venv/bin/python] — ahí es donde el instalador puso Whisper. Crea un iniciar.sh (y iniciar.bat en Windows) que inicie el servidor con ese Python; en Linux con NVIDIA, iniciar.sh exporta antes LD_LIBRARY_PATH con las carpetas lib de los paquetes nvidia.cublas y nvidia.cudnn de ese venv.

MIS NOTAS: [ruta completa de la carpeta con mis archivos .md — o escribe "no tengo notas; crea 30 notas de ejemplo sobre un pequeño negocio en ./notas"]

1. INDEXADOR — indexar.py, solo Python 3 y la biblioteca estándar. Lee todos los .md de la carpeta de notas y guarda painel/grafo.js con `const GRAFO = {nos: [...], ligacoes: [...]}`. Cada nodo: título (nombre del archivo), grupo (carpeta principal), un fragmento de ~700 caracteres y un id numérico igual a su posición en la lista. Dos notas se conectan cuando una cita el título de la otra o cuando comparten un [[enlace]].

2. PANEL — painel/index.html, página única, sin npm ni build. Usa la biblioteca 3d-force-graph por CDN con la versión FIJA (el prompt 08 la incorpora al proyecto). Visual cinematográfica: fondo negro, campo de estrellas, nodos que brillan según el color del grupo, rotación lenta cuando está inactivo. Al hacer clic en un nodo, la cámara vuela hasta él, ilumina sus vecinos y abre un panel lateral con el fragmento.

3. SERVIDOR — servidor.py en el puerto 4700, enlazado a 127.0.0.1, sirviendo SOLO la carpeta painel/. Crea config.json en la RAÍZ del proyecto (nunca dentro de painel/):
   {"cerebro": {"base_url": "http://localhost:11434/v1", "modelo": "[etiqueta del instalador, p. ej.: qwen3.5:9b]", "api_key": "ollama", "extra_body": {"reasoning_effort": "none"}}}
   Habla con el modelo en el formato de chat completions compatible con OpenAI, usando urllib (sin SDK) y combinando extra_body en cada solicitud. El mismo código debe funcionar con otro endpoint cambiando solo base_url, modelo y api_key.

4. PREGUNTAR — ruta POST /chat. Puntúa cada nota frente a la pregunta según las palabras en común (el título vale más), toma las 6 mejores y envíaselas al modelo. Instrucción del sistema: responde SOLO con base en estas notas, en 2 o 3 frases, y di claramente cuando las notas no cubran el tema. Devuelve {"resposta": "...", "nos": [índices usados]}. Guarda un historial breve en el servidor para preguntas de seguimiento. Barra de preguntas sencilla en el pie del panel.

5. REGLAS DEL CEREBRO LOCAL (aquí cada palabra cuesta segundos, no centavos):
   - La instrucción del sistema es IDÉNTICA en cada turno y va PRIMERO; las notas y la pregunta van AL FINAL, para que el modelo reutilice la caché.
   - Instrucción del sistema de menos de 400 palabras.
   - Quien desactiva el "pensamiento silencioso" es extra_body (reasoning_effort none). No inventes otra opción.
   - Al menos 600 tokens de respuesta; si devuelve texto vacío, inténtalo una vez con el doble.

6. TERMINAR BIEN — inicia el servidor, confirma que la página se abra y que aparezca el grafo, haz una pregunta real a /chat y muestra la respuesta Y cuántos segundos tardó. Después dame 3 preguntas de ejemplo basadas en los títulos reales de mis notas.
```

**Anota los segundos** que aparezcan al final: son tu línea de base. Los prompts 04 y 07 son donde recuperas tiempo.
