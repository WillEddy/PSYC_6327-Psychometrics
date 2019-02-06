

library(foreign)

# SAV file?
write.table(read.spss("LLH Data.sav"), file="LLH Data.csv", quote = FALSE, sep = ",")