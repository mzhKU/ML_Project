#!/usr/bin/Rscript

# Impute missing values with mean.

mean.imp <- function(a)
{
    missing <- is.na(a)
    n.missing <- sum(missing)
    a.obs <- a[!missing]
    imputed <- a
    imputed[missing] <- mean(a, na.rm=TRUE)
    return(imputed)
}

