# Prompt 05 · Memória que cresce pela voz

```text
Quero aumentar o segundo cérebro falando.

- Quando eu falar ou digitar algo começando com "anota que" (ou "lembra que", "não me deixa esquecer"), mande para uma rota nova POST /lembrar, que grava um arquivo .md DE VERDADE numa pasta capturas/ dentro da minha pasta de notas, com um título tirado das primeiras palavras e a data de hoje dentro do arquivo.
- A nota nova entra na galáxia AO VIVO, sem recarregar a página: nasce na posição da nota mais parecida, dá um pulso de luz e a câmera voa até ela.
- Ligue a nota no grafo do mesmo jeito que o indexar.py faria, para ela ser cidadã de verdade e já poder ser fonte da próxima resposta.
- Confirme em voz alta, em uma linha, no personagem e na voz clonada.

UMA PORTA PARA NOTAS NOVAS — no servidor, UMA função (grava o arquivo, acrescenta o nó ao grafo.js, põe no índice de busca em memória, devolve o índice). No painel, UMA função (novaNota: nasce, liga, pulsa, voa). Toda função futura que cria nota passa por essas duas.

A RESPOSTA SE PROVA — o /chat já devolve os índices usados. Voe a câmera até a nota principal e abra o painel dela enquanto a resposta é falada, para eu ver de onde veio. Se usou 4 ou mais notas, acenda o grupo todo em vez de voar para uma. Conversa fiada nunca mexe a câmera: decida se a pergunta era sobre as notas ANTES de decidir mexer em qualquer coisa.

Dois cuidados, porque mordem depois:
1. Gravar o arquivo não é indexar. A nota nova tem que ser encontrada pelo /chat na pergunta seguinte, sem rodar o indexar.py de novo.
2. Captura nunca falha calada. Se a gravação falhar por qualquer motivo, ele diz em voz alta. Segundo cérebro que esquece em silêncio é pior que nenhum.

Depois me faça testar: eu digo "Jarvis, anota que a janela de conclusão ideal é 900 milissegundos", você me mostra a estrela nascendo, e eu pergunto em seguida algo que deve trazer essa nota.
```

**Ajuste:** acrescente as frases que você fala sem pensar ("registra isso", "nota mental"). A captura só funciona se o gatilho é o seu jeito de falar.
