# Nesta aula vamos começar a estudar correlação.
# O conjunto traz o comprimento do fêmur e a altura de 99 pessoas,
# medidos em centímetros. Cada linha corresponde a uma pessoa;
# portanto, o fêmur e a altura de uma mesma linha formam um par de medidas.
# Pergunta: conhecendo só o fêmur, dá para dizer a altura de uma pessoa?

# Carrega os pacotes usados para construir gráficos e filtrar os dados.
library(ggplot2)
library(dplyr)

# Importando o arquivo
femur <- read.csv(file = "femur.csv", header = TRUE)

# O diagrama de dispersão apresenta a relação entre fêmur e altura.
# Cada ponto representa uma pessoa: sua posição horizontal indica o
# comprimento do fêmur e sua posição vertical indica a altura.
# aes() associa as colunas aos eixos e à cor dos pontos.
# colour = genero permite identificar os grupos Male e Female.
# geom_point() desenha os pontos; o sinal + acrescenta essa camada ao gráfico.
ggplot(data = femur, aes(x = femur, y = altura, colour = genero)) +
  geom_point()

# O que dá para dizer? Observe a direção, a forma e a força da relação.
# Direção: fêmures maiores tendem a acompanhar alturas maiores (positiva).
# Forma: os pontos seguem uma tendência aproximadamente linear.
# Força: quanto mais próximos de uma reta, mais forte a relação linear.
# Observe também se há pontos afastados da tendência e diferenças entre grupos.
# A tendência não significa que um comprimento de fêmur determine uma altura
# exata: pessoas com fêmures semelhantes podem ter alturas diferentes.

# separando os dados para examinar a relação dentro de cada grupo.

homens <- femur |>
  filter(genero == "Male")

mulheres <- femur |>
  filter(genero == "Female")

# Mostrando apenas os homens, usando as mesmas variáveis nos eixos.

ggplot(data = homens, aes(x = femur, y = altura)) +
  geom_point()

# Calcula o coeficiente de correlação de Pearson (método padrão de cor()).
# O símbolo $ seleciona uma coluna: homens$femur contém os comprimentos
# dos fêmures, e homens$altura contém as alturas das mesmas pessoas.
# A correlação usa esses pares de medidas e resume a direção e a força
# da relação linear em um número r entre -1 e 1, sem unidade de medida.
cor(homens$femur, homens$altura)

# Nesta base, o resultado para os homens é aproximadamente 0,901.
# O sinal positivo indica que as duas medidas tendem a crescer juntas.
# O valor próximo de 1 indica uma relação linear forte neste conjunto.
# Esse número não significa 90,1% de acerto, nem informa quantos centímetros
# de altura correspondem a cada centímetro de fêmur.
# Valores próximos de -1 indicam relação linear negativa forte;
# valores próximos de 0 indicam pouca ou nenhuma relação linear,
# mas ainda pode existir uma relação de outra forma, como uma curva.
# Por isso, devemos olhar o gráfico antes de interpretar a correlação.
# Pontos atípicos podem alterar bastante o resultado, e correlação não
# demonstra uma relação de causa e efeito.

# Para estudar: faça o gráfico das mulheres e calcule a correlação entre
# mulheres$femur e mulheres$altura. Em qual grupo a relação linear é mais forte?
# A correlação ajuda a avaliar se o fêmur pode ser útil para prever a altura.
# Para obter uma previsão numérica de altura, precisamos de um modelo,
# como a regressão linear, assunto das próximas aulas.
