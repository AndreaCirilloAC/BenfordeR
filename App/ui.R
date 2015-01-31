
#### BENFORDER USER INTERFACE ####

library(shiny)

shinyUI(fluidPage(
  
  tags$head(
    tags$style(HTML("
                    @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
                    "))
    ),
  # Application logo and title
  br(),
  fluidRow(
    column(1,img(src = "logo.png", height = 70, width = 70)),
    column(11,h1("BenfordeR", style = "font-family: 'Helvetica Neue', cursive;
                 font-weight: 500; line-height: 1.1; 
                 color: #55ACEE;"))),
  br(),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(width=3,
                 h3("instructions"),
                 
                 p ("BenfordeR is a lean shiny app that let's you test Benford's Law against a custom
                    population you can load using the 'load file' control below."),
                 p ("Moreover, Benforder lets' you decide how many leading digits you want to test 
                    in your popoulation, changing the output accordingly"),
                 p ("BenfordeR gives as an output a grapghic representation of the compliance to the law,
                    a detail of first digits more far from the law
                    and a detail of records having those digits as leading digits"),
                 br(),
                 h6("find out more on the Benford's Law and this app on"),
                 
                 HTML("<a href='https://andreacirilloblog.wordpress.com/' style='color:    #55ACEE'
        target='_blank'>[andreacirillo's blog]</a>"),                
                br(),
        #file input widget to let user load his own data set
        
                 fileInput("records", h4("load file"),
                           multiple = FALSE),                 
                 h5("At the moment BenfordeR supports only one-column .csv 
                    dataset. thanks for understanding :)", style = "color:#DC143C"),
                 numericInput("digits",h4("number of digits to test"),1)
    ),
        
    mainPanel(
      #multi panel plot with results from the benford analysis.
      h3("benford analysis results"),
      plotOutput("benford_plot",width= "100%"),
      # first free digits from the analysis, ordere by absolute difference
      h3("leading digits with greater absolute differences ( first 3)"),
      dataTableOutput("benford_table"),
      # records associated to the above-mentioned digits
      h3("records with leading digits not complying with Benford's Law"),
      dataTableOutput("benford_suspect")
      
      
    )
  )
    ))
