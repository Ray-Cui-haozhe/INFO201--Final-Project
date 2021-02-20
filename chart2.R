library(tidyverse)
income_equality <- read.csv("combined_final_last_10_years.csv")

demox_mean <-mean(income_equality$demox_eiu)
demox_sd <- sd(income_equality$demox_eiu)


chart2 <- ggplot(data = income_equality, aes(x = demox_eiu)) +
  geom_blank() +
  geom_histogram(binwidth = 5, aes(y = ..density..)) +
  stat_function(fun = dnorm, args = c(mean = demox_mean, sd = demox_sd), 
                col = "tomato") +
  labs(x = "demoncracy index", title = "Demoncracy index by continent over years")

  
