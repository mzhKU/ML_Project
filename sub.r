#!/usr/bin/Rscript

if(!file.exists("./pml-testing.rds"))
{
    testing <- read.csv("pml-testing.csv", header=T)
    saveRDS(testing, file="./pml-testing.rds")
    rm(ls="testing")
}

ts <- readRDS("./pml-testing.rds")


