# This file contains the script for creating an aggregate table

library(tidyverse)
df <- read.csv("combined_final_last_10_years.csv")

# Table -------------------------
value <- df %>%
  group_by(continent) %>%
  select(c("demox_eiu", "income_per_person", "gini_index")) %>%
  summarise("Democracy Index" = mean(demox_eiu),
            "Income per Person" = mean(income_per_person),
            "Gini Index" = mean(gini_index))
value <- value[order(value$`Gini Index`),]
