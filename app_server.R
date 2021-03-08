
# Read data and library ---------------------------------------------------
library(tidyverse)
library(shiny)
library(ggplot2)
library(plotly)

ed_stats <- read.csv("EdStatsData.csv")
income_inequality <- read.csv("combined_final_last_10_years.csv")
income_education <- read.csv("WA_Fn-UseC_-HR-Employee-Attrition.csv")
source("qqnormsim.R")

education_earnings <- read.csv("EAG_EARNINGS.csv") %>%
  filter(Gender == "Total") %>%
  select(Country, ISC11A.1, EARN_CATEGORY.1, Unit, Reference.Period,Value) %>%
  rename(Education_level = ISC11A.1,Earning_category = EARN_CATEGORY.1, year = Reference.Period)

education_earnings[education_earnings == "Below upper secondary education"] <- "Below_secondary_education"
education_earnings[education_earnings == "Upper secondary or post-secondary non-tertiary education"] <- "upper_secondary_education"
education_earnings[education_earnings == "Bachelor’s or equivalent education"] <- "Bachelor"
education_earnings[education_earnings == "Master’s, Doctoral or equivalent education"] <- "Master_Doctoral"
education_earnings[education_earnings == "Tertiary education"] <- "Tertiary_education"
education_earnings[education_earnings == "Short-cycle tertiary education"] <- "Short_cycle_tertiary_education"

education_earnings[is.na(education_earnings)] <- 0

# # Extract net_enrollment_rate for male, female, both sexes, and the
# # gender parity index for countries with available data
 net_enrollment_rate <- ed_stats %>%
  filter(Indicator.Code == c("SE.PRM.TENR",
                    "SE.PRM.TENR.FE",
                    "UIS.NERA.1.GPI",
                    "SE.PRM.TENR.MA"))
 net_enrollment_rate$Indicator.Code <- NULL
 net_enrollment_rate <- net_enrollment_rate %>%
  pivot_longer(cols = starts_with("X"),
                names_to = "Year",
                names_prefix = "X",
                values_to = "Rate",
               values_drop_na = TRUE)
 net_enrollment_rate <- net_enrollment_rate %>%
   pivot_wider(names_from = Indicator.Name,
               values_from = Rate)
 net_enrollment_rate$Year <- as.integer(net_enrollment_rate$Year)
 net_enrollment_rate <- rename(net_enrollment_rate,
                              "Both_sexes" = "Adjusted net enrolment rate, primary, both sexes (%)",
                               "Female" = "Adjusted net enrolment rate, primary, female (%)",
                               "GPI" = "Adjusted net enrolment rate, primary, gender parity index (GPI)",
                              "Male" = "Adjusted net enrolment rate, primary, male (%)")


# Join `net_enrollment_rate` with `income_inequality`
 combined_df <- net_enrollment_rate %>%
  inner_join(income_inequality, by = c("Country.Name" = "country", "Year" = "year"))






server <- function(input, output) {

# Question 1 --------------------------------------------------------------
  output$scatter <- renderPlotly({
    edu_gdp <- education_earnings %>%
      filter(Country == input$country_1 & year == 2018 & Earning_category == input$capita)
    
    my_plot <- ggplot(data = edu_gdp) +
      geom_histogram(mapping = aes_string(x = "Education_level" , y = "Value"), 
                     color = input$color, fill = input$color, stat = "identity")+
      labs(title = "Education and Earning for each education level" , x = "Education Level", y = "Percentage of People in the education level, percentage")+
      coord_flip()
    # my_plot <- my_plot + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
    ggplotly(my_plot) 
  }
  )


# Question 2 --------------------------------------------------------------
# What other socialeconomic factors (e.g. democracies) might affect education?
  output$time_chart <- renderPlot({
    ggplot(data = combined_df %>% filter(Country.Name == input$country)) +
      geom_point(mapping = aes(x = Year , y = Both_sexes))
  })

  output$correlation <- renderPlot({
    ggplot(data = combined_df %>% filter(Country.Name == input$country)) +
      geom_point(mapping = aes_string(x = "Both_sexes" , y = input$factor))
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
