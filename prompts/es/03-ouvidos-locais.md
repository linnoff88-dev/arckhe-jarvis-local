# Prompt 03 · Los oídos locales

> Antes: `faster-whisper` (Linux/Windows, usa la tarjeta NVIDIA) o `mlx-whisper` (Mac Apple Silicon) instalado en el Python del kit (`~/.jarvis-local/venv`) — el instalador ya se encarga de eso. El servidor debe ejecutarse con ese Python (el `iniciar.sh` del prompt 01).

```text
Dale oídos al asistente que se ejecuta en esta máquina. Nada de reconocimiento de voz del navegador en este proyecto: envía el audio a la nube.

1. MÓDULO DE AUDICIÓN — ouvir.py, usando mlx_whisper en Mac Apple Silicon y faster_whisper en el resto (con la GPU NVIDIA cuando esté disponible), importado de forma opcional; pero si la importación falla, el panel debe mostrarlo y el asistente debe decir en voz alta «me quedé sin oídos: ejecútame con el Python del kit», nunca quedarse callado. En Linux con NVIDIA, el iniciar.sh del prompt 01 debe exportar LD_LIBRARY_PATH con las carpetas lib de nvidia.cublas y nvidia.cudnn (paquetes pip que el instalador instaló en el venv) ANTES de iniciar Python; de lo contrario, faster-whisper no encuentra libcudnn. Si aun así falla la GPU, pasa a la CPU con compute_type int8 y avisa. Agrega a config.json:
   "audicion": {"modelo": "large-v3-turbo", "modelo_activacion": "small", "idioma": "es"}
   (en Mac: "mlx-community/whisper-large-v3-turbo" y "mlx-community/whisper-small-mlx").
   Carga ambos modelos UNA vez al iniciar, mantenlos en memoria y calienta cada uno con 1 segundo de silencio. POST /ouvir recibe un WAV y devuelve {"texto", "segundos"}.

2. MICRÓFONO — en el panel, captura con getUserMedia y genera WAV de 16 kHz mono de 16 bits en el propio navegador, sin ffmpeg. Mide el volumen todo el tiempo. El habla comienza cuando el volumen supera un límite y termina después de SILENCIO_MS de silencio (constante al inicio del archivo, empieza en 700). Ignora fragmentos de menos de 300 ms. Luego aplica la VENTANA DE CONCLUSIÓN: guarda el texto y espera FIM_MS (empieza en 900) por si hay más habla antes de enviarlo, porque a veces me detengo a mitad de las frases. Si hay más habla, júntala y reinicia el reloj.

3. PALABRA DE ACTIVACIÓN — un botón «manos libres». Cuando está activado, toda habla pasa primero por el Whisper PEQUEÑO (small). Si el texto empieza con «Jarvis» (o «oye Jarvis», «hola Jarvis»), quita el nombre y envía el resto al Whisper GRANDE (large-v3-turbo; no es el cerebro) y luego a /chat. Si solo dijo el nombre, responde «¿Sí?» y trata la siguiente intervención como un comando. La habla sin el nombre se descarta: nunca se registra ni se envía. Un botón «presiona para hablar» omite la activación y va directo al Whisper grande.

4. INTERRUMPIR — mientras habla el asistente, sigue escuchando, pero solo para «detente» y «espera», que cortan el audio de inmediato. Sube el límite de volumen mientras habla para que su propia voz saliendo del altavoz no dispare nada, y dime claramente si en mi caso necesito usar auriculares.

5. ESTADO — una línea de estado que muestre escuchando / escuché (con el texto) / pensando / hablando, para que siempre sepa de quién es el turno. Las pestañas con ?mute=1 siguen escuchando, solo que no hablan.

6. PRUEBA — un guion de prueba con lo que digo y lo que debería ver, incluyendo una pausa a mitad de una frase (para probar la ventana de conclusión), una frase sin «Jarvis» que debe descartarse y los segundos medidos entre el final de mi intervención y el texto en pantalla.
```

**Ajuste fino:** SILENCIO_MS y FIM_MS son los valores más personales del proyecto. Ajústalos después de un día de uso, de a uno por vez: uno depende de cómo haces pausas y el otro de cuánto te tomas para pensar.
