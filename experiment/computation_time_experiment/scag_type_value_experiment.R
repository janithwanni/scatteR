library(scatteR)
library(microbenchmark)
library(here)

# computation time by scag type and value ---------------------------------
minified <- FALSE
if(minified){
  replicates <- 2
  n_points <- 10
  init_points <- 5
  values <- seq(0,1,length.out=1)
  types <- c("Monotonic")
}else{
  replicates <- 10
  n_points <- 50
  init_points <- 5
  values <- seq(0,1,length.out=3)
  types <- c("Monotonic","Skinny","Sparse","Stringy","Convex","Skewed","Clumpy","Striated","Outlying")
}

main_mcb <- NULL

for(type in types){
  for(value in values){
    print(paste(type,value))
    measurement <- c(value)
    names(measurement) <- c(type)
    mcb <- microbenchmark(
      scatteR(measurements = measurement,
              init_points = init_points,n_points = n_points,
              global_min = 0.0001,error_var = 0.1,verbose = FALSE),
      times = replicates
    )
    mcb_ <- as.data.frame(mcb)
    mcb_$expr <- paste0(type,"_",value)
    # print(mcb_)
    main_mcb <- rbind(main_mcb,mcb_)
    # print(main_mcb)
  }
}

write.csv(main_mcb,
          here("experiment","computation_time_experiment","results",
               "scag_type_value_experiment_benchmark.csv"),
          row.names = FALSE)
