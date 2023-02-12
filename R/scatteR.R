#' @title Generate scatterplots based on the scagnostics measurement
#' @param measurements A named vector containing the scagnostic measurements that the resulting scatterplot should have
#' @param n_points The number of points that the resulting scatterplot should have.
#' @param init_points The number of initial points to use to build the iterative scatterplots. Default is NULL in which case the factors of n_points will be calculated and the 25th quantile from the set of factors will be used.
#' @param global_min the error that the resulting scagnostics can give
#' @param error_var the variance of the random error that is added on to the existing points
#' @param epochs number of epochs the optimization method should run
#' @param seed The random number generation seed
#' @param verbose Logical. TRUE means that messages from the optimization algorithm are shown. Default is TRUE
#' @param loss The loss function to be used within the scatteR program. Can be either 'mae' or 'mse'. Default is 'mae'
#' @param ... Extra arguments to be used in the control argument of the GenSA function of the GenSA package
#' @return A bivariate data.frame with two columns named x and y that gives a roughly similar scagnostic measurement to the `measurements` argument
#' @export
scatteR <- function(measurements = c("Monotonic" = 1.0,"Outlying" = 0.5),
                    n_points = 50,init_points = NULL,
                    global_min = 0.001,error_var = 0.001,epochs = 100,
                    seed = 1835,verbose = TRUE,loss="mae",...){
  if(is.null(init_points)){
    factors <- which(n_points %% seq(1,n_points) == 0)
    init_points <- as.numeric(factors[ceiling(stats::quantile(seq(length(factors)),0.25))])
  }
  dimension <- 2 * init_points
  iterations <- round(n_points / init_points)
  lower <- rep(0.0,(2*init_points))
  upper <- rep(1.0,(2*init_points))
  global.min <- global_min
  error_variance <- error_var
  set.seed(seed)

  loss_func <- function(solution){
    x <- c(mx,solution[1:init_points])
    y <- c(my,solution[(init_points+1):length(solution)])
    result <- scagnostics::scagnostics(x,y)
    current_value <- result[names(measurements)]
    if(loss == "mae"){
      return(mean(abs(current_value - measurements)))
    }else if(loss == "mse"){
      return(mean((current_value - measurements)^2))
    }else{
      return(mean(abs(current_value - measurements)))
    }
  }

  mx <- c()
  my <- c()
  ox <- NULL
  oy <- NULL
  for(iter in 1:iterations){
    if(verbose){
      print(paste("Epoch",iter))
    }
    if(is.null(ox) & is.null(oy)){
      par <- stats::runif(dimension)
    }else{
      xeps <- stats::rnorm(init_points,mean=0,sd=error_variance)
      yeps <- stats::rnorm(init_points,mean=0,sd=error_variance)
      par <- c(ox+xeps,oy+yeps)
    }
    out <- GenSA::GenSA(par = par,
                 lower = lower,upper = upper,
                 fn = loss_func,
                 control = list(maxit = epochs, threshold.stop = global.min,
                                verbose=verbose,smooth = FALSE,seed = seed,
                                trace.mat = FALSE,...))
    ox <- out$par[1:init_points]
    oy <- out$par[(init_points+1):length(out$par)]
    mx <- c(mx,ox)
    my <- c(my,oy)
  }
  return(data.frame(x = mx,y = my))
}
