library(shiny)
library(benford.analysis)
#define left function
left = function (string,char){
  substr(string,1,char)}
data(corporate.payment)

server <- function(input, output) {
  
  data                   <- reactive({if (is.null(input$records$name)){
    corporate.payment$Amount }else{
      read.csv(input$records$datapath,header=TRUE,sep=";")
    }
  })
  benford_obj            <- reactive({benford(data(),input$digits)})
  output$benford_plot    <- renderPlot({
    
    plot(benford_obj())
  })
  output$benford_suspect <- renderDataTable({
    digits                   <-left(data(),input$digits)
    data_output              <- data.frame(data(),digits)
    suspects                 <- suspectsTable(benford_obj())
    suspects_digits          <- as.character(suspects[,1])
    data_suspected           <- subset(data_output,as.character(data_output[,2])
                                       %in% suspects_digits)
  }) 
  
}

library(shiny)

ui <- shinyUI(fluidPage(
  
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
      dataTableOutput("benford_suspect")
      
    )
  )
    ))

shinyApp(ui = ui, server = server)