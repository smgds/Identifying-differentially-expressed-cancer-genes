# converts to .csv
# data from Pancreas_limma.py (RMA_pancreas.txt)

# set working directory
setwd("//dnausers/amyn/Personal/Lewis/BIOL 59000 Data Science Project for Life Scientists/Homework/R/Pancreas")

diff <- read.delim("RMA_liver.txt", header=TRUE)

names(diff)[1] <- "PROBEID"

write.csv(diff, file = "RMA_pancreas.csv")