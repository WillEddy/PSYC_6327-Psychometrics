DATA <- read_csv("2_2_19-Inter_Rater_Reliability_Assignment/PSYC 6327 Interrater Reliability Assignment_RECODED.csv")

View(DATA)

library(psych)

N <- DATA[c(2:11)]
E <- DATA[c(12:21)]
O <- DATA[c(22:31)]
A <- DATA[c(32:41)]
C <- DATA[c(42:51)]



N1_VAR <- var(N[1,1:10])
View(N1_VAR)

View(N)
Rwg_A <- 1-(A/2)
Rwg_A

# Sources utilized
# https://www.statmethods.net/management/subset.html
#
#
#
#
#