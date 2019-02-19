library(haven)
library(psych)
library(GPArotation)

DATA <- read_sav("PSYC 6327 Factor Analysis Assignment Data.sav")

# Messing with the labels
# unname(DATA)
# names(DATA) <- c()
########################

FA <- fa(DATA,6)
FA

kaiser(FA)

SCREE <- scree(DATA)
SCREE

PA <- fa.parallel(DATA)
PA



# Hypothesized number of factors based on dataset labels is 6.
# VSS function documentation suggests applying "more than hypothesized," so using function default of 8.
# Default rotation - varimax

VSS(DATA, n=4)

VSS(DATA, rotate="oblimin")

DATA <- DATA[complete.cases(DATA),]

fa(DATA)
COR_DATA <- cor(DATA)
FA_DATA <- fa(COR_DATA, rotate="varimax", oblique.scores=TRUE, covar=TRUE, residuals=TRUE)

fa.sort(FA_DATA)
