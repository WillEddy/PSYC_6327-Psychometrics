setwd("C:/R_Files/PSYC_6327-Psychometrics/4_11_2019 - Test Manual")

library(haven)
library(psych)
library(GPArotation)
library(readr)
DATA_ALL <- read_csv("Data/numeric_abridged.csv", 
                 na = "NA")




DATA <- DATA_ALL[,1:28]
colnames(DATA) <- c("1","2","3","4","5","6","7","8","9","10"
                    ,"11","12","13","14","15","16","17","18","19","20","21"
                    ,"22","23","24","25","26","27","28"
                    )

# Identifying Reverse Scored Items - look for negative loadings
DATA <- DATA[complete.cases(DATA),]
COR_DATA <- cor(DATA)
Rev_Score_Ident <- fa(COR_DATA, nfactors=1, rotate="oblimin")
fa.sort(Rev_Score_Ident)

View(DATA_ALL)

#Items intended to be reverse scored: 7, 10, 14, 17, 18, 20, 21, 22, 24, 

# Recoding data for reverse scored items
DATA$"19"[DATA$"19"=="1"] <- "5_rev"
DATA$"19"[DATA$"19"=="2"] <- "4_rev"
DATA$"19"[DATA$"19"=="4"] <- "2"
DATA$"19"[DATA$"19"=="5"] <- "1"
DATA$"19"[DATA$"19"=="6"] <- "NA"
DATA$"19"[DATA$"19"=="7"] <- "NA"
DATA$"19"[DATA$"19"=="5_rev"] <- "5"
DATA$"19"[DATA$"19"=="4_rev"] <- "4"
DATA$"19" <- as.numeric(DATA$"19")

DATA$"26"[DATA$"26"=="1"] <- "5_rev"
DATA$"26"[DATA$"26"=="2"] <- "4_rev"
DATA$"26"[DATA$"26"=="4"] <- "2"
DATA$"26"[DATA$"26"=="5"] <- "1"
DATA$"26"[DATA$"26"=="6"] <- "NA"
DATA$"26"[DATA$"26"=="7"] <- "NA"
DATA$"26"[DATA$"26"=="5_rev"] <- "5"
DATA$"26"[DATA$"26"=="4_rev"] <- "4"
DATA$"26" <- as.numeric(DATA$"26")

DATA$"15"[DATA$"15"=="1"] <- "5_rev"
DATA$"15"[DATA$"15"=="2"] <- "4_rev"
DATA$"15"[DATA$"15"=="4"] <- "2"
DATA$"15"[DATA$"15"=="5"] <- "1"
DATA$"15"[DATA$"15"=="6"] <- "NA"
DATA$"15"[DATA$"15"=="7"] <- "NA"
DATA$"15"[DATA$"15"=="5_rev"] <- "5"
DATA$"15"[DATA$"15"=="4_rev"] <- "4"
DATA$"15" <- as.numeric(DATA$"15")

DATA$"22"[DATA$"22"=="1"] <- "5_rev"
DATA$"22"[DATA$"22"=="2"] <- "4_rev"
DATA$"22"[DATA$"22"=="4"] <- "2"
DATA$"22"[DATA$"22"=="5"] <- "1"
DATA$"22"[DATA$"22"=="6"] <- "NA"
DATA$"22"[DATA$"22"=="7"] <- "NA"
DATA$"22"[DATA$"22"=="5_rev"] <- "5"
DATA$"22"[DATA$"22"=="4_rev"] <- "4"
DATA$"22" <- as.numeric(DATA$"22")

DATA$"14"[DATA$"14"=="1"] <- "5_rev"
DATA$"14"[DATA$"14"=="2"] <- "4_rev"
DATA$"14"[DATA$"14"=="4"] <- "2"
DATA$"14"[DATA$"14"=="5"] <- "1"
DATA$"14"[DATA$"14"=="6"] <- "NA"
DATA$"14"[DATA$"14"=="7"] <- "NA"
DATA$"14"[DATA$"14"=="5_rev"] <- "5"
DATA$"14"[DATA$"14"=="4_rev"] <- "4"
DATA$"14" <- as.numeric(DATA$"14")

DATA$"20"[DATA$"20"=="1"] <- "5_rev"
DATA$"20"[DATA$"20"=="2"] <- "4_rev"
DATA$"20"[DATA$"20"=="4"] <- "2"
DATA$"20"[DATA$"20"=="5"] <- "1"
DATA$"20"[DATA$"20"=="6"] <- "NA"
DATA$"20"[DATA$"20"=="7"] <- "NA"
DATA$"20"[DATA$"20"=="5_rev"] <- "5"
DATA$"20"[DATA$"20"=="4_rev"] <- "4"
DATA$"20" <- as.numeric(DATA$"20")

DATA$"24"[DATA$"24"=="1"] <- "5_rev"
DATA$"24"[DATA$"24"=="2"] <- "4_rev"
DATA$"24"[DATA$"24"=="4"] <- "2"
DATA$"24"[DATA$"24"=="5"] <- "1"
DATA$"24"[DATA$"24"=="6"] <- "NA"
DATA$"24"[DATA$"24"=="7"] <- "NA"
DATA$"24"[DATA$"24"=="5_rev"] <- "5"
DATA$"24"[DATA$"24"=="4_rev"] <- "4"
DATA$"24" <- as.numeric(DATA$"24")

DATA$"5"[DATA$"5"=="1"] <- "5_rev"
DATA$"5"[DATA$"5"=="2"] <- "4_rev"
DATA$"5"[DATA$"5"=="4"] <- "2"
DATA$"5"[DATA$"5"=="5"] <- "1"
DATA$"5"[DATA$"5"=="6"] <- "NA"
DATA$"5"[DATA$"5"=="7"] <- "NA"
DATA$"5"[DATA$"5"=="5_rev"] <- "5"
DATA$"5"[DATA$"5"=="4_rev"] <- "4"
DATA$"5" <- as.numeric(DATA$"5")

# Begin factor analysis

SCREE <- scree(DATA, pc=FALSE)
SCREE

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

FA_DATA2 <- fa(COR_DATA, nfactors=3, rotate="oblimin")
fa.sort(FA_DATA2)

FA_DATA2 <- fa(COR_DATA, nfactors=5, rotate="oblimin")
fa.sort(FA_DATA2)

# Subset dataset for just the items I'm keeping

KEEPERS <- DATA[,c(2,3,4,6,8,17,18,27,28)]

View(KEEPERS)

# Calculate Reliability estimates

alpha(KEEPERS)
omega(KEEPERS)
