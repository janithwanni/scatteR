library(tidyverse)
library(here)

df <- read_csv(here("experiment","table.csv")) %>% select(-1)
# df <- read_csv(here("experiment","experiment_results.csv"))

df %>%
  ggplot(aes(x = measurement_type,y = measurement_value),color="white") +
  geom_tile(aes(fill = rmse)) +
  geom_text(aes(label = round(rmse,4)),color = "white",size = 4) +
  theme_minimal() +
  labs(title = "Experiment results of scatteR",subtitle = "Root Mean Square Error calculated using 20 replicates of 50 points generated using 5 initial points within 3 hours",x = "Scagnostic measurement type",y = "Expected Measurement value",fill = "RMSE") +
  theme(legend.position = "bottom")
