library(shiny)
library(shinythemes)
library(dplyr)
library(visNetwork)

# server----
shinyServer(
  function(input, output) { 
    output$network <- renderVisNetwork({
      nodes <- data.frame(id = 1:3,label=1:3)
      edges <- data.frame(from = c(1,2,3), to = c(2,3,1))
      visNetwork(nodes, edges)})
  }
)
