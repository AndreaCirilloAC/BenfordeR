
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

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
                 p("find out more on the Benford's Law and this app on"),
                 HTML("<a href='https://andreacirilloblog.wordpress.com/' style='color:    #55ACEE'
        target='_blank'>[andreacirillo's blog]</a>"),
                
                
                 fileInput("records", h4("load file"),
                           multiple = FALSE),
                 numericInput("digits",h4("number of digits to test"),1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("benford_plot",width= "100%"),
      dataTableOutput("benford_table"),
      dataTableOutput("benford_suspect")
      
      
    )
  )
    ))
