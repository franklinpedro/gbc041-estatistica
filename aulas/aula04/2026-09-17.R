titanic <- read.csv(file = "titanic.csv", header = TRUE, sep = ",")

str(titanic)
summary(titanic)

titanic[3,4]
titanic[3,c(4,5)]

titanic[3,]
titanic[,4]

nome <- titanic$Name

idade <- titanic$Age
idade

titanic$Sex == "female"

titanic_f <- titanic[titanic$Sex == "female",]

titanic$eh_mulher <- titanic$Sex == "female"

sum(titanic$Sex == "female")

primeira_classe <- titanic[titanic$Pclass == 1,]

primeira_classe$Survived == 1
sum(primeira_classe$Survived == 1)/216

segunda_classe <- titanic[titanic$Pclass == 2,]

sum(segunda_classe$Survived == 1)/184
mean(segunda_classe$Survived == 1)

terceira_classe <- titanic[titanic$Pclass == 3,]

mean(terceira_classe$Survived == 1)

table(primeira_classe$Survived)

prop.table(table(primeira_classe$Survived))

table(terceira_classe$Survived, terceira_classe$Sex)
table(titanic$Survived, titanic$Pclass)

prop.table(table(titanic$Survived, titanic$Pclass), margin = 2)

homens <- titanic[titanic$Sex == "male",]

prop.table(table(homens$Survived, homens$Pclass), margin = 2)
prop.table(table(homens$Survived, homens$Pclass), margin = 1)

class(titanic$Survived)

titanic$Survived <- as.factor(titanic$Survived)
summary(titanic)

titanic$Pclass <- as.factor(titanic$Pclass)
summary(titanic)

pinguins <- read.csv(file = "penguins.csv", header = TRUE)

str(pinguins)

library(ggplot2)

ggplot(data = pinguins, aes(x = bill_length_mm, y= bill_depth_mm, col = species)) +
  geom_point() +
  theme_minimal()
