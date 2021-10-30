library(scatteR)
library(scagnostics)
library(tibble)
library(here)
print(sessionInfo())

values <- seq(0,1,length.out=3)
types <- c("Monotonic","Skinny","Sparse","Stringy","Convex","Skewed","Clumpy","Striated","Outlying")
# values <- c(1)
# types <- c("Clumpy")
replicates <- 20
n_points <- 50
init_points <- 5
table <- tibble(measurement_type = rep(types,each=3),measurement_value = rep(values,length(types)),rmse = -1,mae = -1)

for(type in types){
  for(value in values){
    error_vector <- c()
    for(i in seq(replicates)){
      print(paste(type,value,i))
      measurement = c(value)
      names(measurement) <- c(type)
      df <- scatteR(measurements = measurement,init_points = init_points,n_points = n_points,global_min = 0.0001,error_var = 0.1)
      result <- scagnostics.data.frame(df)[type]
      print(paste(type,value,i,result))
      error_vector <- c(error_vector,(result-value))
    }
    rmse <- sqrt(mean(error_vector^2))
    mae <- mean(abs(error_vector))
    table[table$measurement_type == type &
            table$measurement_value == value,"rmse"] = rmse
    table[table$measurement_type == type &
            table$measurement_value == value,"mae"] = mae
    write.csv(table,here("experiment","table.csv"))
  }
}
