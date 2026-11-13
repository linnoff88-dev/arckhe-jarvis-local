# Prompt 02 · La voz clonada

> Antes: VoiceStudio abierto (puerto 3900), un motor con licencia libre instalado (VoxCPM2 habla español) y un perfil de voz llamado **Jarvis** clonado a partir de 10–20 s de TU voz (o de alguien que haya dado su autorización).

```text
Ahora dale voz al asistente usando VoiceStudio, que está abierto en esta máquina en http://127.0.0.1:3900.

1. MÓDULO DE VOZ — voz.py, solo biblioteca estándar, importado de forma opcional por servidor.py (sin él, el asistente se inicia con normalidad). Agrega a config.json:
   "voz": {"url": "http://127.0.0.1:3900", "motor": "[id del motor, p. ej.: voxcpm2]", "modelo": "[id del modelo, p. ej.: openbmb/VoxCPM2 — consulta Model Catalogue]", "perfil": "Jarvis", "idioma": "es"}
   Al iniciar (y una vez cada vez que se reinicie el motor), haz POST /engines/select con {"family": "tts", "backend_id": MOTOR, "model_id": MODELO}, para fijar el motor y que nunca se cambie sin aviso. Descubre el id del perfil por nombre en GET /profiles.

2. RUTA — POST /falar con {"texto"} devuelve audio/wav llamando a POST /v1/audio/speech con {"model": MODELO, "input": texto, "voice": ID_DO_PERFIL, "response_format": "wav", "language": IDIOMA}. Máximo 600 caracteres por solicitud. Guarda cada WAV en disco con un hash de texto+perfil (las frases repetidas, como el saludo, se reproducen al instante). Cada respuesta lleva el encabezado X-Jarvis-Voz: local:NOME_DO_PERFIL.

3. MOTOR CALIENTE — cada 10 minutos en reposo, genera "A tus órdenes." y descarta el audio para que el modelo no se enfríe y la primera intervención del día no tarde 7 segundos.

4. REPRODUCTOR (y la regla de oro) — divide cada respuesta en bloques de ~170 caracteres formados por frases COMPLETAS. Solicita el primer bloque, reprodúcelo y empieza a buscar el siguiente mientras se reproduce el primero, para que no haya interrupciones. NO acortes el primer bloque para empezar más rápido: una voz que se detiene a mitad de la frase suena entrecortada; prefiero esperar un segundo más.

5. PLAN B — si GET /health no responde en 1 segundo, habla con la voz del navegador (Web Speech API) y marca X-Jarvis-Voz: navegador. Nunca fallar en silencio, nunca bloquearse.

6. SILENCIO — si la URL tiene ?mute=1, nada habla en esa pestaña. La comprobación va dentro de la ÚNICA función que reproduce audio, para que nada se escape.

7. COMANDOS DE VOZ — una lista de rutas (patrón de frase + acción) que se comprueba ANTES de que la frase llegue al cerebro. Empieza con "usa la voz local" y "usa la voz del navegador". Los siguientes prompts agregan rutas a esa lista.

8. PRUEBA — reproduce una frase de 10 palabras y una respuesta de 80 palabras, muestra los segundos hasta el primer sonido de cada una, confirma que el segundo bloque ya estaba listo cuando terminó el primero y que una pestaña con ?mute=1 quedó en silencio.
```

**Consejo:** el audio de referencia lo decide todo. Graba con el micrófono y en la sala que vas a usar, leyendo 2 o 3 frases tranquilas. Un fragmento corto y limpio clona mejor que uno largo con respiración o ruido de silla.
