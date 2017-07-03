library(shiny)
library(shinythemes)
library(dplyr)
library(ggplot2)
library(visNetwork)
library(DiagrammeR)

# server----
shinyServer(
function(input, output) { 
 output$txt2 <- renderText({
paste("You chose", input$rb)
})
}
)
