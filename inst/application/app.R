library(shiny)
# library(d3donut)
library(dplyr)


#df <- readr:: read_csv ('~/d3donut/inst/application/donut2.csv')

###############################
## UI
###############################

ui = shinyUI(fluidPage(
  
             d3donutOutput('test'),
             d3donutOutput('test2')
                 
))


server = function(input, output) {
  read_data <- reactive ({
    df <- readr::read_csv ('./www/donut2.csv')
  })
  output$test <- renderD3donut({
    d3donut (message = read_data())
  })
  output$test2 <- renderD3donut({
    d3donut (message = read_data())
  })
}

shinyApp(ui = ui, server = server)

