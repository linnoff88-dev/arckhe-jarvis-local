# Prompt 08 · O teste sem internet

```text
Prove que uma conversa com o assistente nunca sai desta máquina, e depois faça isso valer com o Wi-Fi desligado.

1. BIBLIOTECAS PARA DENTRO — o painel ainda carrega as bibliotecas 3D de um CDN. Baixe as versões fixas uma vez para painel/vendor/, troque os imports para esses arquivos locais e remova qualquer outra referência a CDN. Registre versões e URLs de origem em painel/vendor/VERSOES.txt. Depois disso a página tem que abrir sem rede nenhuma.

2. O VIGIA — embrulhe as conexões HTTP de saída do servidor para registrar cada conexão aberta com o host e o motivo, e leia as entradas de "resource timing" do navegador depois de cada turno. Crie GET /teste/conexoes que devolve as duas listas do último turno.

3. O TESTE, em script — comece um turno novo, mande uma pergunta real ao /chat, fale a resposta pelo /falar, devolva esse WAV ao /ouvir, busque /teste/conexoes e IMPRIMA todo host que não seja localhost nem 127.0.0.1. O teste só passa com essa lista vazia. Se o "modo nuvem" estiver ligado, o teste TEM que falhar e citar o host da nuvem — isso prova que o vigia funciona.

4. A LISTA HONESTA — o teste termina imprimindo, lido do código e não da memória, o que ainda precisa de internet: a nuvem se estiver configurada, pesquisa na web se existir, e o que mais você achar. Nenhum recurso pode depender de internet sem estar nessa lista.

5. O VERIFICADOR GANHA DOIS ITENS — nenhuma referência a CDN em painel/, e o teste sem internet passando no modo local.

6. PROVA — rode o teste no modo local e cole a lista vazia; rode no modo nuvem e cole a falha; rode o verificar_tudo.py e cole as duas linhas. Depois me dê um roteiro de 4 passos para gravar isso: desligar o Wi-Fi, recarregar a página, fazer uma pergunta cuja resposta está numa nota, e o que eu devo ver e ouvir.
```

**A cena:** ícone do Wi-Fi riscado no canto, uma pergunta, a galáxia voando até a nota, a resposta na sua voz. Ninguém discute com isso.
