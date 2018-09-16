### ML Forum - Wprowadzenie do R w kontekście Machine Learning
### Marta Sommer (mmartasommer@gmail.com)
### 18 września 2018 r.

################################################################################
### 1. WPROWADZENIE DO R:
################################################################################

################################################################################
### WEKTORY:
################################################################################

# tworzenie wektorów:

c(1, 3, 4, 6, 7, 2)

c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

1:10

10:1

1:100

seq(0, 100, by = 5)

# przypisywanie wektorów do zmiennej:

c(3, 5, 2)

wektor <- c(3, 5, 2)

wektor

y <- wektor

# operacje na wektorach:

wektor

wektor + 3

wektor * 2

2 * wektor

x <- 2 * wektor
X <- 2 * wektor

wektor * wektor

c(3, 4, 5) + c(1, 2, 3)
c(3, 4, 5) + c(3)
c(3, 4, 5) + 3
c(3, 4, 5) + c(1, 2)
c(1, 2, 1)

wektor * wektor

# wybor elementu:

wektor[1]

wektor[3]

wektor[c(1, 3)]
wektor[1:3]

1:3

wektor[c(3, 1)]

wektor <- 5:20

wektor[2:length(wektor)]

################################################################################
### PODSTAWOWE OPERACJE NA WEKTORACH:
################################################################################

x <- 4

x <- 2:10

mean(x)   # średnia

sd(x)   # odchylenie standardowe

median(x)   # mediana

range(x)   # minimum i maksimum

min(x)   # minimium

max(x)

?mean

################################################################################
### RAMKI DANYCH:
################################################################################

dane <- data.frame(imie = c("Marek", "Franek", "Ola"),
                   wiek = c(13, 16, 14),
                   plec = c("M", "M", "K"))   # tworzenie ramki danych:
dane

dane[3, 2]

dane[c(2, 3), 2]

dane[2, 1:3]

dane[2, ]   # wybieranie wiersza

dane[c(2, 3), ]

dane[c(2, 3), 3] # wybieranie wiersza i kolumny

dane[c(2, 3), c(1, 3)]

dane$wiek   # wybieranie kolumny przy pomocy nazwy kolumny

dane$plec[3]

colnames(dane)   # nazwy kolumn

dane[2, 2] <- 25   # podmienianie wartosci

dane

################################################################################
### WCZYTYWANIE DANYCH:
################################################################################

dane <- read.csv("./data/titanic.csv")  

################################################################################
