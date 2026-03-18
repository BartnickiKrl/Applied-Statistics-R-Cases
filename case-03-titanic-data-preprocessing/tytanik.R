install.packages("tidyverse")
library(tidyverse)

titanic = read.csv('titanic_new.csv', header=TRUE, sep=',')
view(titanic)

# USUWANIE NIEPOTRZEBNYCH KOLUMN =============================================
titanic = titanic %>% select(-Passenger.Id, -Ticket, -Name)
view(titanic)

# USUWANIE DULIKATÓW =============================================
install.packages("dplyr")
library(dplyr)

nrow(titanic)
nrow(unique(titanic))
titanic = distinct(titanic)
view(titanic)

# BŁĘDNE TYPY ===================================================
install.packages("stringr")
library(stringr)

sapply( titanic, typeof )
titanic$Embarked[titanic$Embarked == ""] = as.numeric(titanic$Embarked)
titanic$Fare = str_replace_all(titanic$Fare, "'", "")
titanic$Fare = as.numeric(titanic$Fare)

# ODSZUMIANIE ==================================================
unique(titanic$Survived)
titanic$Survived[titanic$Survived %in% c(-1, 111, 112)] = 1
unique(titanic$Pclass)
unique(titanic$Sex)
titanic$Sex[titanic$Sex %in% c("mal3e", "mal4e", "malle", "malwe")] = "male"
titanic$Sex[titanic$Sex %in% c("feemale", "f2emale")] = "female"
unique(titanic$Embarked)
titanic$Embarked[titanic$Embarked %in% "s"] = "S"

titanic$Age[titanic$Age < 0] = NA
titanic$Age[titanic$Age > 120] = NA
titanic$SibSp[titanic$SibSp < 0] = NA
titanic$Parch[titanic$Parch < 0] = NA

titanic = titanic %>% select(-Cabin)

install.packages("Hmisc")
library(Hmisc)

titanic$Age = impute(titanic$Age, median)
moda_embarked = names(sort(table(titanic$Embarked), decreasing = TRUE))[1]
titanic$Embarked[is.na(titanic$Embarked)] = moda_embarked

#ANALIZA DANYCH =============================================
table(titanic$Survived)

titanic_cpy = titanic %>% select(Survived)
titanic_cpy = titanic_cpy[titanic_cpy$Survived == 0, ]
deth_procentile = length(titanic_cpy)/nrow(titanic)
deth_procentile * 100

# ŚMIERTELNOŚĆ W ZALEŻNOŚCI OD PŁCI =========================
titanic_cpy = titanic %>% select(Survived, Sex)
titanic_cpy = titanic_cpy[titanic_cpy$Survived == 0, ]
death_sex = table(titanic_cpy$Sex)/table(titanic$Sex)
death_sex = death_sex * 100
# Wykres słupkowy
barplot(death_sex,
        names.arg = c("kobiety", "mężczyźni"),
        col = "green",
        main = "Śmiertelność pasażerów Titanica wg płci",
        xlab = "Śmiertelność (%)",
        xlim = c(0, 100), horiz = TRUE )

table(titanic$Sex)

# ŚMIERTELNOŚĆ W ZALEŻNOŚCI OD GRUPY WIEKOWEJ ===============
death_children = nrow(titanic[titanic$Age < 18 & titanic$Survived == 0,  ])/nrow(titanic[titanic$Age < 18,  ])
death_children = death_children * 100
death_young_adult = nrow(titanic[titanic$Age >= 18 & titanic$Age < 30 & titanic$Survived == 0,  ]) / nrow(titanic[titanic$Age >= 18 & titanic$Age < 30,  ])
death_young_adult = death_young_adult * 100
death_adult = nrow(titanic[titanic$Age >= 30 & titanic$Age < 50 & titanic$Survived == 0,  ]) / nrow(titanic[titanic$Age >= 30 & titanic$Age < 50,  ])
death_adult = death_adult * 100
death_olders = nrow(titanic[titanic$Age >= 50 & titanic$Age < 120 & titanic$Survived == 0,  ]) / nrow(titanic[titanic$Age >= 50 & titanic$Age < 120,  ])
death_olders = death_olders * 100

# Dane i etykiety
death_rates <- c(death_children, death_young_adult, death_adult, death_olders)
age_groups <- c("Dzieci (<18)", "Młodzi dorośli (18-29)", "Dorośli (30-49)", "Starsze osoby (50+)")

# Wykres słupkowy
barplot(death_rates,
        names.arg = age_groups,
        col = "magenta",
        main = "Śmiertelność pasażerów Titanica wg grup wiekowych",
        ylab = "Śmiertelność (%)",
        ylim = c(0, 100) )


# ŚMIERTELNOŚĆ W ZALEŻNOŚCI OD KLASY BILETU ===================
titanic_cpy = titanic %>% select(Survived, Pclass)
titanic_cpy = titanic_cpy[titanic_cpy$Survived == 0, ]
death_class = table(titanic_cpy$Pclass)/table(titanic$Pclass)
death_class = death_class * 100

# Wykres słupkowy
barplot(death_class,
        names.arg = c("1 klasa", "2 klasa", "3 klasa" ),
        col = "darkred",
        main = "Śmiertelność pasażerów Titanica wg klasy biletu",
        ylab = "Śmiertelność (%)",
        ylim = c(0, 100) )

table(titanic$Pclass)


# ANALIZA I STATYSTYKI KOLUMNY Z WIEKEM PASAŻERÓW ==============
summary(titanic$Age)

install.packages("e1071")
library(e1071)

var(titanic$Age)
IQR(titanic$Age)
sd(titanic$Age)
max(titanic$Age) - min(titanic$Age)

hist(titanic$Age)
boxplot(titanic$Age)

skewness(titanic$Age)
kurtosis(titanic$Age)
shapiro.test(titanic$Age) 

install.packages("corrplot")
library(corrplot)
titanic_cor = cor(titanic[, sapply(titanic, is.numeric)], use = "complete.obs")
corrplot(titanic_cor)

