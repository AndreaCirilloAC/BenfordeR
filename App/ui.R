
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
                 p ("here come the instructions"),
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
