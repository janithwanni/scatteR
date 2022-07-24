library(tidyverse)
library(here)

df <- read_csv(here("experiment","generation_accuracy_experiment","table.csv")) %>% select(-1)
# df <- read_csv(here("experiment","experiment_results.csv"))

df %>%
  ggplot(aes(x = measurement_type,y = measurement_value),color="white") +
  geom_tile(aes(fill = rmse)) +
  geom_text(aes(label = round(rmse,3)),color = "white",size = 4) +
  theme_minimal() +
  labs(title = "Experiment results of scatteR",subtitle = "RMSE calculated using 20 replicates of 50 points generated using 5 initial points",x = "Scagnostic measurement type",y = "Expected Measurement value",fill = "RMSE") +
  theme(legend.position = "bottom")
ggsave(here("experiment","rmse_plot_experiment.eps"),device = "eps",
       width = 6,height = 4,units = "in",dpi = 300)

df %>%
  ggplot(aes(x = measurement_type,y = measurement_value),color="white") +
  geom_tile(aes(fill = mae)) +
  geom_text(aes(label = round(mae,3)),color = "white",size = 4) +
  theme_minimal() +
  labs(title = "Experiment results of scatteR",subtitle = "MAE calculated using 20 replicates of 50 points generated using 5 initial points",x = "Scagnostic measurement type",y = "Expected Measurement value",fill = "MAE") +
  theme(legend.position = "bottom")
ggsave(here("experiment","mae_plot_experiment.jpg"),device = "jpg",bg="white",
       width = 1920,height = 1080,units = "px",dpi = 300)
