
# library----
library(shiny)
library(shinythemes)
library(dplyr)
library(magick)
library(EBImage)

# ui----
shinyUI(
  fluidPage(
    titlePanel("sample"),
    fluidRow(
      column(4,
             imageOutput("myImages") 
      )
    )
  )
  
  
)
