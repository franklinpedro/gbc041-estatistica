library(dplyr) # pacote para manipulacao de dados
library(ggplot2) # pacote para criacao de graficos

titanic <- read.csv(file = "titanic.csv", header = TRUE)
pinguins <- read.csv(file = "penguins.csv", header = TRUE)
str(titanic)

# imprimindo os nomes das variaveis do titanic

names(titanic)

titanic$Survived <- as.factor(titanic$Survived)

ggplot(data = titanic, mapping = aes(x = Survived, fill = Sex)) +
  geom_bar() +
  theme_minimal()


titanic <- titanic |>
  mutate(Pclass = as.factor(Pclass))

ggplot(data = titanic, mapping = aes(x = Pclass, fill = Survived)) +
  geom_bar() +
  facet_wrap(~Sex) +
  scale_fill_manual(values  = c("firebrick", "steelblue")) +
  theme_minimal()

#scale_fill_manual

ggplot(data = titanic, mapping = aes(Age)) +
  geom_histogram(fill = "white", col = "black") +
  facet_wrap(~Sex) +
  labs(title = "coloque aqui o titulo",
       x = "idade") +
  theme_minimal()

ggplot(data = pinguins, mapping = aes(x = body_mass_g, y = flipper_length_mm, col = species)) +
  geom_point()
