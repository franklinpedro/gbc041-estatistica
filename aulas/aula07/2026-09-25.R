# CONSTRUÇÃO DO MODELO
# Vamos prever a espécie de um pinguim usando o comprimento e a profundidade do bico.
# Como conhecemos as espécies dos exemplos, esta é uma classificação supervisionada.
# Construiremos o modelo manualmente: observaremos o gráfico do treinamento e escolheremos cortes que separem as espécies. Esses cortes formarão regras if/else, semelhantes a uma pequena árvore de decisão. O R aplicará as regras escolhidas;
# neste código, ele não procura os melhores cortes automaticamente.

library(ggplot2)
library(dplyr)

pinguins <- read.csv(file = "penguins.csv",
                     header = TRUE,
                     sep = ',')

# Nesta base, sexo não informado aparece como texto vazio ("").
# O filtro mantém as linhas com sexo preenchido; a vírgula mantém todas as colunas.
pinguins <- pinguins[pinguins$sex != "",]

# A alternativa abaixo faz o mesmo filtro com dplyr; não é necessário executar as duas.
# outro jeito:

pinguins <- pinguins |>
  filter(sex != "")



# Converte as colunas categóricas em fatores com mutate.
pinguins <- pinguins |>
  mutate(species = as.factor(species),
         island = as.factor(island),
         sex = as.factor(sex))

# outro jeito, transformando especie em fator seria:
# pinguins$species <- as.factor(pinguins$species)

# Conta os pinguins disponíveis após o filtro.
nrow(pinguins)
# Exibe uma permutação aleatória dos índices das linhas, sem reposição.
# Esta chamada é ilustrativa; a próxima gera outro embaralhamento.
sample(nrow(pinguins))

# Reordena as linhas aleatoriamente, mantendo juntas as informações de cada indivíduo.
# Sem set.seed(), a divisão e a acurácia podem mudar a cada execução.
pinguins_embaralhado <- pinguins[sample(nrow(pinguins)),]

# POR QUE DIVIDIR EM TREINAMENTO E TESTE?
# O treinamento serve para construir as regras; o teste, para avaliar como elas classificam pinguins que não participaram dessa construção.
# Avaliar nos mesmos dados usados para escolher os cortes pode dar uma impressão otimista do desempenho: as regras podem se ajustar a particularidades desses dados. Além do mais queremos saber o poder de classificação do modelo em dados que ele não conhece; se contruirmos o modelo nos dados todos e avaliarmos o modelo em seguida nos dados todos, evidentemente o modelo acertará muito porque ele já conhecia os dados durante a criação do modelo; lembre-se, queremos um modelo que seja capaz de acertar aquilo que ele não conhece.
# Por isso, reservamos cerca de 80% para treinamento e 20% para teste.
# Essa proporção é uma escolha da atividade, não uma regra obrigatória.
n <- round(nrow(pinguins_embaralhado)*0.8)

# As primeiras n linhas formam o treinamento; as demais ficam para o teste.
# O teste avalia as regras em observações que não foram usadas para escolher os cortes.
treinamento <- pinguins_embaralhado[1:n,]
teste <- pinguins_embaralhado[(n+1):nrow(pinguins_embaralhado),]

# Usa apenas o treinamento para examinar a separação das espécies.
# Os cortes do classificador devem ser escolhidos aqui, sem consultar o teste.
ggplot(data = treinamento, mapping = aes(x = bill_length_mm,
                                         y = bill_depth_mm,
                                         colour = species))+
  geom_point(size = 3) +
  theme_minimal()

# APLICAÇÃO DO MODELO
# Os cortes 16,25 e 45 mm abaixo representam as regras escolhidas na aula.
# O laço apenas aplica esse modelo ao teste; ele não aprende nem ajusta os cortes.
# A espécie observada no teste só será usada depois, para conferir as previsões.
# Cria o vetor que receberá a espécie prevista para cada pinguim do teste.
classificacao <- c()
# Percorre as linhas do teste e aplica os cortes fixados a partir do treinamento.
# Primeiro: se profundidade do bico até 16,25 mm então Gentoo.
# Nos demais: caso contrário, se comprimento até 45 mm então Adelie; caso contrário, então Chinstrap.

for (j in 1:nrow(teste)) {
  if(teste$bill_depth_mm[j] <= 16.25){
    classificacao[j] <- "Gentoo"
  }else{
    if(teste$bill_length_mm[j] <= 45){
      classificacao[j] <- "Adelie"
    }else{
      classificacao[j] <- "Chinstrap"
    }
  }
}
# Mostra as espécies previstas, na mesma ordem das linhas do teste.
classificacao
# Compara previsão e espécie observada: TRUE indica acerto; FALSE, erro.
classificacao == teste$species
# A média dos acertos (TRUE = 1) é a acurácia, uma proporção entre 0 e 1.
# Use o resultado para avaliar a regra, sem reajustar os cortes ao conjunto de teste.
mean(classificacao == teste$species)


