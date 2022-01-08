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
    geom_label(aes(label = round(time,1)),size=2.125,label.padding = unit(0.125,"lines"))+
    facet_wrap(~type,nrow = 3,scales = "free_y") +
  labs(x = "Measurement strength",y = "Mean time in seconds",
       title = "Mean time in seconds taken to generate 10 replicates",
       subtitle = "Mean time  based on 10 replicates of 50 points generated with 5 initial points")
ggsave(here("experiment","computation_time_experiment","results",
            "scag_type_value_plot.eps"),plot = scag_type_value_plot,
       device = "eps",width = 6,height = 6,units = "in",dpi = 150)
}

init_point_file_path <- here("experiment",
                             "computation_time_experiment","results",
                             "init_point_experiment.csv")

if(file.exists(init_point_file_path)){
  d <- read_csv(init_point_file_path) %>%
    separate(expr,into=c("type","strength"),sep="_") %>%
    mutate(time = time * 1e-9,
           strength = factor(paste("strength =",strength),
                             levels = paste("strength =",c(0,0.5,1))))
  init_plot <- d %>%
    group_by(type,strength,inits) %>%
    summarize(time  = mean(time)) %>%
    ggplot(aes(x = inits,y = time,color=strength)) +
    geom_point()+ geom_line()+
    facet_wrap(~type,ncol=3,scale="free_y")+
    scale_x_continuous(breaks = seq(5,50,by=20),
                       labels = seq(5,50,by=20))+
    scale_color_manual(values = nic::nic_palette("buttercup_8",n = 3))+
    labs(x = "Number of initial points",y = "Mean time in seconds",
         title = "Mean time in seconds taken to generate 10 replicates w.r.t number of initial points used",
         subtitle = "Mean time  based on 10 replicates of 50 points generated with 5 initial points",color = "Measurement strength")+
    theme(legend.position = "bottom")
  ggsave(here("experiment","computation_time_experiment","results",
              "init_point_plot.eps"),plot = init_plot,
         device = "eps",width = 6,height = 6,units = "in",dpi = 150)
}
