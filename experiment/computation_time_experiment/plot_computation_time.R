library(tidyverse)
library(here)
theme_set(theme_minimal())

d <- read_csv(here("experiment","computation_time_experiment","results",
                   "scag_type_value_experiment_benchmark.csv")) %>%
  separate(expr,into=c("type","strength"),sep="_")
d

scag_type_value_plot <- d %>%
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
    geom_label(aes(label = round(time,1)))+
    facet_wrap(~type,nrow = 3,scales = "free_y") +
  labs(x = "Measurement strength",y = "Mean time in seconds",
       title = "Mean time in seconds taken to generate 10 replicates",
       subtitle = "Mean time  based on 10 replicates of 50 points generated with 5 initial points")
ggsave(here("experiment","computation_time_experiment","results",
            "scag_type_value_plot.jpg"),plot = scag_type_value_plot,
       device = "jpg",width = 11,height = 8,units = "in",dpi = 300)
