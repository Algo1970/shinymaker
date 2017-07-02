library(shiny)
library(shinythemes)
library(dplyr)
library(ggplot2)
library(visNetwork)
library(DiagrammeR)

# ui----
shinyUI(
fluidPage(
titlePanel("sample"),
fluidRow(
column(4,
textInput("title", label="title",value="")
)
,
column(4,
plotOutput("ggplot",height=200)
)
)
)
)

