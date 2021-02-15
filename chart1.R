# This file contains the script for plotting chart 1

library(tidyverse)
df <- read.csv("combined_final_last_10_years.csv")
value <- df %>%
  group_by(continent, year) %>% 
  summarise(gini_index = mean(gini_index))
chart1 <- ggplot(data = value) +
  geom_point(mapping = aes(y = gini_index, x = year, color = continent)) +
  labs(y = "gini index", title = "Gini index by continent over years")
