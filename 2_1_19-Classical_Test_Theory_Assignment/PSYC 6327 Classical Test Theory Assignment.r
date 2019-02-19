DATA <- read_sav("2_1_19-Classical_Test_Theory_Assignment/PSYC 6327 Classical Test Theory Assignment Data.sav")

library(psych)

#Splitting dataset by test time. Two test times.
DATA1 <- DATA[1:10]
DATA2 <- DATA[11:20]



splitHalf(DATA1, TRUE)

splitHalf(DATA2)

# Correlation table for test 1 vs test 2

DATA1SUM <- rowSums(DATA1, na.rm = TRUE)
item_discr1 <- cor(DATA1, DATA1SUM, use = "pairwise.complete.obs")
item_discr1

DATA2SUM <- rowSums(DATA2, na.rm = TRUE)
item_discr2 <- cor(DATA2, DATA2SUM, use = "pairwise.complete.obs")
item_discr2


#Correlation between 2 correlation tables

cor(item_discr1, item_discr2)

library(devtools)

library(hemp)
