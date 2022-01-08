library(rstudioapi)
library(here)

jobRunScript(here("experiment","computation_time_experiment","scag_type_value_experiment.R"),exportEnv = "R_GlobalEnv")

jobRunScript(here("experiment","generation_accuracy_experiment","experiment.R"),exportEnv = "R_GlobalEnv")
