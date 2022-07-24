library(scatteR)
library(tidyverse)
library(palmerpenguins)
theme_set(theme_minimal())

synth_data <- function(data,x_column,y_column){
  # TODO Complete this
}

# sample outputs ----------------------------------------------------------


scatteR(c("Skinny" = 0.8),n_points = 10,verbose=FALSE) %>%
  ggplot(aes(x = x,y = y)) +
  geom_points()


# palmer penguins plot generation -----------------------------------------


generated <- scatteR(scagnostics(penguins$bill_length_mm,
                                 penguins$bill_depth_mm),
                     n_points = length(penguins$bill_length_mm),verbose=FALSE)
penguins %>%
  select(bill_length_mm,bill_depth_mm) %>%
  drop_na() %>%
  rename(x = bill_length_mm,y = bill_depth_mm) %>%
  mutate(x = (x - min(x)) / (max(x) - min(x)),
         y = (y - min(y)) / (max(y) - min(y)),
         source = "penguins") %>%
  bind_rows(generated %>% mutate(source = "generated")) %>%
  ggplot(aes(x = x,y = y,color=source))+
  geom_point()+
  theme_minimal()+
  theme(legend.position = "bottom")

