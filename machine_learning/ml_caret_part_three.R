library(tidyverse)
library(caret)
library(mlbench)

data("PimaIndiansDiabetes")

df <- PimaIndiansDiabetes

## decision tree
set.seed(42)

ctrl <- trainControl(method = "cv",
                     number = 5)

tree_model <- train(diabetes ~ . - triceps, 
                     data = df, 
                     method = "rpart", # decision tree
                     trControl = ctrl)

forest_model <- train(diabetes ~ . - triceps, 
                    data = df, 
                    method = "rf", # random forest tree
                    trControl = ctrl)

glmnet_model <- train(diabetes ~ . - triceps, 
                    data = df, 
                    method = "glmnet", # ridge/lasso regression
                    trControl = ctrl,
                    tuneGrid = expand.grid(
                      alpha = c(0,1),
                      lambda = c(0.01, 0.10)
                    ))