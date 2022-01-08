library(tidyverse)
library(here)
theme_set(theme_minimal())

scag_type_file_path <- here("experiment","computation_time_experiment","results",
                            "scag_type_value_experiment_benchmark.csv")
if(file.exists(scag_type_file_path)){
d <- read_csv(scag_type_file_path) %>%
  separate(expr,into=c("type","strength"),sep="_")
d

scag_type_value_plot <- d %>%
  mutate(time = time * 1e-9,type = factor(type)) %>%
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
}

init_point_file_path <- here("experiment",
                             "computation_time_experiment","results",
                             "init_point_experiment.csv")

if(file.exists(init_point_file_path)){
  d <- read_csv(init_point_file_path) %>%
    separate(expr,into=c("type","strength"),sep="_") %>%
    mutate(time = time * 1e-9,
           strength = paste("strength =",strength))
  init_plot <- d %>%
    group_by(type,strength,inits) %>%
    summarize(time  = mean(time)) %>%
    ggplot(aes(x = inits,y = time)) +
    geom_point()+ geom_line()+
    facet_wrap(~strength+type,nrow=3,scale="free_y")+
    scale_x_continuous(breaks = seq(5,50,by=20),
                       labels = seq(5,50,by=20))+
    labs(x = "Number of initial points",y = "Mean time in seconds",
         title = "Mean time in seconds taken to generate 10 replicates w.r.t number of initial points used",
         subtitle = "Mean time  based on 10 replicates of 50 points generated with 5 initial points")
  ggsave(here("experiment","computation_time_experiment","results",
              "init_point_plot.jpg"),plot = init_plot,
         device = "jpg",width = 11,height = 8,units = "in",dpi = 300)
}
