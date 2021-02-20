library(tidyverse)
income <- read.csv("combined_final_last_10_years.csv")

per_person_income <- income %>%
  group_by(continent, year) %>% 
  summarise(income_per_person = mean(income_per_person))

chart3 = ggplot(data = per_person_income) +
  geom_line(mapping =  aes(x = year,
                            y = income_per_person, color = continent)) +
  labs(x = "year", 
       y = "mean of income per person",
       title ="mean of income per person for each continents from 2006~2016") +
  scale_color_brewer(palette = "Set1") +
  
  geom_point(mapping =  aes(x = year,
                           y = income_per_person, color = continent))

