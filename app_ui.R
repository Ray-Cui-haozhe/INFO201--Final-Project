
# Intro page components ---------------------------------------------------
intro_page <- tabPanel(
  "Project Overview",
  sidebarPanel(
  tags$h1("Relationship between Education inequaility"),
  tags$p("This interactive application is made to explore the relationship
         between education and income. Our application is intended for anyone who
         might be interested in seeing how the eudcational factors influence the 
         people and countries' income"),
  tags$br(),
  h3("BACKGROUD | What is Education inequaility?"),
  p("Educational inequality is the unequal distribution of academic resources, 
  including but not limited to; school funding, qualified and experienced teachers, books, and technologies to socially excluded communities. 
    These communities tend to be historically disadvantaged and oppressed. More times than not, individuals belonging to 
    these marginalized groups are also denied access to the schools with abundant resources. 
    Inequality leads to major differences in the educational success or efficiency of these individuals and ultimately suppresses social and economic mobility."),
  h3("RESEARCH QUESTION | Questions to Consider"),
  p("The", strong("overarching research question"), "for this project is:"),
  tags$ul(
    tags$li("What's the correlation between GDP/captia and education level"),
    tags$li("What other socialeconomic factors (e.g. democracies) might affect education?"),
    tags$li("How does education level affect earnings?")
  ),
  h3("OUR PROJECT | GOALS AND Why We Care"),
  
  h3("THE DATA | Global Terrorism Dataset"),
  p("We used in total of three "),
  p("This project focuses on data from 2000 to  2017. From this 
          subset, 111,856 entries were recorded. The main features of interest include the 
          country in which the attack occurred, the type of attack that was used (i.e.
          bombing, hostage, kidnapping), the number of deaths from that attack, and the 
          number of people injured by the attack."),
  h3("Our Team"),
  p(strong("Team Member:"), "Angel Zhou, Haozhe(Ray) Cui, Chihan Gao"),
  p(strong("Class:"), "Info-201: Technical Foundations of Informatics"),
  p("The Information School, University of Washington"),
  p("Winter 2021")
  
  
),

  mainPanel(
    img(src = "https://cdn1.i-scmp.com/sites/default/files/images/methode/2018/01/19/f3008204-fcf9-11e7-b2f7-03450b80c791_image_hires_173553.jpg",
        width = "95%", height = "95%"),
    p(""),
    img(src = "https://www.itseducation.asia/assets/images/article-images/e0c57_photo-1473649085228-583485e6e4d7.jpg",
        width = "95%", height = "95%"),
    p(""),
    img(src = "https://mk0digitallearn7ttjx.kinstacdn.com/wp-content/uploads/2015/03/Education-inequality.pix_.jpg",
        width = "95%", height = "95%"),
  )
)


# Page 1 component --------------------------------------------------------
country_input <- selectInput(
  inputId = "country_1",
  choices = unique(education_earnings$Country),
  label = "Choose a country of interest"
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
  choices = c("Below College" = "1", "College"= "2","Bechelor" = "3","Master" = "4","Doctor" = "5")
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
  theme = shinytheme("superhero"),
  "Education Statistics Analysis",
  intro_page,
  interactive_page1,
  interactive_page2,
  interactive_page3,
  summary_page
)