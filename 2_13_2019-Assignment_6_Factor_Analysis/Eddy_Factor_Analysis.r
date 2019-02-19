library(haven)
library(psych)
library(GPArotation)

DATA <- read_sav("PSYC 6327 Factor Analysis Assignment Data.sav")

SCREE <- scree(DATA, pc=FALSE)
SCREE
typeof(SCREE)

PA <- fa.parallel(DATA, fa="fa")
PA

# Hypothesized number of factors based on scree plot is 3.
# VSS function documentation suggests applying "more than hypothesized," so using 4.
# Default rotation - varimax

VSS(DATA, n=4)

VSS(DATA, n=4, rotate="oblimin")

# Was getting an error that I found might be related to missing data in teh dataset.
# Solved using this clean-up syntax:

DATA <- DATA[complete.cases(DATA),]

# Creating correlation table for fa() function, and requesting matrices.

COR_DATA <- cor(DATA)

FA_DATA <- fa(COR_DATA, nfactors=3, rotate="varimax")
fa.sort(FA_DATA)

FA_DATA2 <- fa(COR_DATA, nfactors=2, rotate="oblimin")
fa.sort(FA_DATA2)

FA_DATA3 <- fa(COR_DATA, nfactors=3, rotate="oblimin")
fa.sort(FA_DATA3)

FA_DATA4 <- fa(COR_DATA, nfactors=7, rotate="oblimin")
fa.sort(FA_DATA4)

# Looking at survey item labels

str(DATA, nchar.max=1000)