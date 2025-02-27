library(tidyverse)
library(caret)
library(mlbench) ## training dataset for ml problem

## split
split_data <- function(data) {
  set.seed(42)
  n <- nrow(data)
  id <- sample(1:n, size=0.7*n)
  train_df <- data[id, ]
  test_df <- data[-id, ]
  return(list(train=train_df, test=test_df))
}

prep_df <- split_data(mtcars)

## k-fold cross validation

set.seed(42)

grid_k <- data.frame(k = c(3,5))


ctrl <- trainControl(method = "cv",
                     number = 5, # k
                     verboseIter = TRUE)

## repeated k-fold cv
ctrl_r <- trainControl(method = "repeatedcv",
                     number = 5, # k
                     repeats = 5,
                     verboseIter = TRUE)

knn <- train(mpg ~ .,
             data = prep_df$train,
             method = "knn",
             metric = "RMSE",
             trControl = ctrl
             #tuneGrid = grid_k
             #tuneLenght = 3 # random k
             )

## classification
## PimaIndiansDiabetes in mlbench

data("PimaIndiansDiabetes")

df <- PimaIndiansDiabetes

## check / inspect data
sum(complete.cases(df))
mean(complete.cases(df)) == 1

glimpse(df)

## logistic regression method = "glm"
splited_data <- split_data(df)

set.seed(42)

ctrl <- trainControl(method = "cv",
                     number = 5)

logit_model <- train(diabetes ~ . - triceps, 
                     data = splited_data$train, 
                     method = "glm",
                     trControl = ctrl)

## final model
logit_model$finalModel

## variable importance
varImp(logit_model)

## confusion matrix
p <- predict(logit_model, newdata = splited_data$test)
p_prob <- predict(logit_model, newdata = splited_data$test, type = "prob")
p2 <- ifelse(p_prob$pos >= 0.7, "pos", "neg")

table_1 <- table(p, splited_data$test$diabetes, dnn = c("Predict", "Actual"))
table_2 <- table(p2, splited_data$test$diabetes, dnn = c("Predict", "Actual"))

## caret: confusion matrix
confusionMatrix(p, splited_data$test$diabetes, positive="pos", mode = "prec_recall")

## regression => high bias
## data change => model doesn't change that much

## save model .RDS
saveRDS(logit_model, "logistic_reg.RDS")

