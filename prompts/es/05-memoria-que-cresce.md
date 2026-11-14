# Prompt 05 · Memoria que crece con la voz

```text
Quiero ampliar mi segundo cerebro hablando.

- Cuando diga o escriba algo que empiece con «anota que» (o «recuerda que», «no me dejes olvidar»), envíalo a una nueva ruta POST /lembrar, que guarda un archivo .md DE VERDAD en una carpeta capturas/ dentro de mi carpeta de notas, con un título tomado de las primeras palabras y la fecha de hoy dentro del archivo.
- La nota nueva entra en la galaxia EN VIVO, sin recargar la página: nace en la posición de la nota más parecida, emite un pulso de luz y la cámara vuela hasta ella.
- Conecta la nota al grafo del mismo modo que lo haría indexar.py, para que sea una ciudadana de verdad y ya pueda servir de fuente para la siguiente respuesta.
- Confirma en voz alta, en una línea, en personaje y con la voz clonada.

UNA PUERTA PARA NOTAS NUEVAS — en el servidor, UNA función (guarda el archivo, añade el nodo a grafo.js, lo pone en el índice de búsqueda en memoria y devuelve el índice). En el panel, UNA función (nuevaNota: nace, conecta, pulsa, vuela). Toda función futura que cree una nota pasa por estas dos.

LA RESPUESTA SE DEMUESTRA — /chat ya devuelve los índices usados. Vuela la cámara hasta la nota principal y abre su panel mientras se dice la respuesta, para que yo vea de dónde viene. Si usó 4 o más notas, ilumina todo el grupo en vez de volar hacia una sola. La charla trivial nunca mueve la cámara: decide si la pregunta era sobre las notas ANTES de decidir mover cualquier cosa.

Dos cuidados, porque después dan problemas:
1. Guardar el archivo no es indexarlo. El /chat tiene que encontrar la nota nueva en la siguiente pregunta, sin volver a ejecutar indexar.py.
2. La captura nunca falla en silencio. Si el guardado falla por cualquier motivo, dilo en voz alta. Un segundo cerebro que olvida en silencio es peor que no tener ninguno.

Después hazme probarlo: digo «Jarvis, anota que el tiempo ideal de conclusión es 900 milisegundos», me muestras la estrella naciendo y luego pregunto algo cuya respuesta debería incluir esa nota.
```

**Ajuste:** agrega las frases que dices sin pensarlo («registra esto», «nota mental»). La captura solo funciona si el disparador refleja tu manera de hablar.
