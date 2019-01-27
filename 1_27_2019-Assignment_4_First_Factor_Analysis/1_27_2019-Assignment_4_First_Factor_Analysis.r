# 1. Clean the Data 
# DONE
#
# 2. Are any of the variables reversed scored? Run a 1-factor EFA on each of the factors to ascertain if
# they are or are not. Recode any that are not and then rerun the EFA to ensure that everything is aligned correctly.
# DONE
#
# 3. Calculate the internal consistency of each of the following variables: Job performance,
# competitive psychological climate, work-role behaviors, psychological bullying, perceived
# incivility behaviors, work incivility scale, work stress, turnover intentions
#
# 4. Do all of the scales demonstrate appropriate internal consistency?
#
# 5. Can any of the scales be improved?

DATA <- read.csv("Assignment_4_Data.csv", header=TRUE, na.strings="-999")
colnames(DATA)[1] <- "Age"
View(DATA)

library(psych)
library(hemp)

# Splitting off CPC items, calculating chronbach's alpha
# CPC <- DATA[c("CPC1", "CPC2", "CPC3", "CPC4")]
# alpha(CPC)

# Splitting off WRB items, running factor analysis on them
# WRB <- DATA[c("WRB1", "WRB2", "WRB3", "WRB4", "WRB5", "WRB6", "WRB7")]
# alpha(WRB)

# Splitting off CPC items, running factor analysis on them
# JP <- DATA[c("JP1", "JP2", "JP3")]
# alpha(JP)

# Checking for reverse-scored items using a reliability test
alpha(DATA)

DATA <- reverse.code(c(1,-1,-1,-1,1,-1,-1,-1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
               1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1), DATA)

alpha(DATA)

# After identifying that the variables 

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