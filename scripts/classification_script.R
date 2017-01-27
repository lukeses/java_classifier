library(readr)
require(RWeka)
require(caret)

result <- read.csv(file.path("~/java-classifier/results/result.csv"), stringsAsFactors=FALSE)
str(result)
input <- data.frame(result)
input[, 'real_class'] <- as.factor(input[, 'real_class'])


fitJ48 <- J48(real_class~., data=input)
summary(fitJ48)
print(fitJ48)

train_control<- trainControl(method="cv", number=10, savePredictions = TRUE, returnData = TRUE)
model <- train(real_class~., data=input, trControl=train_control, method="J48")
print(model)
accuracy_analysis <- confusionMatrix(model$pred$pred, reference=model$pred$obs)

