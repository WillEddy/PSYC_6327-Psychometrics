

DATA <- read.csv("Assignment_4_Data.csv", header=TRUE, na.strings="-999", nrows = 100)
colnames(DATA)[1] <- "Age"

library(psych)

# After identifying the variables that are reverse scored, I recode them using the psych package

# Checking for reverse-scored items using a reliability test
alpha(DATA)

#DATA_RC <- reverse.code(c(1,1,1,1,1,-1,-1,-1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
#                         1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1), DATA)

#DATA_RC <- as.data.frame(DATA_RC)


DATA_RC <- DATA

#Splitting off JP items, running factor analysis on them
JP <- DATA_RC[c("JP1", "JP2", "JP3")]
alpha(JP)

#Splitting off CPC items, calculating chronbach's alpha
CPC <- DATA_RC[c("CPC1", "CPC2", "CPC3", "CPC4")]
CPC <- as.data.frame(CPC)
alpha(CPC)

#Splitting off WRB items, running factor analysis on them
WRB <- DATA_RC[c("WRB1", "WRB2", "WRB3", "WRB4", "WRB5", "WRB6", "WRB7")]
alpha(WRB)

#Splitting off PB items, running factor analysis on them
PB <- DATA_RC[c("PB1", "PB2", "PB3", "PB4", "PB5", "PB6", "PB7", "PB8", "PB9", "PB10", "PB11", "PB12")]
alpha(PB)

#Splitting off PIB items, running factor analysis on them
PIB <- DATA_RC[c("PIB1", "PIB2", "PIB3")]
alpha(PIB)

#Splitting off WIS items, running factor analysis on them
WIS <- DATA_RC[c("WIS1", "WIS2", "WIS3", "WIS4", "WIS5", "WIS6", "WIS7", "WIS8", "WIS9", "WIS10", "WIS11")]
alpha(WIS)

#Splitting off WS items, running factor analysis on them
WS <- DATA_RC[c("WS1", "WS2", "WS3", "WS4", "WS5", "WS6", "WS7", "WS8")]
alpha(WIS)

#Splitting off TI items, running factor analysis on them
TI <- DATA_RC[c("TI1", "TI2", "TI3", "TI4")]
alpha(WIS)


# Sources utilized ####################################################
#
# Doing Factor Analysis with psych package
# http://personality-project.org/r/psych/HowTo/factor.pdf
#
# Renaming one column in a data.frame
# https://stackoverflow.com/questions/7531868/how-to-rename-a-single-column-in-a-data-frame
#
# Dealing with null data strings
# https://stackoverflow.com/questions/45765944/na-strings-c-in-r?rq=1
#
# Using R and psych package to calculate omega
# http://personality-project.org/r/psych/HowTo/omega.pdf
#
