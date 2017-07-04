
# library----
library(shiny)
library(shinythemes)
library(dplyr)
library(ggplot2)
library(plotly)
library(visNetwork)
library(DiagrammeR)
library(leaflet)

# server----
shinyServer(
function(input, output) { 
output$ggplot <- renderPlot({
ggplot(iris,aes(Sepal.Width,Sepal.Length))+geom_point()
})
output$plotly <- renderPlotly({
plot_ly(z=volcano,type="heatmap")
})
output$imageoutput <- renderImage({
      filename <- normalizePath("../dog300.png")  
      list(src=filename,width = 300)
    }, deleteFile = FALSE)
output$mapLeaflet <- renderLeaflet({
leaflet() %>% 
addProviderTiles(providers$Stamen.TonerLite,options = providerTileOptions(noWrap = TRUE))} %>% 
addMiniMap(tiles = providers$Esri.WorldStreetMap,toggleDisplay = TRUE))
output$clickImage <- renderImage({
        list(src = "../ebimiso2.jpg",width=400)
    }, deleteFile = FALSE)
    output$infoClickXY <- renderText({
      paste0("x=",input$image_click$x,"y=",input$image_click$y)
    })
output$diagram <- renderGrViz({
nodes <- create_node_df(3)
edges <- create_edge_df(from = 1:3,to = c(2,3,1))
create_graph(nodes,edges) %>% render_graph()
})
output$visnetwork <- renderVisNetwork({
nodes <- data.frame(id = 1:3,label=1:3)
edges <- data.frame(from = c(1,2,3), to = c(2,3,1))
visNetwork(nodes, edges)})
output$verba_text <- renderText({
text <- "sample text"
})
}
)
