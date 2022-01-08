library(scatteR)
library(microbenchmark)
library(here)

# computation time by init points ---------------------------------
minified <- FALSE
if(minified){
  replicates <- 2
  n_points <- 10
  values <- seq(0,1,length.out=1)
  types <- c("Monotonic")
  init_point_values <- c(5)
}else{
  replicates <- 10
  n_points <- 50
  values <- seq(0,1,length.out=3)
  types <- c("Monotonic","Skinny","Sparse","Stringy","Convex","Skewed","Clumpy","Striated","Outlying")
  init_point_values <- seq(5,n_points,by=5)
}

main_mcb <- NULL

for(type in types){
  for(value in values){
    # print(paste(type,value))
    measurement <- c(value)
    names(measurement) <- c(type)
    for(init_points in init_point_values){
      print(paste(type,value,init_points))
      mcb <- microbenchmark(
        scatteR(measurements = measurement,
                init_points = init_points,n_points = n_points,
                global_min = 0.0001,error_var = 0.1,verbose = FALSE),
        times = replicates
      )
      mcb_ <- as.data.frame(mcb)
      mcb_$expr <- paste0(type,"_",value)
      mcb_$inits <- init_points
      main_mcb <- rbind(main_mcb,mcb_)
    }
  }
}


write.csv(main_mcb,
          here("experiment","computation_time_experiment","results",
               "init_point_experiment.csv"),
          row.names = FALSE)
