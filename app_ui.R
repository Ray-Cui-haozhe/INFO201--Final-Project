
# Intro page components ---------------------------------------------------
intro_page <- tabPanel(
  "Introduction",
  titlePanel("Introduction")
)


# Page 1 component --------------------------------------------------------
country_input <- selectInput(
  inputId = "country_1",
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

layout_1 <- sidebarLayout(
  sidebarPanel(
    country_input,
    capita_input,
    color_input
  ),
  
  mainPanel(
    plotlyOutput(outputId = "scatter"),
    
    "
    
    Question one asks about the relationship between GPA capita and education level, therefore 
    using median household income as our standard to categorize level of income for each country 
    would be our approach. The plot above shows the percentage of people with the chosen level of 
    level of income about their education level.Some information is missing due to missing data. 
    However, if we increase the level of income, we will see that tertiary education level, Bachelor
    and Master degree are the major parties. If the level of income is low, people who has educaiton
    degree below secondary education has the highest percentage. This plot can show the relationship
    between education level and household capita"
  )
)

interactive_page1 <- tabPanel(
  "Education_GDP",
  layout_1
)


# Page 2 component --------------------------------------------------------
country_input <- selectInput(
  inputId = "country",
  choices = unique(combined_df$Country.Name),
  label = "Choose a country of interest"
)

factor_input <- radioButtons(
  inputId = "factor",
  choices = colnames(combined_df)[8:12],
  label = "Choose a social economic factor of interest"
)

age_input <- radioButtons(
  inputId = "age",
  choices = colnames(combined_df)[4:6],
  label = "Choose an age range"
)

layout_2 <- sidebarLayout(
  sidebarPanel(
    country_input,
    age_input
  ),
  mainPanel(
    plotOutput(outputId = "time_chart"),
  ))

layout_2a <- sidebarLayout(
  sidebarPanel(
    factor_input,
    age_input
  ),
  mainPanel(
    plotOutput (outputId = "correlation")
  ))

interactive_page2 <- tabPanel(
  "Trend of Education Enrollment Rate",
  layout_2,
  layout_2a
)


# Page 3 component --------------------------------------------------------

#
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

layout_3 <- sidebarLayout(
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
  layout_3
)


# Summary page component --------------------------------------------------------
conclusion_1 <- sidebarLayout(
  sidebarPanel(
    h2("Conclusion for Education and GDP"),
  ),
  mainPanel(
    "In the three questions we published on GitHub, we try to explore the topic of education inequality, 
    especially in the area of the economy. Conclusion one will be the sum up for the first question, 
    which is the relationship between GDP and Education. In the graphical representation, 
    we clearly see that with a higher level of income, people tend to hold a higher education degree. 
    We can interpret based on this. With a low education degree, for example below secondary education, 
    people do not have the equivalent knowledge for applying for a job in firms such as Google and Microsoft,
    but these firms tend to have a higher salary than stores such as fast-food restaurants.
    Without the equivalent knowledge, people cannot apply for a high-income job. Without a
    high-income job, he/she cannot afford tertiary education, and so on. To sum up, education level
    is proportional to GDP/capita"
  )
)


summary_page <- tabPanel(
  "Conclusion",
  conclusion_1
)



ui <- navbarPage(
  "Education Statistics Analysis",
   intro_page,
   interactive_page1,
   interactive_page2,
   interactive_page3,
   summary_page
)