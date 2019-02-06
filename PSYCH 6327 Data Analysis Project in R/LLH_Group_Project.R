library (psych)

DATA <- read.csv("LLH_Trimmed.csv")

library(haven)
#DATA <- read_sav("LLH Data.sav")

describe (DATA)

cor.test(DATA$Q21_1,DATA$Q16_1)

cor.test(DATA$Q17_4,DATA$Q16_1)

cor.test(DATA$Q21_7,DATA$Q19)

cor.test(DATA$Q10,DATA$Q15_3)

Y <- c(DATA$Q15_1,DATA$Q15_2,DATA$Q15_3)

lm((DATA$Q10~Y), na.action = na.exclude)

