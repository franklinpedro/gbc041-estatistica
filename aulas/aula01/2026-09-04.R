# nesta primeira aula, exploramos o rstudio e aprendemos conceitos básicos da
# linguagem R, incluindo operações básicas, atribuição de valores, tipos de
# dados, vetores e suas operações, comparações lógicas, valores ausentes (NA) e
# uma primeira simulação probabilística.

# a aula ficou dividida assim:
# - rstudio e execução de código;
# - operações aritméticas;
# - criação de objetos;
# - tipos de dados;
# - valores lógicos e comparações;
# - vetores;
# - funções;
# - valores ausentes;
# - simulação.

# -------------------------------------------------------------------------
# 1. rstudio e primeiros comandos
# -------------------------------------------------------------------------

# o rstudio é uma IDE (ambiente integrado de desenvolvimento) que facilita
# escrever e executar códigos na linguagem r. sua interface é organizada em
# quatro painéis principais:
#
# - editor: onde escrevemos e salvamos nossos códigos;
# - console: onde os comandos são executados e seus resultados são exibidos;
# - environment: onde podemos visualizar os objetos criados durante a sessão;
# - files/plots/packages/help: reúne ferramentas para navegar pelos arquivos,
#   visualizar gráficos, gerenciar pacotes e consultar a documentação do r.

# para executar uma linha de código no editor, basta posicionar o cursor
# sobre ela e pressionar o botão de Run (aquele com uma setinha verde) ou pressionar # o atalho ctrl + enter (ou cmd + enter no mac). o comando
# será enviado ao console, onde será executado, e o resultado será exibido
# logo abaixo. 

# -------------------------------------------------------------------------
# 2. r como calculadora e atribuição de valores
# -------------------------------------------------------------------------


2 + 2 # soma
2 - 2 # subtração
3*7 # multiplicação
42/2 # divisão
2^3 # potenciação
2**3 # outra forma de potenciação
65 %% 3 # o operador %% retorna o resto da divisão inteira de 65 por 3


# para guardar um valor em um objeto (uma "variável"), usamos o
# operador de atribuição <-. O nome à esquerda passa a representar
# o valor calculado à direita

a <- 2 + 2
a

# também é possível atribuir "ao contrário", com ->
# aqui o resultado de 2 + 20 é guardado em b
2 + 20 -> b

# regra para nomes de variáveis:
# - podem conter letras, números, ponto (.) e underline (_)
# - devem começar com uma letra
# - são case sensitive: "idade" e "Idade" são objetos diferentes
# - não podem começar com número 
# - não podem usar palavras reservadas do R (ex.: TRUE, FALSE, if,
#   for, function, NA)
# - por convenção, evite espaços e acentos nos nomes; prefira
#   nomes descritivos, como idade_media em vez de x

# uma vez criados, os objetos podem ser usados em novas operações
a + b

d <- 5 %% 2
a + d

# a função class() mostra o tipo de dado armazenado no objeto
# aqui, a é um número, por isso a classe é "numeric"
class(a)

# -------------------------------------------------------------------------
# 3. tipos de dados
# -------------------------------------------------------------------------

f <- "amendoim"
class(f)   

f1 <- "frida"
rm(f1) # rm() remove um objeto do ambiente

f + f
# ERRO ESPERADO: não é possível somar strings com o operador +
# o R não sabe "somar" texto, por isso essa linha gera erro

# valores lógicos: TRUE e FALSE (sempre em maiúsculas, sem aspas)
m <- TRUE
n <- FALSE
class(m) # "logical"
class(n) # "logical"

# internamente, R trata TRUE como 1 e FALSE como 0,
# então é possível somar valores lógicos
m + n 
m + m
n + n

# "TRUE" entre aspas é uma string, não um valor lógico
x <- "TRUE"
class(x)
x + x

# -------------------------------------------------------------------------
# 4. vetores
# -------------------------------------------------------------------------

# um vetor é uma sequência de valores do mesmo tipo. Criamos um
# vetor com a função c() (combine, concatenate)

v <- c(2,50,100) 
w <- c(1,7,90)

# operações entre vetores de mesmo tamanho são feitas elemento a elemento
v + w # 2+1, 50+7, 100+90

# é possível somar vetores de tamanhos diferentes
# o vetor menor é reciclado
y <- c(3,7)
v+y
# observe a saída com warning; não foi erro, porque o r executa a operação

# multiplicação/divisão por um único número (escalar) também é
# aplicada a cada elemento do vetor
2 * w
w / 2

# podemos acessar elementos de um vetor
v[1] # aqui, estamos acessando o elemento que está na primeira posicao de v
v[3] # aqui, estamos acessando o elemento que está na terceira posicao de v

# como acessar mais de um elemento de uma só vez?
v[1,3] # aqui temos um erro, v não tem duas dimensões; isso será feito
# para acessar elementos de matrizes, por exemplo

v[c(1,3)] # especificamos as posições que queremos através de um vetor!

v[0] # vazio, pois o R começa a contar do 1

# é possível pedir vários índices de uma vez, inclusive repetidos
v[c(1, 3, 1, 1)]

# pedir um índice que não existe retorna NA (valor ausente),
v[5]

# é possível atribuir valor a uma posição além do tamanho atual do
# vetor: o R expande o vetor automaticamente
v[4] <- 10
v

v[6] <- 43 # aqui pulamos a posição 5, que fica como NA
v

# o operador : cria uma sequência de números inteiros
3:5 # retorna o vetor 3,4,5
10:15 # retorna o vetor 10,11,12,13,14,15

v[3:5] # elementos de v das posições 3 a 5
z <- 234:765
z
z[82] # elemento da posicao 82 da sequência

# a função length() retorna o número de elementos de um vetor
length(v)


# ATENÇÃO: um vetor só pode ter UM tipo de dado. Se atribuirmos uma
# string a um vetor numérico, TODOS elementos são convertidos para string
v[7] <- "amendoim"
v # agora v inteiro é do tipo character

# -------------------------------------------------------------------------
# 5. comparações, resumo de vetores e valores ausentes
# -------------------------------------------------------------------------

# comparações também são vetorizadas: cada elemento é comparado
# individualmente, gerando um vetor lógico (TRUE/FALSE)

w == 1 # cada elemento de w é comparado a 1 e a saída é um vetor lógico
# se TRUE na entrada j, então a entrada j de w era 1
# se FALSE, então a entrada j de w era diferente de 1

sum(w == 1) # w == 1 é um vetor lógico e dissemos antes que valores logicos
# são vistos como 1 (TRUE) ou zero (false); então somar um vetor logico é 
# obter a quantidade de valores TRUE

w != 1 # o operador != realiza a operacao "diferente de":
# ele retorna TRUE nas posições em que w não é 1

a1 <- w != 1 # guardamos esse vetor lógico no objeto a1
a1
sum(a1) # soma de elementos (quantos são diferentes de 1)
mean(a1) # média de um vetor lógico = PROPORÇÃO de TRUEs
a1 <- w != 1
a1
sum(a1) # soma de elementos (quantos são diferentes de 1)
mean(a1) # média de um vetor lógico = PROPORÇÃO de TRUEs

# --- valores ausentes (NA) ---
# ao atribuir um valor à posição 5 de um vetor que só tinha 3 elementos
# a posição 4 (que ficou "pulada") vira NA automaticamente
w[5] <- 12
w

mean(w) # a média de w retornou NA porque w tinha um valor ausente

# podemos solicitar o cálculo da média de w desconsiderando seus valores ausentes
mean(w, na.rm = TRUE) # o argumento na.rm é para remover NA

# o mesmo argumento funciona em outras funções de resumo, como sum()
sum(w) # também retorna NA, pelo mesmo motivo
sum(w, na.rm = TRUE)

# --- funções e argumentos nomeados ---
# ?nome_da_funcao abre a documentação da função no RStudio
?round

# round() arredonda um número para um número escolhido de casas decimais.
# Ela tem dois argumentos principais:
#   x: o número (ou vetor de números) a ser arredondado
#   digits: quantas casas decimais manter no resultado
# argumentos podem ser passados por nome, em qualquer ordem
round(x = mean(w, na.rm = TRUE), digits = 2)
round(digits = 2, x = mean(w, na.rm = TRUE)) # mesmo resultado, ordem invertida
round(32.6667, 2) # ou por posição, sem nomear os argumentos (x, digits, nessa ordem)

# -------------------------------------------------------------------------
# 6. simulação e probabilidade
# -------------------------------------------------------------------------

# sample() sorteia valores aleatoriamente de um conjunto. Ela tem
# três argumentos principais:
#   x: o conjunto de valores de onde o sorteio é feito
#   size: quantos valores sortear
#   replace: se TRUE, um valor já sorteado pode ser sorteado de novo
#            (sorteio "com reposição"); se FALSE (padrão), cada valor
#            só pode ser sorteado uma vez
#
# aqui simulamos 1 milhão de lançamentos de um dado de 6 faces:
# sorteamos entre os valores 1 a 6 (x = 1:6), um milhão de vezes
# (size = 1000000), permitindo repetição (replace = TRUE), já que em
# lançamentos de dado o mesmo número pode sair mais de uma vez
dados <- sample(x = 1:6, size = 1000000, replace = TRUE)
dados

dados == 1 # vetor lógico: TRUE nos lançamentos que deram 1
dados[974] # resultado do 974º lançamento

sum(dados == 1) # quantas vezes saiu 1
mean(dados == 1) # proporção de vezes que saiu 1 (frequência relativa)

# compare com a probabilidade teórica de sair 1 em um dado justo:
1/6

# agora simulamos a soma de dois dados lançados juntos
dados1 <- sample(x = 1:6, size = 100000, replace = TRUE)
dados2 <- sample(x = 1:6, size = 100000, replace = TRUE)
soma_dados <- dados1 + dados2
soma_dados[1:10] # 10 primeiras somas simuladas

# proporção de vezes que a soma dos dois dados deu 3
mean(soma_dados == 3)
# a probabilidade da soma ser 3 no lancamento de dois dados é:
2/36
#compare o valor simulado com o valor teórico!