setwd("C:/R_Files/PSYC_6327-Psychometrics/4_11_2019 - Test Manual")

library(haven)
library(psych)
library(GPArotation)
library(readr)
DATA_ALL <- read_csv("Data/EDDY_TestManualData_numeric_abridged.csv", 
                 na = "NA")

DATA <- DATA_ALL[,1:28]

View(DATA)

# Identifying Reverse Scored Items - look for negative loadings
DATA <- DATA[complete.cases(DATA),]
COR_DATA <- cor(DATA)
Rev_Score_Ident <- fa(COR_DATA, nfactors=1, rotate="oblimin")
fa.sort(Rev_Score_Ident)

# Recoding data for reverse scored items
DATA$"DA1"[DATA$"DA1"=="1"] <- "5_rev"
DATA$"DA1"[DATA$"DA1"=="2"] <- "4_rev"
DATA$"DA1"[DATA$"DA1"=="4"] <- "2"
DATA$"DA1"[DATA$"DA1"=="5"] <- "1"
DATA$"DA1"[DATA$"DA1"=="5_rev"] <- "5"
DATA$"DA1"[DATA$"DA1"=="4_rev"] <- "4"
DATA$"DA1" <- as.numeric(DATA$"DA1")

DATA$"CO8"[DATA$"CO8"=="1"] <- "5_rev"
DATA$"CO8"[DATA$"CO8"=="2"] <- "4_rev"
DATA$"CO8"[DATA$"CO8"=="4"] <- "2"
DATA$"CO8"[DATA$"CO8"=="5"] <- "1"
DATA$"CO8"[DATA$"CO8"=="6"] <- "NA"
DATA$"CO8"[DATA$"CO8"=="7"] <- "NA"
DATA$"CO8"[DATA$"CO8"=="5_rev"] <- "5"
DATA$"CO8"[DATA$"CO8"=="4_rev"] <- "4"
DATA$"CO8" <- as.numeric(DATA$"CO8")

DATA$"DA7"[DATA$"DA7"=="1"] <- "5_rev"
DATA$"DA7"[DATA$"DA7"=="2"] <- "4_rev"
DATA$"DA7"[DATA$"DA7"=="4"] <- "2"
DATA$"DA7"[DATA$"DA7"=="5"] <- "1"
DATA$"DA7"[DATA$"DA7"=="6"] <- "NA"
DATA$"DA7"[DATA$"DA7"=="7"] <- "NA"
DATA$"DA7"[DATA$"DA7"=="5_rev"] <- "5"
DATA$"DA7"[DATA$"DA7"=="4_rev"] <- "4"
DATA$"DA7" <- as.numeric(DATA$"DA7")

DATA$"CO5"[DATA$"CO5"=="1"] <- "5_rev"
DATA$"CO5"[DATA$"CO5"=="2"] <- "4_rev"
DATA$"CO5"[DATA$"CO5"=="4"] <- "2"
DATA$"CO5"[DATA$"CO5"=="5"] <- "1"
DATA$"CO5"[DATA$"CO5"=="6"] <- "NA"
DATA$"CO5"[DATA$"CO5"=="7"] <- "NA"
DATA$"CO5"[DATA$"CO5"=="5_rev"] <- "5"
DATA$"CO5"[DATA$"CO5"=="4_rev"] <- "4"
DATA$"CO5" <- as.numeric(DATA$"CO5")

DATA$"CO9"[DATA$"CO9"=="1"] <- "5_rev"
DATA$"CO9"[DATA$"CO9"=="2"] <- "4_rev"
DATA$"CO9"[DATA$"CO9"=="4"] <- "2"
DATA$"CO9"[DATA$"CO9"=="5"] <- "1"
DATA$"CO9"[DATA$"CO9"=="6"] <- "NA"
DATA$"CO9"[DATA$"CO9"=="7"] <- "NA"
DATA$"CO9"[DATA$"CO9"=="5_rev"] <- "5"
DATA$"CO9"[DATA$"CO9"=="4_rev"] <- "4"
DATA$"CO9" <- as.numeric(DATA$"CO9")

# Begin factor analysis

PA <- fa.parallel(DATA, fa="fa")
PA

# Hypothesized number of factors based on scree plot is 3.
# VSS function documentation suggests applying "more than hypothesized," so using 4.
# Default rotation - varimax

VSS(DATA, n=6, rotate="oblimin")

VSS(DATA, n=4, rotate="oblimin")

# Was getting an error that I found might be related to missing data in the dataset.
# Solved using this clean-up syntax:

DATA <- DATA[complete.cases(DATA),]

# Creating correlation table for fa() function, and requesting matrices.

COR_DATA <- cor(DATA)


FA_DATA2 <- fa(COR_DATA, nfactors=1, rotate="oblimin")
fa.sort(FA_DATA2)

# Bowler suggested method
FA_DATA2 <- fa(COR_DATA, nfactors=2, rotate="Promax", fm="pa")
0
# Extracts one factor of 7 items and one of 1 item


FA_DATA2 <- fa(COR_DATA, nfactors=3, rotate="oblimin")
fa.sort(FA_DATA2)
#Extracts 3 factors: one of 4 and two of 2
# Factor 1: 28, 17, 11, 23 - conscientiousness
# Factor 3: 6, 4 - lateral thinking ability
# Factor 2: 5, 26 (reverse scored?) - rule following VS external locus of control



FA_DATA2 <- fa(COR_DATA, nfactors=4, rotate="oblimin")
fa.sort(FA_DATA2)
#Extracts 4 factors of 2 items
# Factor 4: 28, 10 - team value (conscientiousness?)
# Factor 1: 17, 18 - self efficacy
# Factor 3: 6, 4 - lateral thinking ability
# Factor 2: 5, 26 (reverse scored?) - rule following VS external locus of control

FA_DATA2 <- fa(COR_DATA, nfactors=5, rotate="oblimin")
fa.sort(FA_DATA2)
# 4 of 2, 1 of 1
# Factor 4: 28, 10 - conscientiousness
# Factor 1: 17, 18 - self efficacy
# Factor 3: 6, 4 = lateral thinking ability
# Factor 2: 22, 21 - Dispositional autonomy
# Factor 5: 2


FA_DATA2 <- fa(COR_DATA, nfactors=6, rotate="oblmin")
fa.sort(FA_DATA2)
# Factor 3: 6,4,3 - Lateral thinking
# Factor 4: 28
# Factor 1: 17, 18 - self efficacy
# Factor 2: 21. 22 - Dispositional autonomy
# Factor 6: X
# Factor 5: 2

# Subset dataset for just the items I'm keeping

KEEPERS <- DATA[,c("LC1","CO4","DA6","DA8","LC4","LC7","DA10")]

View(KEEPERS)

# Calculate Reliability estimates

alpha(KEEPERS)
omega(KEEPERS)
