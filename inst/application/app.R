library(shiny)
# library(d3donut)
library(dplyr)


df <- readr:: read_csv ('~/d3donut/inst/application/donut2.csv')

###############################
## UI
###############################

ui = shinyUI(fluidPage(
  
             d3donutOutput('test'),
             d3donutOutput('test2')
                 
))


server = function(input, output) {
  output$test <- renderD3donut({
    d3donut (message = df)
  })
  output$test2 <- renderD3donut({
    d3donut (message = df)
  })
}

shinyApp(ui = ui, server = server)

