
# library----
library(shiny)
library(shinythemes)
library(dplyr)
library(ggplot2)
library(plotly)
library(visNetwork)
library(DiagrammeR)
library(leaflet)

# ui----
shinyUI(
fluidPage(
titlePanel("sample"),
fluidRow(
column(4,
 textInput("title", label="title",value="") 
),
column(4,
 plotOutput("ggplot",height=200) 
),
column(4,
 plotlyOutput("plotly") 
),
column(4,
 imageOutput("imageoutput") 
),
column(4,
 leafletOutput("mapLeaflet") 
),
column(4,
 imageOutput("clickImage",click = "image_click"),
verbatimTextOutput("infoClickXY") 
),
column(4,
 grVizOutput("diagram",width ="100%",height="300px") 
),
column(4,
 visNetworkOutput("visnetwork") 
),
column(4,
 verbatimTextOutput("verba_text") 
)
)
)
)
