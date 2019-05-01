setwd("C:/R_Files/PSYC_6327-Psychometrics/4_11_2019 - Test Manual")

library(haven)
library(psych)
library(GPArotation)
library(readr)

DATA_ALL <- read_csv("Data/EDDY_TestManualData_numeric_abridged.csv", 
                 na = "NA")

#Removing incomplete cases
DATA_ALL <- na.exclude(DATA_ALL)
View(DATA)


#Testing internal consistency obnibus and divided by hypothesized constructs
alpha(DATA_ALL[1:28])
alpha(DATA_ALL[1:10])
alpha(DATA_ALL[10:20])
alpha(DATA_ALL[21:28])


# Removing lower quality items to raise cronbach's alpha / omega, then checking internal consistency again
DATA <- DATA_ALL[,c(2:6,8:17,19:27,28,29,34,35)]
omega (DATA[1:25])
alpha (DATA[1:25])


# Hypothesized number of factors based on scree plot is 4.
# VSS function documentation suggests applying "more than hypothesized," so using 4.


PA <- fa.parallel((DATA[1:25]), fa="fa")
PA

VSS(DATA[1:25], n=3, rotate="oblimin")

# Creating correlation table for fa() function, and requesting matrices.

COR_DATA <- cor(DATA[1:25])

# Bowler suggested method
FA_DATA2 <- fa(COR_DATA, nfactors=3, rotate="oblimin", fm="pa")
FA_DATA2
FA_SORT <- fa.sort(FA_DATA2)
FA_SORT$
write.table(FA_SORT$Structure, "clipboard", sep="\t", row.names=FALSE)
# Extracts one factor of 7 items and one of 1 item


# Subset dataset for just the items I'm keeping and create total field


FACTOR1 <- DATA[,c("DA8","DA10","CO4","CO10","Age","Sex","Race")]
FACTOR1$TOTAL <- rowSums(FACTOR1[1:4])
hist(FACTOR1$TOTAL)


FACTOR2 <- DATA[,c("LC8","LC4","LC1","LC3","LC7","Age","Sex","Race")]
FACTOR2$TOTAL <- rowSums(FACTOR1[1:5])

FACTOR3 <- DATA[,c("LC5","CO7","CO9","Age","Sex","Race")]
FACTOR3$TOTAL <- rowSums(FACTOR1[1:3])

DATA$AGGREGATE <- FACTOR1$TOTAL + FACTOR2$TOTAL - FACTOR3$TOTAL
DATA$Factor1 <- FACTOR1$TOTAL
DATA$Factor2 <- FACTOR2$TOTAL
DATA$Factor3 <- FACTOR3$TOTAL
DATA_FINAL <- DATA[,c("Factor1","Factor2","Factor3","AGGREGATE","Age","Sex","Race")]

# Exporting to visualize in Tableau
write.csv(DATA_FINAL, "DATA_FINAL.csv")

omega(DATA)

# Calculate Reliability estimates

alpha(KEEPERS)
omega(KEEPERS)

# Group differences on aggregate score

DATA_Male = subset(DATA_FINAL, DATA_FINAL$Sex=="1")
DATA_Female = subset(DATA_FINAL, DATA_FINAL$Sex=="2")
t.test(DATA_Female$AGGREGATE,DATA_Male$AGGREGATE)

DATA_White = subset(DATA_FINAL, DATA_FINAL$Race=="1")
DATA_AfricanAmerican = subset(DATA_FINAL, DATA_FINAL$Race=="2")
t.test(DATA_White$AGGREGATE,DATA_AfricanAmerican$AGGREGATE)

#DATA_18to24 = subset(DATA_FINAL, DATA_FINAL$Age=="2")
#DATA_25to34 = subset(DATA_FINAL, DATA_FINAL$Age=="3")
#t.test(DATA_18to24$AGGREGATE,DATA_25to34$AGGREGATE)
# n too small for age group comparison

# Group differences on Factor 1 score

t.test(DATA_Female$Factor1,DATA_Male$Factor1)

t.test(DATA_White$Factor1,DATA_AfricanAmerican$Factor1)

# Group differences on Factor 2 score

t.test(DATA_Female$Factor2,DATA_Male$Factor2)

t.test(DATA_White$Factor2,DATA_AfricanAmerican$Factor2)

# Group differences on Factor 3 score

t.test(DATA_Female$Factor3,DATA_Male$Factor3)

t.test(DATA_White$Factor3,DATA_AfricanAmerican$Factor3)


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