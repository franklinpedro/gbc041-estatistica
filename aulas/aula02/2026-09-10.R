# nesta aula, exploramos duas estruturas de repetição em r
# as estruturas foram: for e while
# exploramos as estruturas por meio de exemplos envolvendo
# simulações probabilísticas.
#
# a aula ficou dividida assim:
# - simulação de lançamentos de um dado;
# - média acumulada;
# - estrutura de repetição for;
# - seleção e comparação de elementos em vetores;
# - operador %in%;
# - simulação de sorteios de loteria;
# - estrutura de repetição while.

# -------------------------------------------------------------------------
# 1. simulação de lançamentos de um dado
# -------------------------------------------------------------------------

# na aula anterior, utilizamos a função sample()
# esta função realiza sorteios aleatórios.
# podemos consultar sua documentação utilizando:
?sample

# vamos simular n lançamentos de um dado justo de seis faces
n <- 5000
dado <- sample(x = 1:6, size = n, replace = TRUE)

# calculamos a média dos resultados obtidos
mean(dado)

# em um dado justo, os valores possíveis são 1, 2, 3, 4, 5 e 6.
# a média teórica desses valores é 3.5. com um número grande de
# lançamentos, esperamos que a média observada se aproxime desse valor

# -------------------------------------------------------------------------
# 2. média acumulada
# -------------------------------------------------------------------------

# em vez de calcular apenas a média final, podemos acompanhar como a média
# dos resultados se comporta à medida que novos lançamentos são realizados

# cumsum() calcula a soma acumulada dos elementos de um vetor
soma_acumulada <- cumsum(dado)

# para obter a média após cada lançamento, dividimos a soma acumulada pelo
# número de observações disponíveis naquele momento
media_acumulada <- soma_acumulada / 1:n

# visualizamos a evolução da média acumulada
plot(x = 1:n, y = media_acumulada, type = "l")

# adicionamos uma linha horizontal em 3.5, a média teórica de um dado justo
abline(h = 3.5, col = "red")

# observe que, conforme o número de lançamentos aumenta, então
# a média acumulada tende a se aproximar de 3.5

# -------------------------------------------------------------------------
# 3. estrutura de repetição for
# -------------------------------------------------------------------------

# agora queremos repetir um experimento várias vezes.
# para isso, podemos utilizar a estrutura de repetição for
#
# sua estrutura básica é:
#
# for (j in valores) {
#   comandos que serão repetidos
# }
#
# a cada repetição, j assume um dos valores especificados após "in"

# queremos agora repetir esse experimento muitas vezes para observar como
# se comportam as médias obtidas. a ideia é realizar os seguintes passos:
#
# 1. simular 10.000 lançamentos de um dado;
# 2. calcular a média dos valores obtidos;
# 3. guardar essa média;
# 4. repetir os passos anteriores 10.000 vezes.
#
# fazer isso escrevendo os mesmos comandos 10.000 vezes não seria viável.
# podemos automatizar essa repetição utilizando a estrutura for.

# criamos inicialmente um vetor vazio para armazenar as médias
medias <- c()

# repetimos o experimento 10.000 vezes
for (j in 1:10000) {
  
  # em cada repetição, simulamos 10.000 lançamentos de um dado
  dado <- sample(x = 1:6, size = 10000, replace = TRUE)
  
  # calculamos a média e armazenamos o resultado na posição j
  medias[j] <- mean(dado)
}

# ao final, medias contém as 10.000 médias obtidas nas simulações
hist(medias)

# observe que as médias simuladas ficam concentradas em torno de 3.5

# -------------------------------------------------------------------------
# 4. seleção de elementos de um vetor
# -------------------------------------------------------------------------

# vamos simular 100 lançamentos de um dado
dado <- sample(x = 1:6, size = 100, replace = TRUE)
dado

# como vimos na aula anterior, uma comparação produz um vetor lógico
dado == 5

# um vetor lógico também pode ser utilizado dentro dos colchetes para
# selecionar elementos de um vetor
dado[dado != 5]

# o comando acima retorna apenas os elementos de dado que são diferentes
# de 5. os elementos associados a TRUE são mantidos e os associados a
# FALSE são descartados

# -------------------------------------------------------------------------
# 5. verificando elementos com o operador %in%
# -------------------------------------------------------------------------

# vamos considerar agora um experimento envolvendo uma loteria: mega-sena
# suponha que fizemos uma aposta escolhendo seis números entre 1 e 60.
# em seguida, são sorteados, sem reposição, seis números desse mesmo conjunto.
#
# nosso objetivo é descobrir quantos números do nosso bilhete foram sorteados.

# os seis números escolhidos para o nosso bilhete são:
bilhete <- c(3, 15, 43, 21, 20, 35)

# simulamos o sorteio de seis números entre 1 e 60, sem reposição
sorteio <- sample(x = 1:60, size = 6, replace = FALSE)
sorteio

# queremos agora comparar nosso bilhete com o resultado do sorteio.
# uma primeira tentativa poderia ser:
sorteio == bilhete

# entretanto, essa comparação é feita posição a posição: o primeiro número
# de sorteio é comparado ao primeiro de bilhete, o segundo ao segundo, e
# assim por diante. isso não responde à pergunta que queremos.

# não importa a posição em que um número foi sorteado; queremos saber se
# cada número do bilhete aparece em alguma posição do vetor sorteio.
#
# para responder a essa pergunta, utilizamos o operador %in%
bilhete %in% sorteio

# o resultado é um vetor lógico com uma posição para cada número do bilhete:
# TRUE indica que o número foi sorteado e FALSE indica que não foi.

# como TRUE é tratado como 1 e FALSE como 0 em operações numéricas,
# podemos contar quantos números do bilhete foram sorteados usando sum()
sum(bilhete %in% sorteio)

# -------------------------------------------------------------------------
# 6. simulando muitos sorteios de loteria
# -------------------------------------------------------------------------

# agora utilizamos um for para repetir o sorteio muitas vezes e observar
# quantos números do bilhete são acertados em cada repetição

bilhete <- c(3, 15, 43, 21, 20, 35)

# criamos um vetor vazio para armazenar o número de acertos de cada sorteio
acertos <- c()

for (j in 1:100000) {
  
  # realizamos um novo sorteio
  sorteio <- sample(x = 1:60, size = 6, replace = FALSE)
  
  # contamos quantos números do bilhete aparecem no sorteio e armazenamos
  # o resultado na posição j
  acertos[j] <- sum(bilhete %in% sorteio)
}

# table() conta quantas vezes ocorreu cada número de acertos
table(acertos)

# podemos visualizar essas frequências utilizando um gráfico de barras
barplot(table(acertos))

# -------------------------------------------------------------------------
# 7. estrutura de repetição while
# -------------------------------------------------------------------------

# no exemplo anterior, sabíamos antecipadamente quantas vezes queríamos
# repetir o experimento: 100.000 vezes. por isso, utilizamos um for.
#
# agora queremos responder a uma pergunta diferente: suponha que fazemos
# uma aposta por semana, sempre com os mesmos seis números. quantas semanas
# precisaríamos jogar até ganhar um prêmio pela primeira vez?
#
# vamos considerar três possibilidades:
# - quadra: acertar pelo menos 4 números;
# - quina: acertar pelo menos 5 números;
# - sena: acertar os 6 números.
#
# nesse caso, não sabemos antecipadamente quantos sorteios serão necessários.
# queremos continuar realizando sorteios ENQUANTO ainda não tivermos atingido
# o número de acertos necessário para ganhar.
#
# para esse tipo de problema, podemos utilizar a estrutura while:
#
# while (condicao) {
#   comandos que serão repetidos
# }
#
# o bloco é repetido enquanto a condição for TRUE e termina quando ela
# se torna FALSE.

# escolhemos os seis números do nosso bilhete
bilhete <- c(3, 15, 43, 21, 20, 35)

# semanas contará quantos sorteios foram necessários até o primeiro prêmio
semanas <- 0

# começamos com zero acertos
acertos <- 0

# começamos procurando quanto tempo levaria até obter pelo menos uma quadra.
# enquanto tivermos menos de 4 acertos, continuamos jogando
while (acertos < 4) {
  
  # avançamos uma semana
  semanas <- semanas + 1
  
  # realizamos um novo sorteio
  sorteio <- sample(x = 1:60, size = 6, replace = FALSE)
  
  # contamos quantos números do bilhete foram sorteados
  acertos <- sum(bilhete %in% sorteio)
}

# quando o while termina, encontramos pela primeira vez um sorteio
# em que acertamos pelo menos 4 números

semanas

# considerando uma aposta por semana, transformamos o tempo de espera
# de semanas para anos
semanas / 52