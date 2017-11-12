### Wprowadzenie do R w kontekście Machine Learning
### Marta Sommer
### 14 listopada 2017 r.

################################################################################
### Krótkie wprowadzenie do programowania w R.

### Wektory:

# tworzenie wektorów:

c(1, 3, 4, 6, 7, 2)

1:10

10:1

seq(0, 100, by = 5)

# przypisywanie wektorów do zmiennej:

wektor <- c(3, 5, 2)

# operacje na wektorach:

wektor + 3

wektor * 2

wektor * wektor

# wybor elementu:

wektor[1]

wektor[c(1, 3)]

wektor[c(3, 1)]

### Podstawowe operacje na wektorach:

x <- 2:10

mean(x)   # średnia

sd(x)   # odchylenie standardowe

median(x)   # mediana

range(x)   # minimum i maksimum

min(x)   # minimium

### Ramki danych:

dane <- data.frame(imie = c("Marek", "Franek", "Ola"),
                   wiek = c(13, 16, 14),
                   plec = c("M", "M", "K"))   # tworzenie ramki danych:
dane

dane[2, ]   # wybieranie wiersza

dane[c(2, 3), ]

dane[c(2, 3), 3] # wybieranie wiersza i kolumny

dane[c(2, 3), c(1, 3)]

dane$wiek   # wybieranie kolumny przy pomocy nazwy kolumny

colnames(dane)   # nazwy kolumn

dane[2, 2] <- 25   # podmienianie wartosci

dane

### Wczytywanie danych:

read.table("./dane/imie_wiek_plec.txt")   # wczytywanie danych w dowolnym formacie

read.table("./dane/imie_wiek_plec.txt", header = TRUE)   # zeby zauwazyl naglowek w tabeli

menu <- read.csv("./dane/menu.csv") # wczytywanie danych w formacie .csv

menu <- read.csv("./dane/menu.csv", encoding = "UTF-8")   # poprawiamy kodowanie

### Korzystanie z pakietów:

install.packages("data.table")   # instalowanie pakietu (jednorazowo na komputerze):

library("data.table")   # ładowanie pakietu (przy każdym odpaleniu RStudio):

?fread   # pomoc

menu <- fread("./dane/menu.csv", encoding = "UTF-8")   # funkcja do wczytywania danych z pakietu 'data.table'

################################################################################
### Przetwarzanie danych za pomocą pakietu 'dplyr'.

library("dplyr")

menu <- read.csv("./dane/menu.csv", encoding = "UTF-8")

### SELECT - wybierz kolumny:

# wybieranie jednej kolumny
menu %>% 
    select(Category)   

# wybieranie wielu kolumn
menu %>% 
    select(Category,
           Calories)   

### ARRANGE - sortowanie:

# wybierz dwie kolumny, a następnie posortuj po jednej z nich
menu %>% 
    select(Item,
           Calories) %>% 
    arrange(Calories)

# posortuj malejąco:
menu %>% 
    select(Item,
           Calories) %>% 
    arrange(desc(Calories))

# posortuj podwóch kolumnach:
menu %>% 
    select(Item,
           Calories) %>% 
    arrange(desc(Calories),
            Item)

### FILTER - wybierz wiersze spełniające określone warunki:

# wybierz dania, które mają równo 100 kalorii:
menu %>% 
    filter(Calories == 100) %>% 
    select(Item,
           Category,
           Calories)

# wybierz dania, które mają mniej niż 100 kalorii:
menu %>% 
    filter(Calories < 100) %>% 
    select(Item,
           Category,
           Calories)

# wybierz dania, które mają mniej niż 100 kalorii i nie są napojem ('Beverages'):
menu %>% 
    filter(Calories < 100,
           Category != "Beverages") %>% 
    select(Item,
           Category,
           Calories)

# wybierz dania, które mają mniej niż 100 kalorii, nie są napojem ('Beverages') i posortuj po liczbie kalorii:
menu %>% 
    filter(Calories < 100,
           Category != "Beverages") %>% 
    select(Item,
           Category,
           Calories) %>% 
    arrange(Calories)

# znajdź produkt zawierający najwięcej żelaza:
menu %>% 
    filter(Iron.PDV == max(Iron.PDV))

### MUTATE - stwórz nową kolumnę:

# wybierzmy danie, jego zawartość tłuszczu i jaki to jest procent dziennej 'dawki' tłuszczu:
menu %>% 
    select(Item,
           Total.Fat, 
           Total.Fat.PDV)

# Dowiedzmy się, jaka jest dzienna zalecana 'dawka' tłuszczu:
menu %>% 
    select(Item,
           Total.Fat, 
           Total.Fat.PDV) %>% 
    mutate(dzienna_dawka_tluszczu = round(Total.Fat*100/Total.Fat.PDV))

# stwórzmy nową kolumnę, w której będziemy mieć zawartość tłuszczu, a w nawiasie jaka to jest procentowa dzienna dawka:
menu %>% 
    select(Item,
           Total.Fat, 
           Total.Fat.PDV) %>% 
    mutate(Fat = paste0(Total.Fat, " (", Total.Fat.PDV, "%)"))

### SUMMARISE - podsumuj (stwórz nową tabelę)

# policzmy średnią liczbę kalorii
menu %>% 
    summarise(sr_kalorie = mean(Calories))

# policzmy średnią liczbę kalorii i średnią ilość tłuszczu:
menu %>% 
    summarise(sr_kalorie = mean(Calories),
              sr_tluszcz = mean(Total.Fat))

# policzmy ile jest dań:
menu %>% 
    summarise(n())

### GROUP_BY - licz coś w grupach

# policzmy średnią liczbę kalorii w podziale na rodzaj posiłku:
menu %>% 
    group_by(Category) %>% 
    summarise(sr_kalorie = mean(Calories)) %>% 
    arrange(sr_kalorie)

# policzmy ile jest dań w podziale na kategorie:
menu %>% 
    group_by(Category) %>% 
    summarise(n())

# znajdź produkt zawierający najwięcej żelaza w danej kategorii:
menu %>% 
    group_by(Category) %>% 
    filter(Iron.PDV == max(Iron.PDV)) %>% 
    select(Category, Item, Iron.PDV)

### ZADANIA:

# 1. Wybierz kolumny: produkt (*Item*) oraz zawartość tłuszczu (*Total.Fat*). Posortuj tabelę malejąco po zawartości tłuszczu.
# 
# 2. Wybierz produkty (*Item*), które zawierają minimalnie 20, a maksymalnie 100 kalorii. 
# 
# 3. Znajdź produkt (*Item*), który zawiera najmniej cholesterolu (*Cholesterol*).
# 
# 4. Policz średnią zawartość cukru (*Sugar*) we wszystkich produktach.
# 
# 5. Dla każdego produktu (*Item*) policz jakim procentem jego wartości energetycznej (*Calories*) jest wartość energetyczna zawarta w tłuszczu (*Calories.from.Fat*). Wynik zaokrąglij do całości. 
# 
# 6. Znajdź produkt/-y (*Item*), które zawierają minimalną wartość sodu (*Sodium*). 
# 
# 7. Znajdź produkty (*Item*) z kategorii (*Category*) *Breakfast*, które zawierają najwięcej sodu.
# 
# 8. Dla każdej kategorii produktu (*Category*) znajdź średnią zawartość tłuszczu (*Total.Fat*).
# 
# 9. Dla każdej kategorii produktu (*Category*) znajdź minimalną zawartość cukru.
# 
# 10. Policz średnią zawartość cukru dla produktów (*Item*) będących McMuffinami (takimi, które w nazwie (*Item*) zawierają wyrażenie 'McMuffin').

################################################################################
### Krótka analiza danych za pomocą regresji liniowej

# zbior danych trees - rozmiary dotyczace drzew:
# Girth - obwod drzewa na poziomie piersi [cale]
# Height - wysokosc
# Volume - objetosc

data(trees)
head(trees)

# Pytanie: od czego zalezy objętość drzew?

# zróbmy najpierw proste wykresy zależności od obu zmiennych:

plot(trees$Girth, trees$Volume)
plot(trees$Height, trees$Volume)    # widac, ze zaleznosc jest silniejsza w przypadku Girth

pairs(Volume ~ Girth + Height, data = trees)

# sprawdźmy korelację:

cor(trees$Girth, trees$Volume)
cor(trees$Height, trees$Volume)

# dopasujmy model liniowy dla kazdej z tych zmiennych oddzielnie:

lg <- lm(Volume ~ Girth, data = trees)
lh <- lm(Volume ~ Height, data = trees)

summary(lg)
summary(lh) # widac, ze R^2 dla modelu lg było lepsze

# narysujmy dopasowane krzywe:

plot(trees$Girth, trees$Volume)
abline(lg, col = "red")

plot(trees$Height, trees$Volume)
abline(lh, col = "blue")

# porownajmy R^2 dla tych modeli

summary(lg)$r.squared    # [1] 0.9353199
summary(lh)$r.squared    # [1] 0.3579026

# wykresy rozproszenia rezyduow wzgledem wartosci dopasowanych

plot(lg, 1)
plot(lh, 1) 

# wykres kwantylowy - punkty powinny sie tu ukladac na prostej

plot(lg, 2)
plot(lh, 2)

# poprawmy model:

lg2 <- lm(Volume ~ I(Girth^2), data = trees)
summary(lg2)

plot(lg2, 1)
plot(lg2, 2)

# zobaczmy model od dwóch zmiennych:

lgh <- lm(Volume ~ I(Girth^2) + Height, data = trees)
summary(lgh)

plot(lgh, 1)
plot(lgh, 2)

