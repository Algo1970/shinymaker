
# library----
library(shiny)
library(shinythemes)
library(dplyr)

# ui----
shinyUI(
  fluidPage(
    titlePanel("sample"),
    fluidRow(
      column(4,
             textInput("title", label="title",value="") 
      ),
      column(4,
             dateInput("date_input", "Date:") 
      ),
      column(4,
             dateRangeInput("daterange_input", "Date range:",start = Sys.Date()-10,end = Sys.Date()+10) 
      ),
      column(4,
             fileInput("file_input",label = "Input File:"),
             tableOutput("fileContents") 
      ),
      column(4,
             actionButton("action_button","save data"),
             verbatimTextOutput("comment_actionButton") 
      ),
      column(4,
             checkboxGroupInput("checkbox_group_input", "Choose icons:",
                                choiceNames=list(icon("calendar"),icon("bed")),
                                choiceValues=list("calendar","bed")),
             textOutput("txt") 
      )
    )
  )
)
