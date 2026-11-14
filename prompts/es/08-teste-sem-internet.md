# Prompt 08 · La prueba sin internet

```text
Demuestra que una conversación con el asistente nunca sale de esta máquina y luego haz que siga funcionando con el Wi-Fi apagado.

1. BIBLIOTECAS LOCALES — el panel todavía carga las bibliotecas 3D desde un CDN. Descarga una vez las versiones fijas en painel/vendor/, cambia los imports para que usen esos archivos locales y elimina cualquier otra referencia a CDN. Registra las versiones y las URL de origen en painel/vendor/VERSOES.txt. Después de eso, la página debe abrirse sin conexión.

2. EL VIGILANTE — envuelve las conexiones HTTP salientes del servidor para registrar cada conexión abierta, con el host y el motivo, y lee las entradas de «resource timing» del navegador después de cada turno. Crea GET /teste/conexoes, que devuelva las dos listas del último turno.

3. LA PRUEBA, EN UN SCRIPT — inicia un turno nuevo, envía una pregunta real a /chat, reproduce la respuesta con /falar, envía ese WAV a /ouvir, consulta /teste/conexoes e IMPRIME todos los hosts que no sean localhost ni 127.0.0.1. La prueba solo pasa si la lista está vacía. Si el «modo nube» está activado, la prueba TIENE que fallar y mencionar el host de la nube; eso demuestra que el vigilante funciona.

4. LA LISTA HONESTA — la prueba termina imprimiendo, a partir del código y no de la memoria, lo que todavía necesita internet: la nube, si está configurada; la búsqueda web, si existe; y cualquier otra cosa que encuentres. Ningún recurso puede depender de internet sin aparecer en esa lista.

5. EL VERIFICADOR SUMA DOS ELEMENTOS — ninguna referencia a CDN en painel/ y la prueba sin internet pasando en modo local.

6. PRUEBA — ejecuta la prueba en modo local y pega la lista vacía; ejecútala en modo nube y pega el fallo; ejecuta verificar_tudo.py y pega las dos líneas. Luego dame una guía de 4 pasos para grabarlo: apagar el Wi-Fi, recargar la página, hacer una pregunta cuya respuesta esté en una nota y decirme qué debo ver y oír.
```

**La escena:** el ícono del Wi-Fi tachado en la esquina, una pregunta, la galaxia volando hasta la nota, la respuesta con tu voz. Nadie puede discutir eso.
