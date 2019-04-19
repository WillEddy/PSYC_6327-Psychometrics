setwd("C:/R_Files/PSYC_6327-Psychometrics/4_11_2019 - Test Manual")

library(haven)
library(psych)
library(GPArotation)
library(readr)

DATA_ALL <- read_csv("Data/EDDY_TestManualData_numeric_abridged.csv", 
                 na = "NA")

#Removing incomplete cases
DATA_ALL <- na.exclude(DATA_ALL)

# Descriptive analysis

DEMOG <- (DATA_ALL[29:37])
DEMOG <- na.exclude(DEMOG)

summary(DEMOG)
histogram(DEMOG$Sex)


#Testing internal consistency
alpha(DATA_ALL[1:28])
alpha(DATA_ALL[1:10])
alpha(DATA_ALL[10:20])
alpha(DATA_ALL[21:28])


# Removing lower quality items to raise cronbach's alpha / omega
DATA <- DATA_ALL[,c(2,4:6,8:14,16,17,20:24,27,28,29,34,35)]
alpha (DATA[1:7])
alpha (DATA[8:14])
alpha (DATA[15:21])
alpha (DATA[1:20])

PA <- fa.parallel((DATA[1:20]), fa="fa")
PA

# Hypothesized number of factors based on scree plot is 4.
# VSS function documentation suggests applying "more than hypothesized," so using 4.

VSS(DATA, n=3, rotate="oblmin")


# Creating correlation table for fa() function, and requesting matrices.
#Removing incomplete cases
DATA <- na.exclude(DATA)

COR_DATA <- cor(DATA[1:20])


# Bowler suggested method
FA_DATA2 <- fa(COR_DATA, nfactors=2, rotate="oblmin", fm="pa")
FA_DATA2
fa.sort(FA_DATA2)
# Extracts one factor of 7 items and one of 1 item
# Subset dataset for just the items I'm keeping



DATA <- DATA[,c("DA6","DA8","DA10","CO4","LC1","LC3","Age","Sex","Race")]
DATA$Total <- rowSums(DATA[1:6])

alpha(DATA[1:6])


View(DATA)

omega(DATA)

# Calculate Reliability estimates

alpha(KEEPERS)
omega(KEEPERS)

DATA_Male = subset(DATA, DATA$Sex=="1")
DATA_Female = subset(DATA, DATA$Sex=="2")
t.test(DATA_Female$Total,DATA_Male$Total)

DATA_White = subset(DATA, DATA$Race=="1")
DATA_AfricanAmerican = subset(DATA, DATA$Race=="2")
t.test(DATA_White$Total,DATA_AfricanAmerican$Total)

DATA_18to24 = subset(DATA, DATA$Age=="2")
DATA_25to34 = subset(DATA, DATA$Race=="3")
t.test(DATA_18to24$Total,DATA_25to34$Total)

View(DATA)

head(DATA$Race)


# Identifying Reverse Scored Items - look for negative loadings

#COR_DATA <- cor(DATA)
#Rev_Score_Ident <- fa(COR_DATA, nfactors=1, rotate="oblimin")
#fa.sort(Rev_Score_Ident)

# Recoding data for reverse scored items
# DATA$"DA1"[DATA$"DA1"=="1"] <- "5_rev"
# DATA$"DA1"[DATA$"DA1"=="2"] <- "4_rev"
# DATA$"DA1"[DATA$"DA1"=="4"] <- "2"
# DATA$"DA1"[DATA$"DA1"=="5"] <- "1"
# DATA$"DA1"[DATA$"DA1"=="5_rev"] <- "5"
# DATA$"DA1"[DATA$"DA1"=="4_rev"] <- "4"
# DATA$"DA1" <- as.numeric(DATA$"DA1")
# 
# DATA$"CO8"[DATA$"CO8"=="1"] <- "5_rev"
# DATA$"CO8"[DATA$"CO8"=="2"] <- "4_rev"
# DATA$"CO8"[DATA$"CO8"=="4"] <- "2"
# DATA$"CO8"[DATA$"CO8"=="5"] <- "1"
# DATA$"CO8"[DATA$"CO8"=="6"] <- "NA"
# DATA$"CO8"[DATA$"CO8"=="7"] <- "NA"
# DATA$"CO8"[DATA$"CO8"=="5_rev"] <- "5"
# DATA$"CO8"[DATA$"CO8"=="4_rev"] <- "4"
# DATA$"CO8" <- as.numeric(DATA$"CO8")
# 
# DATA$"DA7"[DATA$"DA7"=="1"] <- "5_rev"
# DATA$"DA7"[DATA$"DA7"=="2"] <- "4_rev"
# DATA$"DA7"[DATA$"DA7"=="4"] <- "2"
# DATA$"DA7"[DATA$"DA7"=="5"] <- "1"
# DATA$"DA7"[DATA$"DA7"=="6"] <- "NA"
# DATA$"DA7"[DATA$"DA7"=="7"] <- "NA"
# DATA$"DA7"[DATA$"DA7"=="5_rev"] <- "5"
# DATA$"DA7"[DATA$"DA7"=="4_rev"] <- "4"
# DATA$"DA7" <- as.numeric(DATA$"DA7")
# 
# DATA$"CO5"[DATA$"CO5"=="1"] <- "5_rev"
# DATA$"CO5"[DATA$"CO5"=="2"] <- "4_rev"
# DATA$"CO5"[DATA$"CO5"=="4"] <- "2"
# DATA$"CO5"[DATA$"CO5"=="5"] <- "1"
# DATA$"CO5"[DATA$"CO5"=="6"] <- "NA"
# DATA$"CO5"[DATA$"CO5"=="7"] <- "NA"
# DATA$"CO5"[DATA$"CO5"=="5_rev"] <- "5"
# DATA$"CO5"[DATA$"CO5"=="4_rev"] <- "4"
# DATA$"CO5" <- as.numeric(DATA$"CO5")
# 
# DATA$"CO9"[DATA$"CO9"=="1"] <- "5_rev"
# DATA$"CO9"[DATA$"CO9"=="2"] <- "4_rev"
# DATA$"CO9"[DATA$"CO9"=="4"] <- "2"
# DATA$"CO9"[DATA$"CO9"=="5"] <- "1"
# DATA$"CO9"[DATA$"CO9"=="6"] <- "NA"
# DATA$"CO9"[DATA$"CO9"=="7"] <- "NA"
# DATA$"CO9"[DATA$"CO9"=="5_rev"] <- "5"
# DATA$"CO9"[DATA$"CO9"=="4_rev"] <- "4"
# DATA$"CO9" <- as.numeric(DATA$"CO9")

# Begin factor analysis