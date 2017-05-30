library(shiny)
library(shinythemes)
library(dplyr)
library(visNetwork)

# ui----
shinyUI(
  fluidPage(theme = shinytheme("flatly"),
            titlePanel("PathologyNET2"),
            fluidRow(column(3,wellPanel("SideBar")),
                     column(9,fluidRow(
                       column(4,
                              visNetworkOutput("network")
                       )
                       ,
                       column(4,
                              tabsetPanel(
                                tabPanel("tabA",h3("testA")),
                                tabPanel("tabB",h3("testB"))
                              )
                       )
                     ))
            )
  )
)

