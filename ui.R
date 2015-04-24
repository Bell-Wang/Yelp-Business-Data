shinyUI(
  fluidPage(theme = "bootstrap.css",
  navbarPage("Yelp!",
             tabPanel("Hello",
                      fluidRow(
                        column(8,
                               includeMarkdown("Intro.Rmd"),
                               br(),
                               a("CartoDB maps", class = "btn btn-primary btn-md", 
                                 href = "https://lin-he.cartodb.com/viz/caa35c06-e6f3-11e4-81e9-0e853d047bba/embed_map"),
                               a("See Code", class = "btn btn-primary btn-md", 
                                 href = "https://lin-he.cartodb.com/api/v2/viz/bccf7b94-e6fa-11e4-ae4b-0e9d821ea90d/viz.json"),
                               a("See Code", class = "btn btn-primary btn-md", 
                                 href = "https://lin-he.cartodb.com/api/v2/viz/caa35c06-e6f3-11e4-81e9-0e853d047bba/viz.json") 
                        ),
                        column(2,
                               img(src='yelp.png',height=400,width=400)
                        ))),        
             tabPanel("Dataset Sample-Buz",
                      h3("Business Dataset"),
                      dataTableOutput("table")),
             tabPanel("Stars and Reviews",
                      pageWithSidebar(
    headerPanel("Count Stars & Reviews"),
    sidebarPanel(   
      img(src='yelp-5-star.png',height=50,width=170),
      sliderInput("Stars",
                  label=h4("Stars:"),
                  min=1,max=5,value=1,step=0.5,animate=animationOptions(interval=2000,loop=TRUE,playButton="play",pauseButton="pause")),

      wellPanel(
      selectInput("Factors", h4("Factors:"),
                  c("Price_Range","TV","Noise","WiFi","Happy_Hour")
      ),
    
      radioButtons("BarPlotType", label = h4("PlotType:"),
                   choices = list("dodge", "stack"),selected ="dodge"),     
    
      p("Firstly, We'd like to compare how stars are rated across the cities:",
        strong("Champaign",style="color:orange"),
        strong("Charlotte",style="color:green"),
        strong("Las Vegas",style="color:blue")),
      div("and how the stars are rated with different factors, such as",
        strong("Noise Level, TV, WiFi, Price Range, Happy Hour", style = "color:purple"))
      ),
      
      wellPanel(
        p("Then, all the restaurants data were collected:",strong("21,892 observations across 265 cities.",style="color:red"),
          div("From the charts, we are able to check the most popular restaurant (according to reviews counts and stars).")),
        
      textInput("review_count", label = h4("Review Top#"), 
                value = "10"),
      
      radioButtons("city", label = h4("Want to check the stars counts with the cities?"),
                   choices = list("no", "yes"),selected ="no"),
      br(),
      br(),
      img(src = "yelp.png", height = 100, width = 100),
      br(),
      br(),
      helpText("Yelp Reviews and Stars by Bella Y Wang")
      )),
      mainPanel(       
        tabsetPanel(
          tabPanel("Stars with Factors",
                   h3(textOutput("caption")),
                   plotOutput("starsPlot"),  
                   br(),
                  h3("Data Table"),
                  dataTableOutput('view')),
          tabPanel("Review Counts",
                   h3("Number of Reviews"),
                   splitLayout(
                     cellWidths=c("50%","50%"), 
                     plotOutput("reviewPlot"),
                     plotOutput("reviewPlot1")),
                   dataTableOutput('view2')),
          
          tabPanel("Restaurant's Stars",
                   h3("Top Restaurants by Stars Levels"),
                   dataTableOutput('view_stars')),          
          tabPanel("Restaurant's Review",
                   h3("Restaurant's Review Number"),
                   dataTableOutput('view_rest')
                   ),
          tabPanel("Summary",
                   h3("Stars Distribution"),
                   plotOutput('stars_p'),
                   verbatimTextOutput("summary_s"),
                   h3("Reviews Distribution"),
                   plotOutput("reviews_p"),
                   verbatimTextOutput("summary_r")
          )
          )))),
    
    
    
    tabPanel("Reviews-LDA",
             fluidRow(
               column(3,
                      includeMarkdown("C.Rmd")),
               column(1,
                      img(src='yelp.png',height =300, width =300)
                      ,
                      a("See Code", class = "btn btn-primary btn-md", 
                        href = "https://github.com/YuTian9/DV_Dine/blob/master/Presentation_Claire%26Junfei.md")      
               ))),
    tabPanel("Overall/Ego Network and Hierarchical Clustering",
             fluidRow(
               column(8,
                      includeMarkdown("Yu.Rmd")),
               column(2,
                      img(src='yelp.png',height =400, width =400)
                        ,
                      a("See Code", class = "btn btn-primary btn-md", 
                        href = "https://github.com/YuTian9/DV_NYDine/tree/master/scripts")      
                      )))
     
)))
