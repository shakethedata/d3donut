library(shiny)
library(testD3)
library(dplyr)

#gexf <- system.file("examples/ediaspora.gexf.xml", package = "sigma")

df <- readr:: read_csv ('donut2.csv')



df$list <- strsplit(df$links, split=' ')

head(df)

dfx <- df %>%
  tidyr::unnest()

View (dfx)


df$AT <- grepl ("AT", df$links)
df$CT <- grepl ("CT", df$links)
df$DERM <- grepl ("DERM", df$links)
df$p = ""
df$p [df$AT == TRUE] <- 'AT'
df$p [df$CT == TRUE] <-
df$p [df$DERM == TRUE] <- 'AT'

df %>%
  mutate (proj = intersect (id, c('AT', 'CT', 'DERM')))

"AT" %in% df$links

head (df)
View(df)

ui = shinyUI(fluidPage(
  tabsetPanel(
  tabPanel("htmlwidgets",
  checkboxInput("drawEdges", "Draw Edges", value = TRUE),
  checkboxInput("drawNodes", "Draw Nodes", value = TRUE),
  testD3Output('test')
  ),
  tabPanel('Source js',
           tags$div(id="d3donutchart"),
           tags$div(class="otherthings",
                    tags$script(src="d3.min.js"),
                    tags$script(src="donut.js")
           ))
)))

server = function(input, output)

  output$test <- renderTestD3({
    testD3 (message = df)
})

shinyApp(ui = ui, server = server)



