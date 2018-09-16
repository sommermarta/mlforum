### ML Forum - Wprowadzenie do R w kontekście Machine Learning
### Marta Sommer (mmartasommer@gmail.com)
### 18 września 2018 r.

################################################################################
### 3. MODELOWANIE:
################################################################################

################################################################################
### PAKIETY:
################################################################################

library("dplyr")
library("mlr")

################################################################################
### REGRESJA LINIOWA (PAKIET 'STATS'):
################################################################################

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

cor(trees$Girth, trees$Volume) # 0.9671194

cor(trees$Height, trees$Volume) # 0.5982497

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

################################################################################
### REGRESJA LINIOWA (PAKIET 'MLR'):
################################################################################

# tworzymy model:

task <- makeRegrTask(data = trees,
                     target = "Volume")

# ustalamy, jakie algorytmy chcemy zastosowac:

learners <- list(makeLearner("regr.lm"), 
                 makeLearner("regr.glm"),
                 makeLearner("regr.rpart"),
                 makeLearner("regr.featureless")) 

# View(listLearners())

# obserwujemy, ktory jest najlepszy:

bm <- benchmark(learners, 
                task, 
                resamplings = cv5, 
                measures = list(mlr::timetrain, mlr::rsq, mlr::arsq, mlr::mse))

bm

################################################################################
### KLASYFIKACJA:
################################################################################

dane <- read.csv("./data/titanic.csv")

# czyscimy dane:

dane <- dane %>% 
    select(-Name)

# tworzymy model:

task <- makeClassifTask(data = dane,
                        target = "Survived")

# ustalamy, jakie algorytmy chcemy zastosowac:

learners <- list(makeLearner("classif.randomForest", predict.type = "prob"), 
                 makeLearner("classif.rpart", predict.type = "prob"), 
                 makeLearner("classif.logreg", predict.type = "prob"),
                 makeLearner("classif.lda", predict.type = "prob"),
                 makeLearner("classif.featureless", predict.type = "prob")) 

# View(listLearners())

# obserwujemy, ktory jest najlepszy:

bm <- benchmark(learners, 
                task, 
                resamplings = cv5, 
                measures = list(mlr::timetrain, mlr::auc))

bm

plotBMRBoxplots(bm, 
                measure = auc)
plotBMRBoxplots(bm, 
                measure = timetrain)

################################################################################
