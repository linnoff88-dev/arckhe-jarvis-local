# Prompt 06 · Trocar de cérebro falando

> Local é o padrão e tudo funciona sem internet. A nuvem é opcional, só quando VOCÊ pedir, para tarefas pesadas (pesquisa na web, mexer em código grande).

```text
Quero trocar de cérebro e de voz falando, e ver sempre quais estão ligados.

1. A PRATELEIRA — no config.json, um bloco "cerebros" com entradas nomeadas, cada uma com base_url, modelo, api_key e extra_body opcional. Comece com:
   - "local": a entrada do Ollama do prompt 01;
   - "grande": outra tag do Ollama que eu vou preencher (o maior modelo que cabe na minha memória — veja MODELOS.md);
   - "nuvem": [escolha UMA: (a) um endpoint compatível com OpenAI com a MINHA chave, que eu mesmo escrevo no arquivo; ou (b) o CLI que eu já assino — `claude -p` ou `codex exec` — chamado como subprocesso, sem chave nenhuma].
   Se a nuvem não estiver configurada, "muda para a nuvem" responde numa linha seca que não há nuvem configurada e continua local. Nunca me peça chave no chat.

2. COMANDOS — "muda para o cérebro local", "muda para o grande", "muda para a nuvem", "em qual cérebro você está?", "tudo local" (cérebro, voz e ouvidos locais de uma vez) e "modo nuvem". As trocas valem só até reiniciar: ao subir, ele volta para o cérebro em "cerebro_inicial" do config.json (padrão "local"). Cada troca é confirmada numa linha curta, dita pela configuração NOVA.

3. O SELO — uma linha discreta abaixo do status com CÉREBRO e VOZ, ex.: CÉREBRO local qwen3.5:9b · VOZ local Jarvis. Fica escondida e aparece por 5 segundos sempre que um dos dois muda de verdade, inclusive quando a voz cai para a do navegador porque o motor morreu. A mesma voz em toda resposta nunca dispara o selo.

4. HONESTIDADE — quando um pedido precisa da nuvem e ela está desligada (pesquisa na web ao vivo, algo que o modelo local diz não conseguir), ele avisa em uma linha em vez de fingir. Coloque essa regra no bloco de personalidade.

5. CARREGANDO — ao trocar para um modelo que o Ollama ainda não carregou, diga "um instante" enquanto carrega, em vez de silêncio.

6. PROVA — numa aba ?mute=1, rode todos os comandos e mostre o selo aparecendo e sumindo, prove que reiniciar volta para o cérebro configurado e prove que nenhuma chave aparece em painel/ nem nas requisições do navegador (grep).
```

**Onde a máquina grande brilha:** com memória sobrando, coloque ao lado do de 9B o maior que couber (32 GB → `qwen3.8:27b`; 96 GB+ → `gpt-oss:120b`, veja MODELOS.md) e pergunte as mesmas 5 coisas aos dois. A diferença nas respostas é o argumento inteiro a favor de mais memória.
