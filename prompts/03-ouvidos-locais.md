# Prompt 03 · Os ouvidos locais

> Antes: `faster-whisper` (Linux/Windows, usa a placa NVIDIA) ou `mlx-whisper` (Mac Apple Silicon) instalado no Python do kit (`~/.jarvis-local/venv`) — o instalador já faz isso. O servidor tem de rodar com esse Python (o `iniciar.sh` do prompt 01).

```text
Dê ouvidos ao assistente rodando nesta máquina. Nada de reconhecimento de voz do navegador neste projeto: ele manda o áudio para a nuvem.

1. MÓDULO DE AUDIÇÃO — ouvir.py, usando mlx_whisper no Mac Apple Silicon e faster_whisper no resto (com a GPU NVIDIA quando houver), importado de forma opcional — mas se a importação falhar, o painel mostra e o assistente diz em voz alta "estou sem ouvidos: rode com o Python do kit", nunca sobe calado. No Linux com NVIDIA, o iniciar.sh do prompt 01 tem de exportar o LD_LIBRARY_PATH com as pastas lib de nvidia.cublas e nvidia.cudnn (pacotes pip que o instalador pôs no venv) ANTES de subir o Python, senão o faster-whisper não acha a libcudnn; se mesmo assim a GPU falhar, caia para a CPU com compute_type int8 e avise. Acrescente ao config.json:
   "audicao": {"modelo": "large-v3-turbo", "modelo_ativacao": "small", "idioma": "pt"}
   (no Mac: "mlx-community/whisper-large-v3-turbo" e "mlx-community/whisper-small-mlx").
   Carregue os dois modelos UMA vez ao iniciar, mantenha na memória e aqueça cada um com 1 segundo de silêncio. POST /ouvir recebe um WAV e devolve {"texto", "segundos"}.

2. MICROFONE — no painel, capture com getUserMedia e gere WAV 16 kHz mono 16 bits no próprio navegador, sem ffmpeg. Meça o volume o tempo todo. A fala começa quando o volume passa de um limite e termina depois de SILENCIO_MS de quieto (constante no topo do arquivo, começando em 700). Ignore trechos com menos de 300 ms. Depois aplique a JANELA DE CONCLUSÃO: guarde o texto e espere FIM_MS (começa em 900) por mais fala antes de enviar, porque eu paro no meio das frases. Mais fala = junta e reinicia o relógio.

3. PALAVRA DE ATIVAÇÃO — um botão "mãos livres". Ligado, toda fala passa primeiro pelo Whisper PEQUENO (small). Se o texto começar com "Jarvis" (ou "ei Jarvis", "oi Jarvis"), tire o nome e mande o resto ao Whisper GRANDE (large-v3-turbo; não é o cérebro) e depois ao /chat. Se só disse o nome, responda "Pois não?" e trate a próxima fala como comando. Fala sem o nome é descartada: nunca registrada, nunca enviada. Um botão "aperte para falar" pula a ativação e vai direto ao Whisper grande.

4. INTERROMPER — enquanto o assistente fala, continue ouvindo, mas só para "para" e "espera", que cortam o áudio na hora. Suba o limite de volume enquanto ele fala, para a própria voz dele saindo da caixa não disparar nada, e me diga claramente se o meu caso pede fone de ouvido.

5. ESTADO — uma linha de status mostrando ouvindo / ouvi (com o texto) / pensando / falando, para eu saber sempre de quem é a vez. Abas com ?mute=1 continuam ouvindo, só não falam.

6. PROVA — um roteiro de teste com o que eu falo e o que devo ver, incluindo uma pausa no meio da frase (prova a janela de conclusão), uma frase sem "Jarvis" que deve ser descartada, e os segundos medidos entre o fim da minha fala e o texto na tela.
```

**Ajuste fino:** SILENCIO_MS e FIM_MS são os números mais pessoais do projeto. Ajuste depois de um dia de uso, um de cada vez: um é como você pausa, o outro é como você pensa.
