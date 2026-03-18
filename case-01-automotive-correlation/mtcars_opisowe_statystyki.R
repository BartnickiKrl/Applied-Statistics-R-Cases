#STATYSTYKI OPISOWE DLA DWOCH CECH - (hp, drat)
data("mtcars")
hist(mtcars$hp)
hist(mtcars$drat)

#import biblioteki e1071 potrzebnej do kurtozy
install.packages('e1071')
library(e1071)

kurtosis(mtcars$hp)
kurtosis(mtcars$drat)

#obrazowanie kurtozy za pomącą wykresu pudełkowego
boxplot(mtcars$hp)
boxplot(mtcars$drat)

#wartosci skrajne hp
min(mtcars$hp)
max(mtcars$hp)

#wartosci skrajne drat
min(mtcars$drat)
max(mtcars$drat)

skewness(mtcars$hp) 
skewness(mtcars$drat) 


#ZMIENNOSC =============================================================
mean(mtcars$hp)
var(mtcars$hp)
sd(mtcars$hp)

median(mtcars$hp)
max(mtcars$hp) - min(mtcars$hp)
IQR(mtcars$hp)

mean(mtcars$drat)
var(mtcars$drat)
sd(mtcars$drat)

median(mtcars$drat)
max(mtcars$drat) - min(mtcars$drat)
IQR(mtcars$drat)


#ANALIZA KORELACJI ======================================================
#Badamy za pomocą testu Saphiro-Wilka 
#czy hp i drat mają rozkład normalny
shapiro.test(mtcars$hp)
shapiro.test(mtcars$drat)

#sprawdzamy korelacje testem spearmana
cor.test(mtcars$hp, mtcars$drat, method = 'spearman', use='complete.obs')


#WIZUALIZACJA ============================================================
install.packages("corrplot")
library(corrplot)
mtcars_hp_drat = data.frame(mtcars$hp, mtcars$drat)
colnames(mtcars_hp_drat) = c("hp", "drat")
corrplot(cor(mtcars_hp_drat))

hp_drat_matrix = as.matrix(mtcars_hp_drat)
colnames(hp_drat_matrix) = c("hp", "drat")
heatmap(hp_drat_matrix, scale="column")
