# nesta aula, aprenderemos a estrutura condicional if-else e começaremos
# a trabalhar com análise de dados a partir de um conjunto de dados real


# -------------------------------------------------------------------------
# 1. if-else
# -------------------------------------------------------------------------

# para aprendermos a estrutura if-else, vamos considerar o seguinte jogo:
#
# - uma urna contém 15 bolas: 7 pretas, 7 vermelhas e 1 branca;
# - para participar de uma rodada, pagamos R$ 10 e apostamos em uma cor;
# - uma bola é sorteada aleatoriamente da urna;
# - se apostarmos em vermelho e a bola sorteada for vermelha, recebemos R$ 20;
# - se apostarmos em preto e a bola sorteada for preta, recebemos R$ 20;
# - se apostarmos em branco e a bola sorteada for branca, recebemos R$ 140;
# - se a cor sorteada for diferente daquela em que apostamos, não recebemos
#   nenhum valor.
#
# queremos simular várias rodadas desse jogo e acompanhar quanto dinheiro
# teremos ao longo das apostas.
#
# em cada rodada, será necessário tomar uma decisão:
#
# se a cor sorteada for igual à cor em que apostamos,
#     adicionamos o prêmio ao nosso dinheiro;
# caso contrário,
#     não adicionamos nenhum valor.
#
# para implementar esse tipo de decisão, utilizamos a estrutura if-else.


# construímos a urna com uma bola branca, sete pretas e sete vermelhas
urna <- c("branca", rep("preta", times = 7), rep("vermelha", times = 7))


# vamos supor que começamos o jogo com R$ 100 e realizamos 500 apostas,
# apostando sempre na cor branca
dinheiro <- 100
aposta <- "branca"

# criamos um objeto para registrar quanto dinheiro temos ao longo do jogo.
# inicialmente, ele contém apenas nosso valor inicial
historico <- dinheiro


# repetimos o jogo 500 vezes
for (j in 1:500) {
  
  # antes de cada sorteio, pagamos R$ 10 para participar
  dinheiro <- dinheiro - 10
  
  # sorteamos uma bola da urna
  sorteio <- sample(x = urna, size = 1)
  
  # verificamos se a cor sorteada é igual à cor em que apostamos
  if (sorteio == aposta) {
    
    # se a condição for verdadeira, recebemos o prêmio
    dinheiro <- dinheiro + 140
    
  } else {
    
    # se a condição for falsa, não recebemos nenhum valor
    dinheiro <- dinheiro
  }
  
  # registramos quanto dinheiro temos após a rodada
  historico <- c(historico, dinheiro)
}


# visualizamos como nosso dinheiro se comportou ao longo das 500 apostas.
# a linha horizontal representa o valor de R$ 100 com que começamos
plot(x = 0:500, y = historico, type = "l")
abline(h = 100, col = "red")


# observe a estrutura utilizada:
#
# if (condicao) {
#   comandos executados se a condição for TRUE
# } else {
#   comandos executados se a condição for FALSE
# }
#
# diferentemente de for e while, o if-else não é uma estrutura de repetição.
# ele é uma estrutura condicional: permite escolher quais comandos serão
# executados de acordo com o resultado de uma condição.


# -------------------------------------------------------------------------
# 2. importando dados e realizando primeiras análises
# -------------------------------------------------------------------------

# vamos começar nossa primeira análise de dados utilizando informações
# sobre os passageiros do Titanic.
#
# o conjunto de dados está armazenado no arquivo titanic.csv. para trazer
# essas informações para o R, utilizamos a função read.csv()
titanic <- read.csv(file = "titanic.csv", header = TRUE, sep = ",")


# o objeto titanic é um data frame: uma estrutura organizada em linhas
# e colunas. cada linha representa uma observação e cada coluna representa
# uma variável
titanic


# nossa primeira pergunta é: quantos passageiros estão registrados
# no conjunto de dados?
#
# dim() informa as dimensões do data frame: número de linhas e de colunas.
# como queremos apenas o número de linhas, selecionamos o primeiro resultado
dim(titanic)[1]

# podemos obter diretamente o número de linhas utilizando nrow()
nrow(titanic)

# e o número de colunas utilizando ncol()
ncol(titanic)


# podemos visualizar o conjunto de dados em uma janela semelhante
# a uma planilha
View(titanic)


# agora queremos saber: quais informações temos sobre cada passageiro?
#
# names() retorna os nomes das variáveis presentes no data frame
names(titanic)


# assim como fizemos com vetores, podemos utilizar colchetes para selecionar
# elementos de um data frame. como ele possui duas dimensões, indicamos
# primeiro a linha e depois a coluna:
#
# objeto[linha, coluna]

# selecionamos a quinta linha, mantendo todas as colunas
titanic[5, ]

# selecionamos a sexta coluna, mantendo todas as linhas
titanic[, 6]


# além de conhecer os nomes das variáveis, é importante saber que tipo
# de informação está armazenada em cada uma delas.
#
# str() mostra a estrutura do objeto, incluindo suas dimensões, os nomes
# das variáveis, seus tipos e alguns de seus valores
str(titanic)


# outra maneira de acessar uma variável de um data frame é utilizar $.
# por exemplo, acessamos a variável Age da seguinte forma:
titanic$Age


# agora podemos começar a responder perguntas sobre os passageiros.
#
# quantos passageiros morreram?
#
# a variável Survived indica se o passageiro sobreviveu:
# 0 representa quem morreu e 1 representa quem sobreviveu.
#
# a comparação abaixo produz TRUE para os passageiros que morreram
# e FALSE para os demais
titanic$Survived == 0


# como TRUE é tratado como 1 e FALSE como 0 em operações numéricas,
# podemos somar o resultado para contar quantos passageiros morreram
sum(titanic$Survived == 0)


# pela mesma razão, a média do vetor lógico fornece a proporção de
# passageiros que morreram
mean(titanic$Survived == 0)


# também poderíamos calcular essa proporção dividindo o número de
# passageiros que morreram pelo número total de passageiros
sum(titanic$Survived == 0) / 891


# entretanto, escrever diretamente 891 exige que já saibamos quantos
# passageiros existem no conjunto. podemos utilizar nrow() para que o
# próprio R obtenha essa informação
sum(titanic$Survived == 0) / nrow(titanic)


# será que a proporção de passageiros que morreram foi a mesma em todas
# as classes?
#
# vamos começar investigando apenas os passageiros da terceira classe.
# a expressão titanic$Pclass == 3 identifica quais passageiros pertenciam
# à terceira classe. utilizamos esse vetor lógico para selecionar as
# respectivas linhas do data frame
terceira_classe <- titanic[titanic$Pclass == 3, ]


# agora terceira_classe é um novo data frame contendo apenas os passageiros
# da terceira classe
terceira_classe


# calculamos a proporção de passageiros da terceira classe que morreram
sum(terceira_classe$Survived == 0) / nrow(terceira_classe)