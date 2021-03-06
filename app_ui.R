
# Intro page components ---------------------------------------------------
intro_page <- tabPanel(
  "Introduction",
  titlePanel("Introduction")
)


# Page 1 component --------------------------------------------------------
interactive_page1 <- tabPanel(
  "Interactive page 1"
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
interactive_page3 <- tabPanel(
  "Interactive page 3"
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