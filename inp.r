#!/usr/bin/Rscript

if(!file.exists("./pml-training.rds"))
{
    library(caret)
    training <- read.csv("pml-training.csv", header=T)
    saveRDS(training, file="./pml-training.rds")
    rm(ls="training")
}

training <- readRDS("./pml-training.rds")

numberOfNonFactorColumns <- 0
for(i in 1:dim(training)[2])
{
    if(!class(training[, i])=="factor")
    {
        numberOfNonFactorColumns <- numberOfNonFactorColumns + 1
    }
}
print(numberOfNonFactorColumns)
