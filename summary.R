# Code below will generate summary information of the datasets

library(tidyverse)
library(dplyr)
income <- read.csv("combined_final_last_10_years.csv")

# Summary Information Script

# Because there are more problems related to education in Africa, here we will 
# use Africa and America as the subject we compare and discuss

# We will frist extract rows of continent, year, and income_per_person
africa_america <- filter(income, continent == "Africa" | continent == "Americas")
most_recent <- filter(africa_america, year == 2016)
summary_info <- list(most_recent["continent"], most_recent["year"],most_recent["income_per_person"])

summary_info$num_observations <- nrow(africa_america)

summary_info$median_income_americas <- most_recent %>%
  filter(continent == "Americas") %>%
  select(income_per_person)%>%
  lapply(median)

summary_info$mean_income_americas <- most_recent %>%
  filter(continent == "Americas") %>%
  select(income_per_person)%>%
  lapply(mean)

summary_info$mean_income_africa <- most_recent %>%
  filter(continent == "Africa") %>%
  select(income_per_person)%>%
  lapply(mean)

summary_info$median_income_africa <- most_recent %>%
  filter(continent == "Africa") %>%
  select(income_per_person)%>%
  lapply(median)

america <- filter(most_recent,continent == "Americas")
america_above_10000 <- filter(america, america$income_per_person > 10000)
summary_info$america_above_10000  <- nrow(america_above_10000) / nrow(america)

africa <- filter(most_recent, continent == "Africa")
africa_above_10000 <- filter(africa, africa$income_per_person > 10000)
summary_info$africa_above_10000 <- nrow(africa_above_10000) / nrow(africa)

summary_info <- summary_info[5:10]
summary_info <- data.frame(ID = rep(names(summary_info), sapply(summary_info, length)),
                 Obs = unlist(summary_info))
summary_info[["Obs"]] <- format(summary_info$Obs, scientific = F)
summary_info[["Obs"]] <- round(as.numeric(summary_info[["Obs"]]), digits = 2)
rownames(summary_info) <- summary_info$ID
summary_info <- subset(summary_info, select = -c(ID))
write_csv(summary_info,"summary_info.csv")

