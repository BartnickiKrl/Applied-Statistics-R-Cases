#WCZYTANIE DANYCH ===================================
install.packages('openxlsx')
library(openxlsx)
sklep77 = read.xlsx("C:\\Users\\karol\\Desktop\\AGH\\Semestr 2\\Programowanie R\\Projekt R #5 sklepy, TRIO\\sklep77.xlsx")
View(sklep77)

#PREPROCESSING =============================
install.packages('tidyverse')
library(tidyverse)
#wyrzucamy nieopotrzebne kolumny
unique(sklep77$sklep_id)
unique(sklep77$sklep_typ)
unique(sklep77$sklep_asort)
unique(sklep77$sklep_konkurencja)
#wszystkie kolumny mają tylko jedną wartość 
sklep77 = select(sklep77, -sklep_id, -sklep_typ, -sklep_asort, -sklep_konkurencja)
#usuwamy wynik dla braku klientów
unique(sklep77$czy_otwarty)
sklep77 = sklep77[sklep77$czy_otwarty == "Tak", ]
#zamieniamy date na typ Date
sklep77$data = as.Date(sklep77$data, origin = "1899-12-30")
View(sklep77)

#UŻYCIE LM() ======================================
install.packages("ggplot2")
library(ggplot2)

model = lm(sprzedaz ~ liczba_klientow, data = sklep77)

print(summary(model))
print(model$fitted.values)
print(model$rank)
print(model$df.residual)
print(model$terms)
print(model$model)


summary_models = summary(model)$coefficients
View(summary_models)
slope = summary_models["liczba_klientow", "Estimate"]
intercept = summary_models["(Intercept)", "Estimate"]
p_value = summary_models["liczba_klientow", "Pr(>|t|)"]

label_text = paste0("y = ", round(slope, 2), "x ", round(intercept, 2), "\n", 
                    "p_value = ", signif(p_value, 3) )

#liniowy wykres
ggplot(sklep77, aes(x = liczba_klientow, y = sprzedaz)) +
  geom_point() +
  geom_smooth(method = "lm") +
  annotate("text", x = 800, y = Inf, label = label_text, 
           hjust = 1.1, vjust = 1.5, size = 7, fontface = "italic")

#RELACJE ============================================================

#liniowy wykres z wyróżnieniem promocji
ggplot(sklep77, aes(x = liczba_klientow, y = sprzedaz)) +
  geom_point(aes(color = czy_promocja)) +
  geom_smooth(method = "lm", color="black")

#liniowy wykres z wyróżnieniem świąt szkolnych
ggplot(sklep77, aes(x = liczba_klientow, y = sprzedaz)) +
  geom_point(aes(color = czy_swieto_szkolne)) +
  geom_smooth(method = "lm", color="black")

#KORELACJA DNI TYGODNIA ==============================================
install.packages("corrplot")
library(corrplot)

dane1 = data.frame("dzien_tygodnia"=sklep77$dzien_tyg, "klienci"=sklep77$liczba_klientow, "sprzedaz"=sklep77$sprzedaz)
corrplot(cor(dane1))

plot(dane1$dzien_tygodnia, dane1$klienci, xlab="dzien_tygodnia", ylab="klienci")
plot(dane1$dzien_tygodnia, dane1$sprzedaz, xlab="dzien_tygodnia", ylab="sprzedaz")

#SKŁADNIK RESZTOWY (RESIDUALS) ==========================================
residuals_models = summary(model)$residuals
sklep77$residuals = residuals_models
sklep77_sorted = arrange(sklep77, residuals)
tail_sklep = tail(sklep77_sorted)
head_sklep = head(sklep77_sorted)

ggplot(sklep77, aes(x = liczba_klientow, y = sprzedaz)) +
  geom_point() +
  geom_smooth(method = "lm") +
  geom_point(data = tail_sklep, aes(x = liczba_klientow, y = sprzedaz), 
             color = "darkgreen", size = 3) +
  geom_point(data = head_sklep, aes(x = liczba_klientow, y = sprzedaz), 
             color = "red", size = 3)

#PRZEWIDYWANIE SPRZEDAZY DLA DANEJ LICZBY KLIENTOW ============================
new_data = data.frame(liczba_klientow = c(599, 616))
przewidywana_sprzedaz = predict(model, new_data)
print(przewidywana_sprzedaz)


punkty = data.frame(liczba_klientow = c(599, 616), sprzedaz=przewidywana_sprzedaz)

ggplot(sklep77, aes(x = liczba_klientow, y = sprzedaz)) +
  geom_point() +
  geom_smooth(method = "lm") +
  geom_point(data = punkty, aes(x = liczba_klientow, y = sprzedaz), 
             color = "red", size = 3) +
  geom_segment(data = punkty,
               aes(x = liczba_klientow, xend = liczba_klientow, 
                   y = 3000, yend = sprzedaz),
               linetype = "dashed", color = "red") +
  geom_segment(data = punkty,
               aes(x = 400, xend = liczba_klientow, 
                   y = sprzedaz, yend = sprzedaz),
               linetype = "dashed", color = "red")






