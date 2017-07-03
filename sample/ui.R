
# library----
library(shiny)
library(shinythemes)

# ui----
shinyUI(
  fluidPage(
    titlePanel("sample"),
    fluidRow(
      column(4,
             fileInput("file",label = "Input File:"),
             tableOutput("contents") 
      ),column(4,
               actionButton("save","save data"),
               verbatimTextOutput("comment_button") 
      ),column(4,
               plotOutput("ggplot",height=200) 
      )
    )
  )
  
  
)
