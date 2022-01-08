library(tidyverse)
library(here)
theme_set(theme_minimal())

d <- read_csv(here("experiment","computation_time_experiment",
                   "scag_type_value_experiment_benchmark.csv")) %>%
  separate(expr,into=c("type","strength"),sep="_")
d

d %>%
  mutate(time = time * 1e-9,type = factor(type),
         # strength = paste("measurement strength =",strength)
         ) %>%
  group_by(type,strength) %>%
  summarize(time = mean(time)) %>%
  ungroup() %>%
  group_by(type) %>%
  mutate(type_mean_time = mean(time)) %>%
  ungroup() %>%
  mutate(type = fct_reorder(type,type_mean_time)) %>%
  ggplot(aes(x = strength,y = time)) +
    geom_bar(stat="identity") +
    facet_wrap(~type,nrow = 3,scales = "free_y") +
  labs(x = "Measurement strength",y = "Mean time in seconds",title = "Mean time in seconds taken to generate 5 replicates")
