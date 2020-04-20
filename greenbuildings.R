library(tidyverse)
library(mosaic)
library(FNN)
greenbuildings = read.csv("data/greenbuildings.csv")
set.seed(3)
rmse = function(y, yhat) {
  sqrt( mean( (y - yhat)^2 ) )
}
n = nrow(greenbuildings)
n_train = round(0.8*n) # round to nearest integer n_test = n ­ n_train
gb_no_green = subset(greenbuildings, green_rating == 0)
gb_no_green$green_rating[gb_no_green$green_rating == 0] <- 1
gb_green = subset(greenbuildings, green_rating == 1)
gb_green$green_rating[gb_green$green_rating == 1] <- 0


rmse_vals = do(100)*{
  
  # re-split into train and test cases with the same sample sizes
  train_cases = sample.int(n, n_train+1, replace=FALSE) 
  test_cases = setdiff(1:n, train_cases) 
  buildings_train = greenbuildings[train_cases,] 
  buildings_test = greenbuildings[test_cases,]
  
  lm1 = lm(Rent ~ renovated + size + stories + age + green_rating, data=buildings_test)
  lm2 = lm(Rent ~ (Gas_Costs + Electricity_Costs + total_dd_07)^2 + 
             (age + renovated)^2 + 
             (Gas_Costs + Electricity_Costs + green_rating)^2 +
             stories + 
             cluster_rent + 
             size, data=buildings_test)
  lm4 = lm(Rent ~ amenities + green_rating, data=buildings_test)
  lm5 = lm(Rent ~ Gas_Costs + Electricity_Costs + total_dd_07 + green_rating, data=buildings_test)
  
  # Predictions out of sample
  yhat_test1 = predict(lm1, buildings_test)
  yhat_test2 = predict(lm2, buildings_test)
  yhat_test4 = predict(lm4, buildings_test)
  yhat_test5 = predict(lm5, buildings_test)
  
  nogreen_to_green = predict(lm2, gb_no_green)
  green_to_nogreen = predict(lm2, gb_green)
  
  
  c(rmse(buildings_test$Rent, yhat_test1),
    rmse(buildings_test$Rent, yhat_test4),
    rmse(buildings_test$Rent, yhat_test5),
    rmse(buildings_test$Rent, yhat_test2),
    mean(nogreen_to_green - gb_no_green$Rent),
    mean(green_to_nogreen - gb_green$Rent)
    
  )
}


rmse_vals
boxplot(rmse_vals[1:4])
colMeans(rmse_vals[1:4])
boxplot(rmse_vals[5:6])
colMeans(rmse_vals[5:6])








