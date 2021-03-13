
# Intro page components ---------------------------------------------------
intro_page <- tabPanel(
  strong("Project Overview"),
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
    p("As International students, we are extremely lucky and we cherish the opportunity to study aboard. 
    But lots of people in the world still don't have such opportunities and resources as we do. 
    So we want to investigate the factors that might affect their right of being educated, 
    as well as the benefits of being educated."),
    
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
    h3("Household Earning For Each Education Level"),
    h3("Question:"),
    p(""),
    tags$li("What's the correlation between GDP/captia and education level"),
    p(""),
    p("In this page, we want to explore the relationship between education level and
    GDP/capita through a symbolic factor: medium household earnings. We can choose
    a country and the household earning to see the corresponding representation. To explain, 
    each column represents the percentage of people who holds the education degree
    that has the chosen income level"),
    p(""),
    country_input,
    capita_input,
  ),
  
  mainPanel(
    plotlyOutput(outputId = "scatter"),
  )
)

interactive_page1 <- tabPanel(
  strong("Education and GDP"),
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
    h2("NO EDUCATION RATE OVER TIME"),
    p("Select a country of interest from the drop down menu and an age
      range in order to observe the trend of No Education Rate for a
      country of interest and an age group over time."),
    country_input,
    age_input
  ),
  mainPanel(
    plotlyOutput(outputId = "time_chart"),
  ))

layout_2a <- sidebarLayout(
  sidebarPanel(
    h2("NO EDUCATION RATE VS. SOCIAL ECONOMIC FACTOR"),
    p("Choose a factor that you want to investigate to find an overall
      correlation between No Education Rate for the chosen social economic
      factor."),
    factor_input
  ),
  mainPanel(
    plotlyOutput (outputId = "correlation")
  ))

interactive_page2 <- tabPanel(
  strong("Trend of No Education Rate"),
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
    h3("Question"),
    tags$li("what the distribution between people's educational level and monthly income in differernt areas?"),
    tags$li("It is demonstrate the normal distribution?"),
    education_input,
    field_input
  ),
  mainPanel(
    plotOutput(outputId = "distribution"),
    plotOutput(outputId = "QQplot")
  ))


interactive_page3 <- tabPanel(
  strong("Education and Income"),
  layout_3
)

# Summary page component --------------------------------------------------------
conclusion_1 <- sidebarLayout(
  sidebarPanel(
    h3("Takeaway: Education and GDP"),
    p("In the three questions we published on GitHub, we try to explore 
    the topic of education inequality,especially in the area of the economy. 
    Our first approach is the relationship between GDP and Education. 
    In the graphical representation,we clearly see that with a higher level of income, 
    people tend to hold a higher education degree. We can interpret based on this. 
    With a low education degree, without the equivalent knowledge, 
    people cannot apply for a high-income job. Without a  high-income job, 
    he/she cannot afford tertiary education, and so on. To sum up, education level
    is proportional to GDP/capita"),
    p(""),
    p(""),
    h3("Takeaway: Trend of No Education Rate"),
    p("By observing the No Education Rate over Time, luckily we are seeing
    an overall decreasing pattern for most, if not all countries in the world,
    meaning that in general, there are more available educational resources
    for more people to gain access to education. However, we also see a
    decreasing rate of change, so we might be facing a bottleneck period
    where most available resources were already distributed or it might be
    harder to spread the resouces further into the communities. When we explore
    the correlation of No Education Rate between various socialeconomic
    factors. Not surprisingly, Democracy and Income per Person have a pretty
    strong negative correlation with No Education Rate, meaning that a higher
    democracy index and a higher Income per person would lead to more people
    having access to education. And the Gini Index, a measure of income
    inequality, has a strong correlation with No Education Rate, meaning that
    the larger the income gap is, the more people with no access to education.
    This might be a train of thought for eliminating illiteracy, that we
    could probably take the first step to reduce the income gap."),
    
    h3("Education and Income"),
    p("Finally, we want to explore whether the relationship between people's monthly income and educational level
      demonstrate the normal distribution. There are two plots to show that. The first layer of the above plot is a density histogram. 
      The second layer is a statistical function – the density of the normal curve, dnorm.
      We specify that we want the curve to have the same mean and standard deviation as the column of monthly income to show the trend 
      of normal distribution. For the second plot, we make function to make seven single plots generated from a normal distribution
      to compare the real data plot's trend (top left corner). We use stat_qq_line() which add in function to add a diagonal reference line to the plot, 
      which shows us where our points would fall if the data were perfectly normal. In short, the points more close to the black line, meaning the plot more
      close to the normal distribution. As we found, the overall trend of people's monthly income is left skewed, but for the higher educational level,
      more percentage of people get higher income."),
  ),
  mainPanel(
    img(src = "https://webfoundation.org/docs/2017/02/WF_Strategy_Cover.jpg",
        width = "95%", height = "95%"),
    img(src = "https://centreforglobalequality.org/wp-content/uploads/2015/09/global-citizen-e1454664343282.jpg",
        width = "95%", height = "95%"),
  )
)


summary_page <- tabPanel(
  strong("Conclusion"),
  conclusion_1
)



ui <- navbarPage(
  theme = shinytheme("superhero"),
  strong("Education Statistics Analysis"),
  intro_page,
  interactive_page1,
  interactive_page2,
  interactive_page3,
  summary_page
)