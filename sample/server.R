
# library----
library(shiny)
library(shinythemes)
library(dplyr)

# server----
shinyServer(
  function(input, output, session) { 
    output$fileContents <- renderTable({
      inFile <- input$file_input1     
      if (is.null(inFile))
        return(NULL)
      read.csv(inFile$datapath, header = input$header)
    })
    comment_save <- eventReactive(input$action_button,{
      cat("saveButton was pushed"
      )})
    output$comment_actionButton <- renderText({
      comment_save()
    })
    output$txt <- renderText({
      icons <- paste(input$checkbox_group_input,collapse = ", ");paste("You chose", icons)
    })
  }
)
