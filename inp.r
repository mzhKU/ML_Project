#!/usr/bin/Rscript

if(!file.exists("./pml-training.rds"))
{
    training <- read.csv("pml-training.csv", header=T)
    saveRDS(training, file="./pml-training.rds")
    rm(ls="training")
}

tr <- readRDS("./pml-training.rds")

library(caret)

inTrain <- createDataPartition(y=tr$classe, p=0.7, list=FALSE)

training <- tr[inTrain, ]
test <- tr[-inTrain, ]

# Keep only int and num features.
training_numeric <- training[sapply(training, is.numeric)]

# 'Red'uced data frame.
red <- training_numeric[c("roll_belt", "pitch_belt", "yaw_belt", "total_accel_belt",
                          "roll_arm", "pitch_arm", "yaw_arm", "total_accel_arm",
                          "roll_dumbbell", "pitch_dumbbell", "yaw_dumbbell",
                          "total_accel_dumbbell",
                          "roll_forearm", "pitch_forearm", "yaw_forearm",
                          "total_accel_forearm")]

# Reattach 'classe' variable.
red <- cbind(red, tr[inTrain, "classe"]) 

# Check that no NA values are in features:
# > for(i in 1:length(names(red))-1){print(any(is.na(red[[1]])))}

# Rename 'tr$classe' to 'classe'
colnames(red)[17] <- "classe"

# Fitting a model- didn't get it to work.
#library(randomForest)
#modelFitRF <- randomForest(classe ~ ., data=red, prox=TRUE,
#                           sampsize=nrow(red)/100)

# New try, following lecture 'Prediction with Trees'.
# modelFitRPart <- train(classe ~ ., data=red, method="rpart")

# Preprocess and train with cross-validation.
if(file.exists("./modelFitPrepCVRF.rda"))
{
    load("modelFitPrepCVRF.rda")
} else {
    modelFitPrepRF <- train(classe ~ .,
                            data=red,
                            preProcess=c("center", "scale"),
                            trControl=trainControl(method="cv", number=25),
                            method="rf")
    save(modelFitPrepRF, file="modelFitPrepCVRF.rda")
}
# Predict.
#predict(modelFitPrepRF, newdata=test_red)
## or ?
#predict(modelFitPrepRF, newdata=test)

# Load test data.
