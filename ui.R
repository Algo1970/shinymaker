library(shiny)
library(shinythemes)
library(dplyr)
library(ggplot2)
library(visNetwork)
library(DiagrammeR)

# ui----
shinyUI(
fluidPage(
titlePanel(""),
fluidRow(
column(4,
radioButtons("rb", "Choose one:", c("A" = "1","B" = "2","C" = "3")
),
textOutput("txt2")
)
)
)
)

