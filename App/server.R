
library(shiny)
library(benford.analysis)
#define left function
left = function (string,char){
  substr(string,1,char)}
data(corporate.payment)

shinyServer(function(input, output) {
  
  data                   <- reactive({if (is.null(input$records$name)){
    corporate.payment$Amount }else{
      read.csv(input$records$datapath,header=TRUE,sep=";")
    }
  })
  benford_obj            <- reactive({benford(data(),input$digits)})
  output$benford_plot    <- renderPlot({
    
    plot(benford_obj())
  })
  output$benford_table   <- renderDataTable({suspectsTable(benford_obj())})
  output$benford_suspect <- renderDataTable({
    digits                   <-left(data(),input$digits)
    data_output              <- data.frame(data(),digits)
    suspects                 <- suspectsTable(benford_obj())
    suspects_digits          <- (as.character(suspects$digits))
    data_suspected           <- subset(data_output,as.character(data_output[,2])
                                       %in% suspects_digits)
  }) 
  
})
