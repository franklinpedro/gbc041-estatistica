library(ggplot2)
library(dplyr)

pinguins <- read.csv(file = "penguins.csv",
                     header = TRUE,
                     sep = ',')

pinguins <- pinguins[pinguins$sex != "",]

# outro jeito:

pinguins <- pinguins |>
  filter(sex != "")


str(pinguins)

pinguins$species <- as.factor(pinguins$species)

pinguins <- pinguins |>
  mutate(species = as.factor(species),
         island = as.factor(island),
         sex = as.factor(sex))

str(pinguins) 

sum(pinguins$sex == "")

ggplot(data = pinguins, mapping = aes(x = species)) +
  geom_bar()

ggplot(data = pinguins, mapping = aes(x = species, fill = sex)) +
  geom_bar()

ggplot(data = pinguins, mapping = aes(x = sex))+
  geom_bar() +
  facet_wrap(~species) +
  theme_minimal()

ggplot(data = pinguins, mapping = aes(x  = island, fill = species)) +
  geom_bar() +
  theme_minimal()

ggplot(data = pinguins, mapping = aes(x = body_mass_g)) +
  geom_histogram() +
  theme_minimal()

ggplot(data = pinguins, mapping = aes(x = body_mass_g)) +
  geom_histogram(col = "black", fill = "white") +
  theme_minimal()

ggplot(data = pinguins, mapping = aes(x = body_mass_g)) +
  geom_histogram(col = "black", fill = "white") +
  facet_wrap(~species)
  theme_minimal()
  
ggplot(data = pinguins, mapping = aes(y = body_mass_g, x = species))+
  geom_boxplot() +
  theme_minimal()


# 1 1 2 4 5 5 5 6 8 32

ggplot(data = pinguins, mapping = aes(y = flipper_length_mm, x = species))+
  geom_boxplot() +
  theme_minimal()

ggplot(data = pinguins, mapping = aes(y = flipper_length_mm, colour = species, x = body_mass_g))+
  geom_point() +
  theme_minimal()

