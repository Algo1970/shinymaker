
# library----
library(shiny)
library(shinythemes)
library(dplyr)
library(magick)
library(EBImage)

# server----
shinyServer(
  function(input, output) { 
    output$myImages <- renderImage({
  
      filename <- normalizePath("../egg.png")  
      list(src=filename,width = 240,height = 240)
      # list(src = "egg.png",filetype = "image/png",width = 120,height = 120,alt = "egg")
        }, deleteFile = FALSE)
  }
)
