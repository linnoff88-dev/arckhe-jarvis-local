# Prompt 07 · O verificador (o mais importante)

> Testes de unidade passam e a corrente real está morta: é aí que dói. Este prompt cria um verificador que chama o sistema DE VERDADE e mede a sua máquina.

```text
Monte um verificador geral. É o prompt mais importante do projeto, então capriche.

Escreva verificar_tudo.py que roda cada corrente REAL de ponta a ponta e dá um veredito. Nada de mock: chamadas de verdade contra o sistema rodando.

Confira, em ordem, com ✓ ou ✗ em cada item:
- O servidor está no ar e servindo o painel.
- O grafo carrega e tem mais de zero nós.
- O Ollama responde em /v1/models e o cérebro configurado está na lista. Se não estiver, imprima o comando exato de `ollama pull`.
- O /chat devolve uma resposta bem formada para uma pergunta real, com a lista de nós e os segundos que levou.
- O VoiceStudio responde /health, o motor e o modelo selecionados batem com o config.json, e o /falar devolve um WAV de verdade com os segundos até o primeiro byte.
- O CIRCUITO — gere uma frase conhecida pelo /falar, mande esse WAV para o /ouvir e confira se voltam as mesmas palavras (aceite pequenas diferenças). Isso prova que voz e ouvidos se entendem.
- O /lembrar grava um arquivo real e a nota já é encontrada pelo /chat logo depois (e depois apague a nota de teste).
- Os arquivos que o navegador RECEBE são os mesmos do disco.
- O config.json NÃO pode ser acessado pelo navegador. Esse item tem que falhar alto se falhar.
- Uma aba ?mute=1 fica muda de verdade: a função única de tocar recusa quando a marca está ligada.
- Nenhuma chave de nuvem aparece em painel/.

Termine com duas linhas. Primeira, o ORÇAMENTO DE TEMPO: ouvir X s, pensar Y s, falar Z s, total — medido nesta rodada. Segunda, o resumo: N ok, N falha, N aviso. Saia com código diferente de zero se houver falha. Voz e ouvidos ausentes são AVISO, não FALHA, porque o assistente ainda funciona com a voz do navegador.

Agora rode e me mostre a saída. Se algo falhar, corrija a causa e rode de novo até ficar limpo. Não descreva o que ele diria: rode.

A partir de agora, sempre que disser que uma mudança está pronta, rode verificar_tudo.py antes e cole as duas linhas. "Pronto" quer dizer verificador verde.
```

**Seus números:** o orçamento de tempo é o retrato da sua máquina. Compare com a tabela de `MODELOS.md` e decida se vale um modelo maior ou menor.
