# Prompt 01 · A galáxia e o cérebro local

> Cole no Claude Code (ou Codex) aberto numa pasta vazia, por exemplo `~/meu-jarvis`.
> Antes, rode `python3 instalar/verificar.py` (na pasta do kit) e confirme que o cérebro (Ollama) está ✓.
> A tag do cérebro e o caminho do Python do kit estão em `~/.jarvis-local/minha-maquina.json` (gravado pelo instalador).
> Troque o que está entre colchetes. O resto, cole inteiro.

```text
Quero um assistente pessoal que roda 100% na minha máquina. Nesta primeira etapa, monte a base inteira de uma vez e só me diga que terminou depois de subir e testar.

PYTHON: rode tudo deste projeto com [o "python" de ~/.jarvis-local/minha-maquina.json, ex.: ~/.jarvis-local/venv/bin/python] — é ali que o instalador pôs o Whisper. Crie um iniciar.sh (e iniciar.bat no Windows) que sobe o servidor com esse Python; no Linux com NVIDIA, o iniciar.sh exporta antes o LD_LIBRARY_PATH com as pastas lib dos pacotes nvidia.cublas e nvidia.cudnn desse venv.

MINHAS NOTAS: [caminho completo da pasta com meus arquivos .md — ou escreva "não tenho notas; crie 30 notas de exemplo sobre um pequeno negócio em ./notas"]

1. INDEXADOR — indexar.py, Python 3 só com a biblioteca padrão. Lê todos os .md da pasta de notas e grava painel/grafo.js com `const GRAFO = {nos: [...], ligacoes: [...]}`. Cada nó: título (nome do arquivo), grupo (pasta-mãe), um trecho de ~700 caracteres e um id numérico igual à sua posição na lista. Duas notas se ligam quando uma cita o título da outra ou quando dividem um [[link]].

2. PAINEL — painel/index.html, página única, sem npm e sem build. Use a biblioteca 3d-force-graph por CDN com a versão FIXA (o prompt 08 traz ela para dentro do projeto). Visual de cinema: fundo preto, campo de estrelas, nós brilhando pela cor do grupo, rotação lenta quando parado. Clicar num nó voa a câmera até ele, acende os vizinhos e abre um painel lateral com o trecho.

3. SERVIDOR — servidor.py na porta 4700, preso em 127.0.0.1, servindo SÓ a pasta painel/. Crie config.json na RAIZ do projeto (nunca dentro de painel/):
   {"cerebro": {"base_url": "http://localhost:11434/v1", "modelo": "[tag do instalador, ex.: qwen3.5:9b]", "api_key": "ollama", "extra_body": {"reasoning_effort": "none"}}}
   Fale com o modelo no formato de chat completions compatível com OpenAI, usando urllib (sem SDK) e mesclando extra_body em toda requisição. O mesmo código precisa funcionar com outro endpoint mudando só base_url, modelo e api_key.

4. PERGUNTAR — rota POST /chat. Pontue cada nota contra a pergunta por palavras em comum (título vale mais), pegue as 6 melhores e mande para o modelo. Instrução de sistema: responda SÓ com base nessas notas, em 2 ou 3 frases, e diga claramente quando as notas não cobrem o assunto. Devolva {"resposta": "...", "nos": [índices usados]}. Guarde um histórico curto no servidor para perguntas de continuação. Barra de pergunta limpa no rodapé do painel.

5. REGRAS DO CÉREBRO LOCAL (aqui cada palavra custa segundos, não centavos):
   - A instrução de sistema é IDÊNTICA em todo turno e vem PRIMEIRO; notas e pergunta vêm por ÚLTIMO, para o modelo reaproveitar o cache.
   - Instrução de sistema com menos de 400 palavras.
   - Quem desliga o "pensamento silencioso" é o extra_body (reasoning_effort none). Não invente outra flag.
   - Pelo menos 600 tokens de resposta; se voltar texto vazio, tente uma vez com o dobro.

6. TERMINAR DIREITO — suba o servidor, confirme que a página abre e o grafo aparece, faça uma pergunta real ao /chat e mostre a resposta E quantos segundos levou. Depois me dê 3 perguntas de exemplo baseadas nos títulos reais das minhas notas.
```

**Anote os segundos** que aparecerem no fim: são a sua linha de base. Os prompts 04 e 07 são onde você ganha tempo de volta.
