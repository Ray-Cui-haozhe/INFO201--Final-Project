
# Read data and library ---------------------------------------------------
library(tidyverse)

ed_stats <- read.csv("EdStatsData.csv")
income_inequality <- read.csv("combined_final_last_10_years.csv")

# Extract net_enrollment_rate for male, female, both sexes, and the
# gender parity index for countries with available data
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

  
}