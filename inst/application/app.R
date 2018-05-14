# .libPaths(c( "/home/brierma1/mylib_3_4_3_d3donut",
#              "/home/brierma1/mylib_3_4_3_exp",
#             .libPaths()))
library(shiny)
#library(d3donut)
library(dplyr)
library(r2d3)

#-------------------------------
# UI
#------------------------------

ui = shinyUI(fluidPage(
             h4("Example of embedding d3.js file into htmlwidget for use in Shiny app"),
             p("There are a few possibilities to include d3.js visualisations within a Shiny app. For a fixed script it is possible to source
directly into the Shiny app. For the greatest flexibility the d3.js script can be incorporated into a htmlwidget and placed within an R library. This 
also permits R to be able to receive information or data back from the htmlwidget for further display/processing. Finally, using the new r2d3 package
it is possible to use d3Output and renderD3 with the r2d3 function which will run a d3.js script taking care of data conversion, defining the svg
and allowing varying data to be included. In fact, this function will create an htmlwidget behind the scenes, but offers less flexibility than creating
the htmlwidget directly."),
             br(),
             tabsetPanel(id="d3methods",
                         tabPanel("Using htmlwidgets",
                           d3donutOutput('f1', height = 700),
                           d3donutOutput('f2', height = 700)
                         ),
                         tabPanel("Using r2d3",
                            selectInput("d3data", "Select data", c("Data1"="donut_data1", "Data2"="donut_data2")),
                            d3Output("f3", height=700)
                                  ),
                         tabPanel("Session Info",
                                  br(),
                                  verbatimTextOutput("si")
                         )
             )
                 
))


server = function(input, output) {
  read_data <- reactive ({
    df <- readr::read_csv ('./www/donut2.csv')
  })
  
  output$f1 <- renderD3donut({
    df <- donut_data1
    d3donut (message = df)
  })
  
  output$f2 <- renderD3donut({
    df <- donut_data2
    d3donut (message = df )
  })
  
  output$f3 <- renderD3({
    df <- get(input$d3data)
    r2d3( data=data, script = "./www/ex_d3donut.js")
      })
  
  
  output$si <- renderPrint({
    sessionInfo()
  })
}

shinyApp(ui = ui, server = server)

