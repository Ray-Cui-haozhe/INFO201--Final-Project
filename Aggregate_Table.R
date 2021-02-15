# This file contains the script for creating an aggregate table

library(tidyverse)
df <- read.csv("combined_final_last_10_years.csv")

# Table -------------------------
value <- df %>%
  group_by(continent) %>%
  select(c("demox_eiu", "income_per_person", "gini_index")) %>%
  summarise(democracy_index = mean(demox_eiu),
            income_per_person = mean(income_per_person),
            gini_index = mean(gini_index))
value <- value[order(value$gini_index),]
