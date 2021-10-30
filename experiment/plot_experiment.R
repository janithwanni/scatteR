library(tidyverse)
library(here)

df <- read_csv(here("experiment","table.csv")) %>% select(-1)
# df <- read_csv(here("experiment","experiment_results.csv"))

df %>%
  ggplot(aes(x = measurement_type,y = measurement_value),color="white") +
  geom_tile(aes(fill = rmse)) +
  geom_text(aes(label = round(rmse,4)),color = "white",size = 4) +
  theme_minimal()
