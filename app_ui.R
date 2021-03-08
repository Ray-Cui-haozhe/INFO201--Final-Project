library(shiny)
library(ggplot2)
library(plotly)
library(tidyverse)

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


# Intro page components ---------------------------------------------------
intro_page <- tabPanel(
  "Introduction",
  titlePanel("Introduction")
)


# Page 1 component --------------------------------------------------------
country_input <- selectInput(
  inputId = "country",
  choices = unique(education_earnings$Country),
  label = "Choose a country of interest"
)

color_input <- selectInput(
  inputId = "color", 
  choices = c("red", "blue", "purple"), 
  label = "Choose a color"
)

capita_input <- selectInput(
  inputId = "capita",
  label = "Choose the level of income",
  choices = c("At or below 1/2 of the median", "More than 1/2 the median but at or below the median",
              "More than the median but at or below 1.5 times the median",
              "More than 1.5 times the median but at or below 2.0 times the median",
              "More than 2.0 times the median")
)

layout <- sidebarLayout(
  sidebarPanel(
    country_input,
    capita_input,
    color_input
  ),
  
  mainPanel(
    plotlyOutput(outputId = "scatter")
  )
)

interactive_page1 <- tabPanel(
  "Interactive page 1",
  layout
)


# Page 2 component --------------------------------------------------------
country_input <- selectInput(
  inputId = "country",
  choices = unique(combined_df$Country.Name),
  label = "Choose a country of interest"
)

factor_input <- radioButtons(
  inputId = "factor",
  choices = c("Democracy index", "Income per person", "Invest GDP", "Tax GDP", "Gini index"),
  label = "Choose a variable of interest"
)

layout <- sidebarLayout(
  sidebarPanel(
    country_input,
    factor_input
  ),
  mainPanel(
    plotOutput(outputId = "time_chart")
    #plotOutput(outputId = "correlation")
  ))

interactive_page2 <- tabPanel(
  "Interactive page 2",
  layout
)


# Page 3 component --------------------------------------------------------

education_input <- radioButtons(
  inputId = "education",
  label = "Choose a variable of the educational level",
  choices = c("1", "2","3","4","5")
)

field_input <- radioButtons(
  inputId = "field",
  label = "Choose a varaible of interest",
  choices = c("Life Sciences", "Medical","Technical Degree", "Other")
  
)

layout_1 <- sidebarLayout(
  sidebarPanel(
    education_input,
    field_input
  ),
  mainPanel(
    plotOutput(outputId = "distribution"),
    plotOutput(outputId = "QQplot")
  )
)


interactive_page3 <- tabPanel(
  "Interactive page 3",
  layout_1
  
)


# Summary page component --------------------------------------------------------
summary_page <- tabPanel(
  "Summary"
)



ui <- navbarPage(
  "Education Statistics Analysis",
  intro_page,
  interactive_page1,
  interactive_page2,
  interactive_page3,
  summary_page
)