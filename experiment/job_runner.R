library(rstudioapi)
library(here)

jobRunScript(here("experiment","computation_time_experiment","scag_type_value_experiment.R"),exportEnv = "R_GlobalEnv.scag_type")

jobRunScript(here("experiment","computation_time_experiment","init_points_experiment.R"),exportEnv = "R_GlobalEnv.init_points")

jobRunScript(here("experiment","generation_accuracy_experiment","experiment.R"),exportEnv = "R_GlobalEnv")
