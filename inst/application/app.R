# .libPaths(c(   "/home/brierma1/mylib_3_4_3_d3donut_dev",
#                "/home/brierma1/mylib_3_4_3_d3donut",
#                "/home/brierma1/mylib_3_4_3_exp",
#                .libPaths()))

 # .libPaths(c(   
 #                "/home/brierma1/mylib_3_4_3_d3donut",
 #                "/home/brierma1/mylib_3_4_3_exp",
 #                .libPaths()))



library(shiny)
#library(d3donut)
library(dplyr)
library(r2d3)

#-------------------------------
# UI
#------------------------------

ui = shinyUI(fluidPage(
             h4("Example of embedding d3.js script into htmlwidget for use in Shiny app"),
             br(),
             p("There are a few possibilities to include d3.js visualisations within a Shiny app. For a fixed script it is possible to source
the js file directly into the Shiny app. The new r2d3 package
contains the shiny functions d3Output and renderD3. Inside the renderD3 call another function,  r2d3  will run a d3.js script taking care of any
data conversion, defining the svg and allowing varying R data to be entered controlled by user interaction with Shiny. In fact, this function will create an htmlwidget behind the scenes, 
but offers less flexibility than creating the htmlwidget directly. For the greatest flexibility the d3.js script can be incorporated into a htmlwidget and placed within an R package. This 
also permits the R session to be able to receive information or data back from the htmlwidget for further display/processing."),
             br(),
             tabsetPanel(id="d3methods",
                         tabPanel("Using r2d3",
                                  selectInput("d3data", "Select data", c("Data1"="donut_data1", "Data2"="donut_data2")),
                                  div(id = "test", d3Output("f3", height = 700))
                         ),
                         
                         tabPanel("Using htmlwidgets",
                           br(),
                           p("In this example the part of the donut that the mouse hovers over is sent back to the R session and displayed underneath the visualisation and can be used for 
further manipulation by R. This can be achieved by using the Shiny.onInputChange function inside the htmlwidget script."),   
                           d3donutOutput('f1', height = 700),
                           textOutput('hover1'),
                           d3donutOutput('f2', height = 700),
                           textOutput('hover2')
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
    r2d3( data=df, script = "./www/ex_d3donut.js")
      })
  
  output$hover1 <- renderText({input$f1_selected})
  output$hover2 <- renderText({input$f2_selected})
  
  
  output$si <- renderPrint({
    sessionInfo()
  })
}

shinyApp(ui = ui, server = server)

