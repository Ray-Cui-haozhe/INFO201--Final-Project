library(tidyverse)
income <- read.csv("combined_final_last_10_years.csv")

most_recent <- filter(income, year == 2016)

chart3 = ggplot(data = most_recent, aes(x = continent,
                                 y = income_per_person,fill = continent)) +
  geom_boxplot(alpha = 0.9) +
  labs(x = "year", 
       y = "income per person",
       title ="income per person for each continents in 2016") +
  scale_color_brewer(palette = "Set1") 

