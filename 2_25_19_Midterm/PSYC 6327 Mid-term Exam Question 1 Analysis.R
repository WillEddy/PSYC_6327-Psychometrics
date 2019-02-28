library(haven)
library(psych)
library(GPArotation)

library(readxl)
DATA <- read_excel("2_25_19_Midterm/PSYC 6327 Mid-term Exam Question 2 Data(1).xlsx", col_types="numeric")
View(DATA)

SCREE <- scree(DATA, pc=FALSE)
SCREE

PA <- fa.parallel(DATA, fa="fa")
PA


# Hypothesized number of factors based on scree plot is 3.
# VSS function documentation suggests applying "more than hypothesized," so using 4.
# Default rotation - varimax

VSS(DATA, n=4)

VSS(DATA, n=15, rotate="oblimin")

# Creating correlation table for fa() function, and requesting matrices.

COR_DATA <- cor(DATA)

FA_DATA4 <- fa(COR_DATA, nfactors=5, rotate="oblimin")
fa.sort(FA_DATA4)