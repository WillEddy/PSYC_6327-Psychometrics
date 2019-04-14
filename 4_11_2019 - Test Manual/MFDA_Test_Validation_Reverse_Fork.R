setwd("C:/R_Files/PSYC_6327-Psychometrics/4_11_2019 - Test Manual")

library(haven)
library(psych)
library(GPArotation)
library(readr)
DATA_ALL <- read_csv("Data/numeric_abridged_ErrorRemoved.csv", 
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
DATA$"7"[DATA$"7"=="1"] <- "5_rev"
DATA$"7"[DATA$"7"=="2"] <- "4_rev"
DATA$"7"[DATA$"7"=="4"] <- "2"
DATA$"7"[DATA$"7"=="5"] <- "1"
DATA$"7"[DATA$"7"=="6"] <- "NA"
DATA$"7"[DATA$"7"=="7"] <- "NA"
DATA$"7"[DATA$"7"=="5_rev"] <- "5"
DATA$"7"[DATA$"7"=="4_rev"] <- "4"
DATA$"7" <- as.numeric(DATA$"7")

DATA$"10"[DATA$"10"=="1"] <- "5_rev"
DATA$"10"[DATA$"10"=="2"] <- "4_rev"
DATA$"10"[DATA$"10"=="4"] <- "2"
DATA$"10"[DATA$"10"=="5"] <- "1"
DATA$"10"[DATA$"10"=="6"] <- "NA"
DATA$"10"[DATA$"10"=="7"] <- "NA"
DATA$"10"[DATA$"10"=="5_rev"] <- "5"
DATA$"10"[DATA$"10"=="4_rev"] <- "4"
DATA$"10" <- as.numeric(DATA$"10")

DATA$"14"[DATA$"14"=="1"] <- "5_rev"
DATA$"14"[DATA$"14"=="2"] <- "4_rev"
DATA$"14"[DATA$"14"=="4"] <- "2"
DATA$"14"[DATA$"14"=="5"] <- "1"
DATA$"14"[DATA$"14"=="6"] <- "NA"
DATA$"14"[DATA$"14"=="7"] <- "NA"
DATA$"14"[DATA$"14"=="5_rev"] <- "5"
DATA$"14"[DATA$"14"=="4_rev"] <- "4"
DATA$"14" <- as.numeric(DATA$"14")

DATA$"17"[DATA$"17"=="1"] <- "5_rev"
DATA$"17"[DATA$"17"=="2"] <- "4_rev"
DATA$"17"[DATA$"17"=="4"] <- "2"
DATA$"17"[DATA$"17"=="5"] <- "1"
DATA$"17"[DATA$"17"=="6"] <- "NA"
DATA$"17"[DATA$"17"=="7"] <- "NA"
DATA$"17"[DATA$"17"=="5_rev"] <- "5"
DATA$"17"[DATA$"17"=="4_rev"] <- "4"
DATA$"17" <- as.numeric(DATA$"17")

DATA$"18"[DATA$"18"=="1"] <- "5_rev"
DATA$"18"[DATA$"18"=="2"] <- "4_rev"
DATA$"18"[DATA$"18"=="4"] <- "2"
DATA$"18"[DATA$"18"=="5"] <- "1"
DATA$"18"[DATA$"18"=="6"] <- "NA"
DATA$"18"[DATA$"18"=="7"] <- "NA"
DATA$"18"[DATA$"18"=="5_rev"] <- "5"
DATA$"18"[DATA$"18"=="4_rev"] <- "4"
DATA$"18" <- as.numeric(DATA$"18")


DATA$"20"[DATA$"20"=="1"] <- "5_rev"
DATA$"20"[DATA$"20"=="2"] <- "4_rev"
DATA$"20"[DATA$"20"=="4"] <- "2"
DATA$"20"[DATA$"20"=="5"] <- "1"
DATA$"20"[DATA$"20"=="6"] <- "NA"
DATA$"20"[DATA$"20"=="7"] <- "NA"
DATA$"20"[DATA$"20"=="5_rev"] <- "5"
DATA$"20"[DATA$"20"=="4_rev"] <- "4"
DATA$"20" <- as.numeric(DATA$"20")

DATA$"21"[DATA$"21"=="1"] <- "5_rev"
DATA$"21"[DATA$"21"=="2"] <- "4_rev"
DATA$"21"[DATA$"21"=="4"] <- "2"
DATA$"21"[DATA$"21"=="5"] <- "1"
DATA$"21"[DATA$"21"=="6"] <- "NA"
DATA$"21"[DATA$"21"=="7"] <- "NA"
DATA$"21"[DATA$"21"=="5_rev"] <- "5"
DATA$"21"[DATA$"21"=="4_rev"] <- "4"
DATA$"21" <- as.numeric(DATA$"21")

DATA$"22"[DATA$"22"=="1"] <- "5_rev"
DATA$"22"[DATA$"22"=="2"] <- "4_rev"
DATA$"22"[DATA$"22"=="4"] <- "2"
DATA$"22"[DATA$"22"=="5"] <- "1"
DATA$"22"[DATA$"22"=="6"] <- "NA"
DATA$"22"[DATA$"22"=="7"] <- "NA"
DATA$"22"[DATA$"22"=="5_rev"] <- "5"
DATA$"22"[DATA$"22"=="4_rev"] <- "4"
DATA$"22" <- as.numeric(DATA$"22")

DATA$"24"[DATA$"24"=="1"] <- "5_rev"
DATA$"24"[DATA$"24"=="2"] <- "4_rev"
DATA$"24"[DATA$"24"=="4"] <- "2"
DATA$"24"[DATA$"24"=="5"] <- "1"
DATA$"24"[DATA$"24"=="6"] <- "NA"
DATA$"24"[DATA$"24"=="7"] <- "NA"
DATA$"24"[DATA$"24"=="5_rev"] <- "5"
DATA$"24"[DATA$"24"=="4_rev"] <- "4"
DATA$"24" <- as.numeric(DATA$"24")

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

FA_DATA <- fa(COR_DATA, nfactors=1)
fa.sort(FA_DATA)

FA_DATA2 <- fa(COR_DATA, nfactors=2, rotate="oblimin")
fa.sort(FA_DATA2)

FA_DATA3 <- fa(COR_DATA, nfactors=4, rotate="oblimin")
fa.sort(FA_DATA3)

