# ShinyMaker

# LIBRARY----
library(shiny)
library(shinythemes)
library(dplyr)

# library.list----
load("libraryList.rdata")
names(libraryList$number) <- libraryList$libraryName
libraryChoices <- libraryList$number %>% as.list()

# inputContents.list----
load("inputContents.rdata")
inputContents
names(inputContents$number) <- inputContents$contents
inputContentsChoices <- inputContents$number %>% as.list()

# outputContents.list----
load("outputContents.rdata")
outputContents
names(outputContents$number) <- outputContents$contents
outputContentsChoices <- outputContents$number %>% as.list()
outputContentsChoices

# UI----
ui <- fluidPage(shinythemes::themeSelector(),
                titlePanel("ShinyMaker"),
                fluidRow(
                  column(2,h3("Frame"),
                         textInput("title", label=h5("title:"),value="sample"),
                         radioButtons("sidebar", label = h5("Sidebar :"),
                                      choices = list("yes"  =1,
                                                     "no"   =2),selected = 2),
                         radioButtons("tab", label = h5("Tab :"),
                                      choices = list("yes"  =1,
                                                     "no"   =2),selected = 2)
                  ),
                  column(2,
                         radioButtons("theme", label = h3("Theme :"),
                                      choices = list("default"  =1,
                                                     "cerulean" =2,
                                                     "cosmo"    =3,
                                                     "cyborg"   =4,
                                                     "darkly"   =5,
                                                     "flatly"   =6,
                                                     "journal"  =7,
                                                     "lumen"    =8,
                                                     "paper"    =9,
                                                     "readable" =10,
                                                     "sandstone"=11,
                                                     "simplex"  =12,
                                                     "slate"    =13,
                                                     "spacelab" =14,
                                                     "superhero"=15,
                                                     "united"   =16,
                                                     "yeti"     =17),selected = 1)
                  ),
                  column(2,
                         checkboxGroupInput("library_list", label = h3("Libraries"), 
                                            choices = libraryChoices,
                                            selected = c(1,2,3,4))
                  ),
                  column(3,
                         checkboxGroupInput("inputContentsList", label = h3("Input contents"), 
                                            choices = inputContentsChoices,
                                            selected = 1)
                  ),
                  column(3,
                         checkboxGroupInput("ouputContentsList", label = h3("Output contents"), 
                                            choices = outputContentsChoices,
                                            selected = 1),
                         actionButton("save_shiny","make shinycode"),
                         verbatimTextOutput("comment1"),
                         h5(),
                         actionButton("confirm_code","display code")
                  ),
                  
                  column(12,
                         tabsetPanel(
                           tabPanel("ui.R",verbatimTextOutput("uicode")),  
                           tabPanel("server.R",verbatimTextOutput("servercode")) 
                         )
                  )
                )
)

# UI/SERVEER.contents.code data----
load("UIContentsCode.rdata")
load("ServerContentsCode.rdata")

# SERVER----
server <- function(input,output,session){
  comment1 <- eventReactive(input$save_shiny,{
    
    # library.part of shiny.code----
    libraryCommnetCode <- '\n# library----'
    makeLibraryCode <- function(libraryList){
      paste0('library(',libraryList,')')
    }
    libraryCode <- sapply(libraryList$libraryName,makeLibraryCode)
    neededLibraryNumber <- as.numeric(input$library_list)
    libraryCode <- libraryCode[neededLibraryNumber]
    libraryCode <- c(libraryCommnetCode,libraryCode)
    
    # ui.part of shiny.code----
    shinyUI.head <- '\n# ui----\nshinyUI('
    shinyUI.tail <- ')'
    
    if(input$theme==1){
      ui.fluidpage.h <- 'fluidPage('
    } else{
      switch(input$theme,
             # "1"= stheme <- "default",  # default doesn't work
             "2"= stheme <- "cerulean",
             "3"= stheme <- "cosmo",
             "4"= stheme <- "cyborg",
             "5"= stheme <- "darkly",
             "6"= stheme <- "flatly",
             "7"= stheme <- "journal",
             "8"= stheme <- "lumen",
             "9"= stheme <- "paper",
             "10"= stheme <- "readable",
             "11"= stheme <- "sandstone",
             "12"= stheme <- "simplex",
             "13"= stheme <- "slate",
             "14"= stheme <- "spacelab",
             "15"= stheme <- "superhero",
             "16"= stheme <- "united",
             "17"= stheme <- "yeti"
      )
      ui.fluidpage.h <- paste0('fluidPage(theme = shinytheme("',stheme,'"),')
    }
    ui.fluidpage.t <- ')'
    
    ui.title <- paste0('titlePanel("',input$title,'"),')
    
    ui.pagebody.h1 <- 'fluidRow('
    ui.pagebody.h2 <- 'fluidRow(\ncolumn(3,\nwellPanel("SideBar")\n),\ncolumn(9,\nfluidRow('
    ui.pagebody.t1 <- ')'
    ui.pagebody.t2 <- ')\n)\n)'
    comma <- ','
    
    # sidebar
    if(input$sidebar==2){             # no
      ui.pagebody.h <- ui.pagebody.h1
      ui.pagebody.t <- ui.pagebody.t1
    } else if(input$sidebar==1){      # yes
      ui.pagebody.h <- ui.pagebody.h2
      ui.pagebody.t <- ui.pagebody.t2
    }
    
    # iutput/outputContentsNumber is selected content-numbers
    inputContentsNumber <- as.numeric(input$inputContentsList)
    outputContentsNumber <- as.numeric(input$ouputContentsList)
    contentNumber <- c(inputContentsNumber,outputContentsNumber+max(inputContents$number)) # inputとoutputの選択番号を連番に

    tuckCodeIntoColumn4 <- function(code){
      paste("column(4,\n",code,"\n)")
    }
    tuckedCode <- sapply(UIContentsCode$contentsText[contentNumber],tuckCodeIntoColumn4)
    tuckedCode <- tuckedCode[!(tuckedCode=="")] 
    connectedUIContentsCode <- paste(tuckedCode,collapse=",\n")
    
    # add tab
    if(input$tab==1){   
      tab.code <- 'column(4,\ntabsetPanel(\ntabPanel("tabA",\nh3("testA")\n),\ntabPanel("tabB",\nh3("testB")\n)\n)\n),'
      connectedUIContentsCode <- c(tab.code,connectedUIContentsCode)
    }
    
    # CodeFrame(header,sidebar part)
    code.ui <- c(shinyUI.head,
                 ui.fluidpage.h,         
                 ui.title,         
                 ui.pagebody.h,
                 connectedUIContentsCode,
                 ui.pagebody.t,
                 ui.fluidpage.t,
                 shinyUI.tail)
    
    
    # server.part of shiny.code----
    
    # make server.header/tail code----
    server.h <- '\n# server----\nshinyServer(\nfunction(input, output) { '
    server.h2 <- '\n# server----\nshinyServer(\nfunction(input, output, session) { '
    server.t <- '}\n)'
    
    if(9 %in% inputContentsNumber){ 　# actionボタン使うときはsession入れる
      server.h <- server.h2
    } else {
      server.h <- server.h
    }
    
    # 空白ベクトルを削除
    ServerContentsCode_withBlanck<- ServerContentsCode$contentsText[contentNumber]
    ServerContentsCode_withoutBlanck <- ServerContentsCode_withBlanck[!(ServerContentsCode_withBlanck=="")]  
    connectedServerContentsCode <- paste(ServerContentsCode_withoutBlanck,collapse="\n")
    code.server <- c(server.h,connectedServerContentsCode,server.t)
    
    # make whole code----
    # record shiny execute file---
    if(!("sample" %in% list.files(getwd()))){
      dir.create(paste0(getwd(),"/sample"))
    }
    uiCode <- c(libraryCode,code.ui)
    write(uiCode,file = "sample/ui.R")
    code.server <- c(libraryCode,code.server)
    write(code.server,file = "sample/server.R")
    text <- 'Shiny_code was created. '
    
    ### error.check----
    # error.check <- contentNumber
    
  })
  output$comment1 <- renderText({
    comment1()
  })
  output$txt_lib <- renderText({
    input$library_list %>% str()
  })
  output$uicode <- renderText({
    input$confirm_code
    if("ui.R" %in% list.files(paste0(getwd(),"/sample"))){
      uicode <- readLines("sample/ui.R")
      uicode <- paste(uicode, collapse = "\n")
    } else {
      uicode <- "File does not exist"
    }
  })
  output$servercode <- renderText({
    input$confirm_code
    if("server.R" %in% list.files(paste0(getwd(),"/sample"))){
      servercode <- readLines("sample/server.R")
      servercode <- paste(servercode, collapse = "\n")
    } else {
      servercode <- "File does not exist"
    }
  })
  
}

# shinyApp----
shinyApp(ui,server)


















