# Prompt 07 · El verificador (el más importante)

> Las pruebas unitarias pasan y el flujo real está muerto: ahí es donde duele. Este prompt crea un verificador que llama al sistema DE VERDAD y mide tu máquina.

```text
Crea un verificador general. Es el prompt más importante del proyecto, así que hazlo con cuidado.

Escribe verificar_tudo.py para que ejecute cada flujo REAL de punta a punta y dé un veredicto. Nada de mocks: llamadas reales contra el sistema en funcionamiento.

Comprueba, en este orden, con ✓ o ✗ en cada elemento:
- El servidor está en funcionamiento y sirve el panel.
- El grafo carga y tiene más de cero nodos.
- Ollama responde en /v1/models y el cerebro configurado está en la lista. Si no está, imprime el comando exacto de `ollama pull`.
- /chat devuelve una respuesta bien formada a una pregunta real, junto con la lista de nodos y los segundos que tardó.
- VoiceStudio responde en /health, el motor y el modelo seleccionados coinciden con config.json, y /falar devuelve un WAV real con los segundos hasta el primer byte.
- EL CIRCUITO: genera una frase conocida con /falar, envía ese WAV a /ouvir y comprueba que vuelvan las mismas palabras (acepta pequeñas diferencias). Esto demuestra que la voz y los oídos se entienden.
- /lembrar guarda un archivo real y la nota se encuentra mediante /chat justo después (y luego elimina la nota de prueba).
- Los archivos que recibe el navegador son los mismos que están en el disco.
- No se puede acceder a config.json desde el navegador. Este elemento debe fallar de forma clara si falla.
- Una pestaña ?mute=1 queda realmente en silencio: la función única de reproducción se niega a reproducir cuando la marca está activada.
- No aparece ninguna clave de nube en painel/.

Termina con dos líneas. La primera, el PRESUPUESTO DE TIEMPO: escuchar X s, pensar Y s, hablar Z s, total — medido en esta ejecución. La segunda, el resumen: N correctos, N fallas, N avisos. Sal con un código distinto de cero si hay alguna falla. La ausencia de voz y oídos cuenta como AVISO, no como FALLA, porque el asistente sigue funcionando con la voz del navegador.

Ahora ejecútalo y muéstrame la salida. Si algo falla, corrige la causa y vuelve a ejecutarlo hasta que todo quede limpio. No describas lo que haría: ejecútalo.

A partir de ahora, cada vez que digas que un cambio está listo, ejecuta verificar_tudo.py antes y pega las dos líneas. «Listo» significa que el verificador queda en verde.
```

**Tus números:** el presupuesto de tiempo es una instantánea de tu máquina. Compáralo con la tabla de `MODELOS.es.md` y decide si vale la pena usar un modelo más grande o más pequeño.
