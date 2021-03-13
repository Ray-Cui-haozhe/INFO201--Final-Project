
# Read data and library ---------------------------------------------------
library(tidyverse)
library(shiny)
library(ggplot2)
library(plotly)
library(shinythemes)


ed_earning <- read.csv("EAG_EARNINGS.csv", encoding="UTF-8")
ed_stats <- read.csv("EdStatsData.csv")
income_inequality <- read.csv("combined_final_last_10_years.csv")
income_education <- read.csv("WA_Fn-UseC_-HR-Employee-Attrition.csv")
source("qqnormsim.R")

education_earnings <- ed_earning %>%
  filter(Gender == "Total") %>%
  select(Country, ISC11A.1, EARN_CATEGORY.1, Unit, Reference.Period,Value) %>%
  rename(Education_level = ISC11A.1,Earning_category = EARN_CATEGORY.1, year = Reference.Period)

education_earnings[education_earnings == "Below upper secondary education"] <- "Below_secondary_education"
education_earnings[education_earnings == "Upper secondary or post-secondary non-tertiary education"] <- "upper_secondary_education"
education_earnings[education_earnings == "Bachelor's or equivalent education"] <- "Bachelor"
education_earnings[education_earnings == "Master's, Doctoral or equivalent education"] <- "Master_Doctoral"
education_earnings[education_earnings == "Tertiary education"] <- "Tertiary_education"
education_earnings[education_earnings == "Short-cycle tertiary education"] <- "Short_cycle_tertiary_education"

education_earnings[is.na(education_earnings)] <- 0

# # Extract net_enrollment_rate for male, female, both sexes, and the
# # gender parity index for countries with available data
net_enrollment_rate <- ed_stats %>%
  filter(Indicator.Code == "BAR.NOED.15UP.ZS"|
           Indicator.Code == "BAR.NOED.25UP.ZS"|
           Indicator.Code == "BAR.NOED.75UP.ZS")
net_enrollment_rate$Indicator.Name <- NULL
net_enrollment_rate <- net_enrollment_rate %>%
  pivot_longer(cols = starts_with("X"),
               names_to = "Year",
               names_prefix = "X",
               values_to = "Rate",
               values_drop_na = TRUE)
net_enrollment_rate <- net_enrollment_rate %>%
  pivot_wider(names_from = Indicator.Code,
              values_from = Rate)
net_enrollment_rate$Year <- as.integer(net_enrollment_rate$Year)
net_enrollment_rate <- rename(net_enrollment_rate,
                              "Age 15-24" = "BAR.NOED.15UP.ZS",
                              "Age 25-74" = "BAR.NOED.25UP.ZS",
                              "Age 75+" = "BAR.NOED.75UP.ZS")


# Join `net_enrollment_rate` with `income_inequality`
combined_df <- net_enrollment_rate %>%
  left_join(income_inequality, by = c("Country.Name" = "country", "Year" = "year"))

combined_df <- rename(combined_df,
                      "Democracy index" = "demox_eiu",
                      "Income per person" = "income_per_person",
                      "Invest GDP" = "invest_._gdp",
                      "Tax GDP" = "tax_._gdp",
                      "Gini index" = "gini_index")




server <- function(input, output) {

# Question 1 --------------------------------------------------------------
  output$scatter <- renderPlotly({
    edu_gdp <- education_earnings %>%
      filter(Country == input$country_1 & year == 2018 & Earning_category == input$capita)
    
    my_plot <- ggplot(data = edu_gdp) +
      geom_histogram(mapping = aes_string(x = "Education_level" , y = "Value"), 
                     color = "royalblue3", fill = "royalblue3", stat = "identity")+
      labs(title = "Education and Earning for each education level" , x = "Education Level", y = "Percentage of People in the education level, percentage")+
      coord_flip()
    # my_plot <- my_plot + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
    ggplotly(my_plot) 
  }
  )


# Question 2 --------------------------------------------------------------
  # What other socialeconomic factors (e.g. democracies) might affect education?
  
  output$time_chart <- renderPlot({
    df <-  combined_df %>% filter(Country.Name == input$country)
    ggplot(data = df) +
      geom_line(mapping = aes_string(x = "Year" , y = df[[input$age]])) +
      geom_point(mapping = aes_string(x = "Year" , y = df[[input$age]])) +
      labs(y = "No Education Rate", title = "No Education Rate Over Time")
  })
  
  output$correlation <- renderPlot({
    linear_model <- lm(combined_df[[input$age]] ~ combined_df[[input$factor]])
    ggplot(data = combined_df) +
      geom_point(mapping = aes_string(y = combined_df[[input$age]] , x = combined_df[[input$factor]])) +
      geom_abline(slope = coef(linear_model)[[2]], intercept = coef(linear_model)[[1]]) +
      labs(title = "Correlation of No Education Rate with Socialeconomic Factor", y = "No Education Rate", x = input$factor)
  })

# Question 3 --------------------------------------------------------------
  output$distribution <- renderPlot({
    income_variable <- income_education %>%
      filter(EducationField == input$field & Education == input$education)
    
    income_mean <- mean(income_education$MonthlyIncome)
    income_sd <- sd(income_education$MonthlyIncome)
    
    
    ggplot(data = income_variable, aes(x = MonthlyIncome)) +
      geom_blank() +
      geom_histogram(binwidth = 100, aes(y = ..density..)) +
      stat_function(fun = dnorm, args = c(mean = income_mean, sd = income_sd), col = "tomato")
    
  })
  
  output$QQplot <- renderPlot({
    income_variable <- income_education %>%
      filter(EducationField == input$field & Education == input$education)
    
    qqnormsim(sample = MonthlyIncome, data = income_variable)
  })
  
}
