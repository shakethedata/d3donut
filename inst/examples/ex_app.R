library(shiny)
library(r2d3)
# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Use d3Output and render from R2d3 package"),
  d3Output("d3")
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$d3 <- renderD3({
    r2d3( data=readr::read_csv("donut2.csv"), script="d3donut.js", width=600, height=600)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)


