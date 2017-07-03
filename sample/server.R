
# library----
library(shiny)
library(shinythemes)
library(dplyr)
library(ggplot2)
library(visNetwork)
library(DiagrammeR)

# server----
shinyServer(
  function(input, output) { 
    output$contents <- renderTable({
      inFile <- input$file1
      if (is.null(inFile))
        return(NULL)
      read.csv(inFile$datapath, header = input$header)
    })
    comment_save <- eventReactive(input$save,{
      cat("saveButton was pushed"
      )})
    output$comment_button <- renderText({
      comment_save()
    })
    output$ggplot <- renderPlot({
      ggplot(iris,aes(Sepal.Width,Sepal.Length))+geom_point()
    })
  }
)
