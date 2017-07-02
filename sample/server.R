library(shiny)
library(shinythemes)
library(dplyr)
library(ggplot2)
library(visNetwork)
library(DiagrammeR)

# server----
shinyServer(
function(input, output) { 
output$ggplot <- renderPlot({
ggplot(iris,aes(Sepal.Width,Sepal.Length))+geom_point()
})
}
)
