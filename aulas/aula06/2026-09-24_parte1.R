# ggplot2 constrói os gráficos; dplyr ajuda a filtrar e transformar os dados.
library(ggplot2)
library(dplyr)

# Lê o CSV: a primeira linha contém os nomes das colunas, separadas por vírgulas.
# O arquivo penguins.csv deve estar no diretório de trabalho (consulte getwd()).
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


# Mostra a estrutura: nomes, tipos das colunas e exemplos de valores.
str(pinguins)

# Converte a espécie em fator, representação de uma variável categórica no R.
pinguins$species <- as.factor(pinguins$species)

# Converte as colunas categóricas em fatores com mutate.
pinguins <- pinguins |>
  mutate(species = as.factor(species),
         island = as.factor(island),
         sex = as.factor(sex))

# Confere os tipos das colunas depois das conversões.
str(pinguins) 

# Conta quantos registros ainda têm sexo vazio: TRUE vale 1 e FALSE vale 0.
sum(pinguins$sex == "")

# geom_bar conta as observações de cada espécie.
ggplot(data = pinguins, mapping = aes(x = species)) +
  geom_bar()

# Conta os pinguins por espécie, empilhando as categorias de sexo em cada barra.
ggplot(data = pinguins, mapping = aes(x = species, fill = sex)) +
  geom_bar()

# Conta os sexos separadamente para cada espécie; facet_wrap cria os painéis.
ggplot(data = pinguins, mapping = aes(x = sex))+
  geom_bar() +
  facet_wrap(~species) +
  theme_minimal()

# Compara as contagens por ilha, identificando as espécies pelas cores.
ggplot(data = pinguins, mapping = aes(x  = island, fill = species)) +
  geom_bar() +
  theme_minimal()

# O histograma agrupa a massa (g) em intervalos e conta as observações.
# Sem bins ou binwidth, geom_histogram usa 30 intervalos por padrão.
ggplot(data = pinguins, mapping = aes(x = body_mass_g)) +
  geom_histogram() +
  theme_minimal()

# O histograma agrupa a massa (g) em intervalos e conta as observações.
# Sem bins ou binwidth, geom_histogram usa 30 intervalos por padrão.
ggplot(data = pinguins, mapping = aes(x = body_mass_g)) +
  geom_histogram(col = "black", fill = "white") +
  theme_minimal()

# O histograma agrupa a massa (g) em intervalos e conta as observações.
# Sem bins ou binwidth, geom_histogram usa 30 intervalos por padrão.
ggplot(data = pinguins, mapping = aes(x = body_mass_g)) +
  geom_histogram(col = "black", fill = "white") +
  facet_wrap(~species) +
  theme_minimal()

# Compara mediana, quartis e dispersão da massa entre as espécies.
# Pontos além dos bigodes não são necessariamente erros nos dados.
ggplot(data = pinguins, mapping = aes(y = body_mass_g, x = species))+
  geom_boxplot() +
  theme_minimal()



# Compara a distribuição do comprimento da nadadeira (mm) entre as espécies.
ggplot(data = pinguins, mapping = aes(y = flipper_length_mm, x = species))+
  geom_boxplot() +
  theme_minimal()

# Cada ponto representa um pinguim: massa no eixo x e nadadeira no eixo y.
# A cor identifica a espécie; alpha controla a transparência dos pontos.
ggplot(data = pinguins, mapping = aes(y = flipper_length_mm, colour = species, x = body_mass_g))+
  geom_point(size = 4, alpha = 0.7) +
  labs(x = "massa (g)",
       y = "Comprimento da nadadeira (mm)",
       title = "Comparando as espécies a partir do comprimento da nadadeira e do peso") +
  theme_minimal()

# bico versus bico

# bico versus peso

# peso versus nadadeira

# Relaciona profundidade (x) e comprimento (y) do bico, ambos em milímetros.
ggplot(data = pinguins, mapping = aes(y = bill_length_mm, colour = species, x = bill_depth_mm))+
  geom_point(size = 3) +
  theme_minimal()

# Relaciona massa corporal (g) e comprimento do bico (mm).
ggplot(data = pinguins, mapping = aes(y = bill_length_mm, colour = species, x = body_mass_g))+
  geom_point(size = 3) +
  theme_minimal()

# Relaciona massa corporal (g) e profundidade do bico (mm).
ggplot(data = pinguins, mapping = aes(y = bill_depth_mm, colour = species, x = body_mass_g))+
  geom_point(size = 3) +
  theme_minimal()

# Cada ponto representa um pinguim: massa no eixo x e nadadeira no eixo y.
# A cor identifica a espécie; alpha controla a transparência dos pontos.
ggplot(data = pinguins, mapping = aes(y = flipper_length_mm, colour = species, x = body_mass_g))+
  geom_point(size = 3) +
  theme_minimal()
