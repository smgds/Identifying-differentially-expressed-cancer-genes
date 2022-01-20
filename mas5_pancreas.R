# mas5.R
# read .cel files, perform mas5 for RFE.

library(affy)
library(limma)
library(dplyr)
library(gcrma)

# set working directory
setwd("//dnausers/amyn/Personal/Lewis/BIOL 59000 Data Science Project for Life Scientists/Homework/R/Pancreas")

# read .CEL files
Data <- ReadAffy()

eset <- mas5(Data)

write.csv(eset, file = "mas5_pancreas.csv", row.names = TRUE)
