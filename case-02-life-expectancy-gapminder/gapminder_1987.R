#STATYSTYKI OPISOWE DLA DANYCH Z PAKIETU ''danych z pakietu gapminder dla roku 1987

install.packages("gapminder")
library(gapminder)
data('gapminder')

#filtrujemy do roku 1987
gapminder_1987 = gapminder[gapminder$year == 1987, ]

hist(gapminder_1987$pop)
hist(gapminder_1987$lifeExp)
pairs(~pop+lifeExp, data=gapminder_1987)
plot(gapminder_1987$pop, gapminder_1987$lifeExp, log="x", xlab="population", ylab="life_expectancy")

#Badamy za pomocą testu Shapiro-Wilka czy hp jest układem normalnym
shapiro.test(gapminder_1987$pop)
shapiro.test(gapminder_1987$lifeExp)

#sprawdzamy korelacje testem Spearmana 
cor.test(gapminder_1987$pop, gapminder_1987$lifeExp, method = 'spearman', use='complete.obs')

#wizualizacja
install.packages("corrplot")
library(corrplot)
gapminder_pop_lifeExp = data.frame(log10(gapminder_1987$pop), gapminder_1987$lifeExp)
colnames(gapminder_pop_lifeExp) = c("pop", "lifeExp")
corrplot(cor(gapminder_pop_lifeExp), method = "circle")
heatmap(as.matrix(gapminder_pop_lifeExp), scale="column")
