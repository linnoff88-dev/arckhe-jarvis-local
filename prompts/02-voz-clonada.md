# Prompt 02 · A voz clonada

> Antes: VoiceStudio aberto (porta 3900), um motor com licença livre instalado (VoxCPM2 fala português) e um perfil de voz chamado **Jarvis** clonado a partir de 10–20 s da SUA voz (ou de alguém que autorizou).

```text
Agora dê voz ao assistente usando o VoiceStudio, que está aberto nesta máquina em http://127.0.0.1:3900.

1. MÓDULO DE VOZ — voz.py, só biblioteca padrão, importado de forma opcional pelo servidor.py (sem ele o assistente sobe normal). Acrescente ao config.json:
   "voz": {"url": "http://127.0.0.1:3900", "motor": "[id do motor, ex.: voxcpm2]", "modelo": "[id do modelo, ex.: openbmb/VoxCPM2 — confira em Model Catalogue]", "perfil": "Jarvis", "idioma": "pt"}
   Ao iniciar (e uma vez a cada vez que o motor reiniciar), faça POST /engines/select com {"family": "tts", "backend_id": MOTOR, "model_id": MODELO}, para o motor ficar fixo e nunca ser trocado sem aviso. Descubra o id do perfil pelo nome em GET /profiles.

2. ROTA — POST /falar com {"texto"} devolve audio/wav chamando POST /v1/audio/speech com {"model": MODELO, "input": texto, "voice": ID_DO_PERFIL, "response_format": "wav", "language": IDIOMA}. No máximo 600 caracteres por pedido. Guarde cada WAV em disco por um hash de texto+perfil (frases repetidas, como a saudação, saem na hora). Toda resposta leva o cabeçalho X-Jarvis-Voz: local:NOME_DO_PERFIL.

3. MOTOR AQUECIDO — a cada 10 minutos parado, gere "Às ordens." e descarte o áudio, para o modelo não esfriar e a primeira fala do dia não demorar 7 segundos.

4. TOCADOR (e a regra de ouro) — quebre cada resposta em blocos de ~170 caracteres feitos de frases INTEIRAS. Peça o primeiro bloco, toque, e já busque o próximo enquanto o primeiro toca, para não haver buraco. NÃO encurte o primeiro bloco para começar mais rápido: voz que para no meio da frase soa quebrada; prefiro esperar um segundo a mais.

5. PLANO B — se GET /health não responder em 1 segundo, fale com a voz do navegador (Web Speech API) e marque X-Jarvis-Voz: navegador. Nunca falhar calado, nunca travar.

6. MUDO — se a URL tiver ?mute=1, nada naquela aba fala. A checagem fica dentro da ÚNICA função que toca áudio, para nada escapar dela.

7. COMANDOS DE VOZ — uma lista de rotas (padrão de frase + ação) checada ANTES de a frase ir para o cérebro. Comece com "usa a voz local" e "usa a voz do navegador". Os próximos prompts acrescentam rotas nessa lista.

8. PROVA — toque uma frase de 10 palavras e uma resposta de 80 palavras, mostre os segundos até o primeiro som de cada uma, confirme que o 2º bloco já estava pronto quando o 1º acabou e que uma aba com ?mute=1 ficou muda.
```

**Dica:** o áudio de referência decide tudo. Grave no microfone e na sala que você vai usar, lendo 2 ou 3 frases calmas. Um trecho curto e limpo clona melhor que um longo com respiração ou barulho de cadeira.
