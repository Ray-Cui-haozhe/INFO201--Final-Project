library(tidyverse)
income_equality <- read.csv("combined_final_last_10_years.csv")

demox_mean <-mean(income_equality$demox_eiu)
demox_sd <- sd(income_equality$demox_eiu)


ggplot(data = income_equality, aes(x = demox_eiu)) +
  geom_blank() +
  geom_histogram(binwidth = 5, aes(y = ..density..)) +
  stat_function(fun = dnorm, args = c(mean = demox_mean, sd = demox_median), 
                col = "tomato")