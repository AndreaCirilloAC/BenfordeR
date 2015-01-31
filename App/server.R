
library(shiny)
library(benford.analysis)

#define left function to work around an issue on the extract.digits() function within the benford.analysis
left = function (string,char){
  substr(string,1,char)}
data(corporate.payment)

shinyServer(function(input, output) {
  #if statement to load the demo dataset if the user doesn't provide his own
  data                   <- reactive({if (is.null(input$records$name)){
                                corporate.payment$Amount }else{
                                  read.csv(input$records$datapath,header=TRUE,sep=";")
                                            }
                                    })
  # the main object in the app, benford_obj contains all the results of the benford analysis
  # executed on the dataset defined in data.
  # as an argument is passed the number of leading digits to test, directly from the numeric
  # input control in user interface
  benford_obj            <- reactive({benford(data(),input$digits)})
  # plot of the benford objects
  output$benford_plot    <- renderPlot({
    plot(benford_obj())
  })
  # table with the first three digits in term of deviance from benford's law
  output$benford_table   <- renderDataTable({
    suspects <- suspectsTable(benford_obj())
    suspects <- suspects[1:3,]})
  # table containing the records associated to te three leading digits mentioned above
  output$benford_suspect <- renderDataTable({
    digits                   <-left(data(),input$digits) # extract n digits from the data() table, using the left function
    data_output              <- data.frame(data(),digits)# join the digits with the dataset
    suspects                 <- suspectsTable(benford_obj()) # this could be improved using benford_table()
    suspects                 <- suspects[1:3,] #see above
    suspects_digits          <- (as.character(suspects$digits))
    data_suspected           <- subset(data_output,as.character(data_output[,2])# filter the data based on first three suspected digits
                                       %in% suspects_digits)
  }) 
  
})
