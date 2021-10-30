#' @title Generate scatterplots based on the scagnostics measurement
#' @param measurements A named vector containing the scagnostic measurements that the resulting scatterplot should have
#' @param n_points The number of points that the resulting scatterplot should have.
#' @param init_points The number of initial points to use to build the iterative scatterplots
#' @param global_min the error that the resulting scagnostics can give
#' @param error_var the variance of the random error that is added on to the existing points
#' @param epochs number of epochs the optimization method should run
#' @param seed The random number generation seed
#' @param verbose Logical. TRUE means that messages from the optimization algorithm are shown. Default is TRUE
#' @param ... Extra arguments to be fed into GenSA package
#' @export
scatteR <- function(measurements = c("Monotonic" = 1.0,"Outlying" = 0.5),
                    n_points = 50,init_points = 5,
                    global_min = 0.001,error_var = 0.001,epochs = 100,
                    seed = 1835,verbose = TRUE,...){
  # TODO set init_points and iterations to NULL
  # TODO check if both init_points and iterations are NULL and raise error
  # TODO set the initi_points or iterations accordingly
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
    return(mean(abs(current_value - measurements)))
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
    }
    else{
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
