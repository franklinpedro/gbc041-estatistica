library(ggplot2)
library(dplyr)
library(sf)
library(geobr)

# Importando a base de dados
sinasc <- read.csv("sinasc_mg_2024.csv")

# Removendo observações que possuem algum valor ausente (NA)
sinasc <- na.omit(sinasc)

# Verificando a estrutura da base
str(sinasc)

# Transformando variáveis qualitativas que foram
# importadas com tipos inadequados
sinasc <- sinasc |>
  mutate(
    PARTO = as.factor(PARTO),
    GRAVIDEZ = as.factor(GRAVIDEZ),
    DIA_SEMANA = factor(
      DIA_SEMANA,
      levels = c("segunda", "terça", "quarta", "quinta",
                 "sexta", "sábado", "domingo")
    ),
    SEXO = as.factor(SEXO)
  )

# Verificando novamente a estrutura da base
str(sinasc)

# Medidas-resumo para o peso ao nascer
summary(sinasc$PESO)

# Gráfico de barras para o sexo
ggplot(data = sinasc, mapping = aes(x = SEXO)) +
  geom_bar() +
  theme_minimal()

# Gráfico de barras para o tipo de parto
ggplot(data = sinasc, mapping = aes(x = PARTO)) +
  geom_bar() +
  theme_minimal()

# Gráfico de barras para o dia da semana
ggplot(data = sinasc, mapping = aes(x = DIA_SEMANA)) +
  geom_bar() +
  theme_minimal()

# Nascimentos por dia da semana, separados pelo tipo de parto
ggplot(data = sinasc, mapping = aes(x = DIA_SEMANA)) +
  geom_bar() +
  facet_wrap(~PARTO) +
  theme_minimal()

# Histograma da idade da mãe
# center = 0 estabelece zero como centro de uma classe.
# binwidth = 1 define classes com amplitude de 1 ano.
# Assim, as classes ficam centradas nas idades inteiras.
ggplot(data = sinasc, mapping = aes(x = IDADEMAE)) +
  geom_histogram(
    fill = "white",
    colour = "black",
    binwidth = 1,
    center = 0
  ) +
  theme_minimal()

# Histograma do peso ao nascer
# boundary = 0 estabelece zero como uma fronteira de classe.
# binwidth = 100 define classes com amplitude de 100 gramas.
# Assim, os limites das classes são 0, 100, 200, 300, ...
ggplot(data = sinasc, mapping = aes(x = PESO)) +
  geom_histogram(
    fill = "white",
    colour = "black",
    binwidth = 100,
    boundary = 0
  ) +
  theme_minimal()

# histograma do peso ao nascer de partos com mais de 36 semanas
# representação dos desvios em relação à média

media <- mean(sinasc_normal$PESO)
desvio <- sd(sinasc_normal$PESO)
sinasc_normal <- sinasc |> filter(SEMAGESTAC >= 36)
ggplot(sinasc_normal, aes(x = PESO)) +
  geom_histogram(binwidth = 100, boundary = 0, colour = "black", fill = "white") +
  geom_vline(xintercept = media, colour = "red", linewidth = 1.2) +
  geom_vline(xintercept = media - 2*desvio, linetype = "dashed", colour = "red",  linewidth = 1.2) +
  geom_vline(xintercept = media + 2*desvio, linetype = "dashed", colour = "red",  linewidth = 1.2) +
  theme_minimal()
