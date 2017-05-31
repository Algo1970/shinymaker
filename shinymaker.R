# shinymaker

print(sessionInfo())

# library----
library(shiny)
library(shinythemes)
library(dplyr)
library(clipr)

# library.list
lib <- c("shiny",
         "shinythemes",
         "dplyr",
         "ggplot2",
         "plotly",
         "visNetwork",
         "DT",
         "DiagrammeR",
         "gridExtra",
         "magick",
         "EBImage",
         "RMySQL",
         "RPostgreSQL",
         "RODBC",
         "leaflet",
         "ggmap",
         "rvest")
n <- 1:length(lib)
names(n) <- lib
choices1 <- as.list(n)

# contents.list
contents <- c("textInput",
              "radioButtons",
              "numericInput",
              "sliderInput",
              "selectInput",
              "dateInput",
              "dateRangeInput",
              "fileInput",
              "actionButton",
              "checkboxGroupInput")
n <- 1:length(contents)
names(n) <- contents
choices2 <- as.list(n)

contents2 <- c("ggplot2",
               "plotly",
               "renderImage",
               "leaflet",
               "click_image",
               "click_plot",
               "DiagrammeR",
               "visNetwork",
               "verbatimTextOutput",
               "dataTableOutput")
n <- 1:length(contents2)
names(n) <- contents2
choices3 <- as.list(n)

# ui----
ui <- fluidPage(shinythemes::themeSelector(),
                titlePanel("shinymaker"),
                fluidRow(
                  column(2,h3("Frame"),
                         textInput("title", label=h5("title:"),value=""),
                         radioButtons("sidedisable", label = h5("Sidebar :"),
                                      choices = list("yes"  =1,
                                                     "no"   =2),selected = 2),
                         radioButtons("tab", label = h5("Tab :"),
                                      choices = list("yes"  =1,
                                                     "no"   =2),selected = 2)
                  ),
                  column(2,
                         radioButtons("theme", label = h3("Theme:"),
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
                                            choices = choices1,
                                            selected = c(1,2,3,4,6,8))
                  ),
                  column(3,
                         checkboxGroupInput("contents_list", label = h3("Input UI contents"), 
                                            choices = choices2,
                                            selected = 1)
                  ),
                  column(3,
                         checkboxGroupInput("contents_list2", label = h3("Output contents"), 
                                            choices = choices3,
                                            selected = 1),
                         actionButton("save_shiny","make shinycode"),
                         verbatimTextOutput("comment1"),
                         h5(),
                         actionButton("confirm_code","display code")#,
                         # h5(),
                         # actionButton("copy_uicode","copy UI code"),
                         # verbatimTextOutput("comment_copyui"),
                         # actionButton("copy_servercode","copy Server code"),
                         # verbatimTextOutput("comment_copyserver")
                  ),
                  
                  column(12,
                         tabsetPanel(
                           tabPanel("ui.R",verbatimTextOutput("uicode")),  
                           tabPanel("server.R",verbatimTextOutput("servercode")) 
                         )
                  )
                )
)

# ui.contents----
comma <- ','

ui.textinput <- 'column(4,\ntextInput("title", label="title",value="")\n)'
ui.checkbox <- 'column(4,\ncheckboxGroupInput("icons", "Choose icons:",\nchoiceNames=list(icon("calendar"),icon("bed")),\nchoiceValues=list("calendar","bed")),\ntextOutput("txt")\n)'
ui.dateinput <- 'column(4,\ndateInput("date2", "Date:"))'
ui.daterangeinput <- 'column(4,\ndateRangeInput("daterange4", "Date range:",start = Sys.Date()-10,end = Sys.Date()+10)\n)'
ui.fileinput <- 'column(4,\nfileInput("file",label = "Input File:"),\ntableOutput("contents")\n)'
ui.numericinput <- 'column(4,\nnumericInput("obs1", "Obs:", 10, min = 1, max = 100),\nverbatimTextOutput("value")\n)'
ui.radiobutton <- 'column(4,\nradioButtons("rb", "Choose one:", c("A" = "1","B" = "2","C" = "3")\n),\ntextOutput("txt2")\n)'
ui.sliderinput <- 'column(4,\nsliderInput("obs", "Number of observations:",min = 0, max = 1000, value = 500),\nplotOutput("distPlot",height = 150)\n)'
ui.selectinput <- 'column(4,\nselectInput("moji","Choose:",list(`group1`=c("A","B","C"),`group2`=c("D","E","F"))),\ntextOutput("result")\n)'
ui.actionbutton <- 'column(4,\nactionButton("save","save data"),\nverbatimTextOutput("comment_button")\n)'
ui.tab <- 'column(4,\ntabsetPanel(\ntabPanel("tabA",h3("testA")),\ntabPanel("tabB",h3("testB"))\n)\n)'

ui.plotly <- 'column(4,\nplotlyOutput("plotly")\n)'
ui.ggplot <- 'column(4,\nplotOutput("ggplot",height=200)\n)'
ui.image <- 'column(4,\nimageOutput("myImages")\n)'
ui.leaflet <- 'column(4,\nleafletOutput("mymap")\n)'
ui.clickimage <- 'column(4,\nimageOutput("myImage",click = "image_click"),\nverbatimTextOutput("info")\n)'
ui.clickplot <- 'column(4,\nplotOutput("plot1",click ="plot_click"),\nverbatimTextOutput("info2")\n)'
ui.diagram <- 'column(4,\ngrVizOutput("diagram",width ="100%",height="300px")\n)'
ui.visnet <- 'column(4,\nvisNetworkOutput("network")\n)'
ui.verbatimtext <- 'column(4,\nverbatimTextOutput("verba_text")\n)'
ui.datatable <- 'column(4,\ndataTableOutput("DT1")\n)'

# make servercode----
server.h <- '\n# server----\nshinyServer(\nfunction(input, output) { '
server.h2 <- '\n# server----\nshinyServer(\nfunction(input, output, session) { '
server.t <- '}\n)'

# server.contents----
server.checkbox <- 'output$txt <- renderText({\nicons <- paste(input$icons,collapse = ", ");paste("You chose", icons)\n})'
server.fileinput <- 'output$contents <- renderTable({\ninFile <- input$file1\nif (is.null(inFile))\nreturn(NULL)\nread.csv(inFile$datapath, header = input$header)\n})'
server.numericinput <- 'output$value <- renderText({\ninput$obs1 \n})'
server.radiobutton <- ' output$txt2 <- renderText({\npaste("You chose", input$rb)\n})'
server.sliderinput <- 'output$distPlot <- renderPlot({\nhist(rnorm(input$obs))\n})'
server.selectinput <- ' output$result <- renderText({\npaste("You chose", input$state)\n})'
server.actionbutton <- 'comment_save <- eventReactive(input$save,{\ncat("saveButton was pushed"\n)})\noutput$comment_button <- renderText({\ncomment_save()\n})'

server.ggplot <- 'output$ggplot <- renderPlot({\nggplot(iris,aes(Sepal.Width,Sepal.Length))+geom_point()\n})'
server.plotly <- 'output$plotly <- renderPlotly({\nplot_ly(z=volcano,type="heatmap")\n})'
server.image <- 'output$myImages <- renderImage({\nif(!("rlogo.png" %in% list.files(getwd()))){\nimage_read("https://www.r-project.org/logo/Rlogo.png") %>% image_write("rlogo.png")\n}\nlist(src = "rlogo.png",filetype = "image/png",width = 300,height = 300,alt = "This is alternate text")}, deleteFile = FALSE)'
server.leaflet <- 'output$mymap <- renderLeaflet({\nleaflet() %>% \naddProviderTiles(providers$Stamen.TonerLite,options = providerTileOptions(noWrap = TRUE))} %>% \naddMiniMap(tiles = providers$Esri.WorldStreetMap,toggleDisplay = TRUE))'
server.clickimage <- 'output$myImage <- renderImage({\nif("ebi_miso.JPG" %in% list.files(getwd())){\nlist(src = "ebi_miso.JPG",\nfiletype = "image/jpeg",\nwidth = 400,\nheight = 300,\nalt = "ramen")\n}\n}, deleteFile = FALSE)\noutput$info <- renderText({\npaste0("x=",input$image_click$x,"y=",input$image_click$y)\n})'
server.clickplot <- 'output$plot1 <- renderPlot({\nggplot(iris,aes(Sepal.Width,Sepal.Length))+geom_point()\n})
output$info2 <- renderText({\npaste0("x=", input$plot_click$x, "\ny=", input$plot_click$y)\n})'
server.diagram <- 'output$diagram <- renderGrViz({\nnodes <-create_nodes(nodes = 1:3)\nedges <-create_edges(from = 1:3,to = c(2,3,1))\ngraph <-create_graph(nodes_df = nodes,edges_df = edges)\ngrViz({graph$dot_code})})'
server.visnet <- 'output$network <- renderVisNetwork({\nnodes <- data.frame(id = 1:3,label=1:3)\nedges <- data.frame(from = c(1,2,3), to = c(2,3,1))\nvisNetwork(nodes, edges)})'
server.verbatimtext <- 'output$verba_text <- renderText({\ntext <- "sample text"\n})'
server.datatable <- 'output$DT1 <- renderDataTable({\nhead(iris[,c(1,2)],3) },options = list(pageLength = 5,searching = T))'

# shiny.app----
code.shinyapp <- '\nshinyApp(ui = ui, server = server)'

# server----
server <- function(input,output){
  comment1 <- eventReactive(input$save_shiny,{
    
    # library code----
    lib_txt <- vector()
    lib_txt[1] <- '\n# library----'
    for(i in seq_along(lib)){
      lib_txt[i+1] <- paste0('library(',lib[i],')')
    }
    code.library <- paste0(lib_txt)
    n_list <- as.numeric(input$library_list)+1
    codelib <- code.library[n_list]
    
    # ui code----
    if(input$theme==1){
      ui.fluidpage.h <- paste0('\n# ui----\nshinyUI(\nfluidPage(')
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
      ui.fluidpage.h <- paste0('\n# ui----\nshinyUI(\nfluidPage(theme = shinytheme("',stheme,'"),')
    }
    ui.fluidpage.t <- ')\n'
    ui.title <- paste0('titlePanel("',input$title,'"),')
    ui.pagebody.h1 <- 'fluidRow('
    ui.pagebody.h2 <- 'fluidRow(column(3,wellPanel("SideBar")),\ncolumn(9,fluidRow('
    ui.pagebody.t1 <- ')\n)'
    ui.pagebody.t2 <- '))\n)\n)'
    
    # sidebar
    if(input$sidedisable==2){
      # no
      ui.pagebody.h <- ui.pagebody.h1
      ui.pagebody.t <- ui.pagebody.t1
    } else if(input$sidedisable==1){
      # yes
      ui.pagebody.h <- ui.pagebody.h2
      ui.pagebody.t <- ui.pagebody.t2
    }
    
    # header,sidebar part
    code.ui <- c(ui.fluidpage.h,         
                 ui.title,         
                 ui.pagebody.h)
    # select contents
    contents.n <- 0
    # server.code----
    code.server <- c(server.h)
    
    # n_con is selected content-numbers
    n_con <- as.numeric(input$contents_list)
    n_con2 <- as.numeric(input$contents_list2)
    
    # textinput
    if(contents.n==0 & (1 %in% n_con)){
      code.ui <- c(code.ui,ui.textinput)
      contents.n <- contents.n+1
    } else if(contents.n>=1 & (1 %in% n_con)){
      code.ui <- c(code.ui,comma,ui.textinput)
      contents.n <- contents.n+1
    }
    # radiobutton
    if(contents.n==0 & (2 %in% n_con)){
      code.ui <- c(code.ui,ui.radiobutton)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.radiobutton)
    } else if(contents.n>=1 & (2 %in% n_con)){
      code.ui <- c(code.ui,comma,ui.radiobutton)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.radiobutton)
    }
    # numericinput
    if(contents.n==0 & (3 %in% n_con)){
      code.ui <- c(code.ui,ui.numericinput)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.numericinput)
    } else if(contents.n>=1 & (3 %in% n_con)){
      code.ui <- c(code.ui,comma,ui.numericinput)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.numericinput)
    }
    # sliderinput
    if(contents.n==0 & (4 %in% n_con)){
      code.ui <- c(code.ui,ui.sliderinput)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.sliderinput)
    } else if(contents.n>=1 & (4 %in% n_con)){
      code.ui <- c(code.ui,comma,ui.sliderinput)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.sliderinput)
    }
    # selectinput
    if(contents.n==0 & (5 %in% n_con)){
      code.ui <- c(code.ui,ui.selectinput)
      contents.n <- contents.n+1
    } else if(contents.n>=1 & (5 %in% n_con)){
      code.ui <- c(code.ui,comma,ui.selectinput)
      contents.n <- contents.n+1
    }
    
    # dateinput
    if(contents.n==0 & (6 %in% n_con)){
      code.ui <- c(code.ui,ui.dateinput)
      contents.n <- contents.n+1
    } else if(contents.n>=1 & (6 %in% n_con)){
      code.ui <- c(code.ui,comma,ui.dateinput)
      contents.n <- contents.n+1
    }
    # daterangeinput
    if(contents.n==0 & (7 %in% n_con)){
      code.ui <- c(code.ui,ui.daterangeinput)
      contents.n <- contents.n+1
    } else if(contents.n>=1 & (7 %in% n_con)){
      code.ui <- c(code.ui,comma,ui.daterangeinput)
      contents.n <- contents.n+1
    }
    # fileinput
    if(contents.n==0 & (8 %in% n_con)){
      code.ui <- c(code.ui,ui.fileinput)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.fileinput)
    } else if(contents.n>=1 & (8 %in% n_con)){
      code.ui <- c(code.ui,comma,ui.fileinput)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.fileinput)
    }
    # actionbutton
    if(contents.n==0 & (9 %in% n_con)){
      code.ui <- c(code.ui,ui.actionbutton)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.actionbutton)
    } else if(contents.n>=1 & (9 %in% n_con)){
      code.ui <- c(code.ui,comma,ui.actionbutton)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.actionbutton)
    }
    # checkboxGroupInput
    if(contents.n==0 & (10 %in% n_con)){
      code.ui <- c(code.ui,ui.checkbox)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.checkbox)
    } else if(contents.n>=1 & (10 %in% n_con)){
      code.ui <- c(code.ui,comma,ui.checkbox)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.checkbox)
    }
    
    # ggplot
    if(contents.n==0 & (1 %in% n_con2)){
      code.ui <- c(code.ui,ui.ggplot)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.ggplot)
    } else if(contents.n>=1 & (1 %in% n_con2)){
      code.ui <- c(code.ui,comma,ui.ggplot)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.ggplot)
    }
    # plotly
    if(contents.n==0 & (2 %in% n_con2)){
      code.ui <- c(code.ui,ui.plotly)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.plotly)
    } else if(contents.n>=1 & (2 %in% n_con2)){
      code.ui <- c(code.ui,comma,ui.plotly)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.plotly)
    }
    # renderImage
    if(contents.n==0 & (3 %in% n_con2)){
      code.ui <- c(code.ui,ui.image)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.image)
    } else if(contents.n>=1 & (3 %in% n_con2)){
      code.ui <- c(code.ui,comma,ui.image)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.image)
    }
    # leaflet
    if(contents.n==0 & (4 %in% n_con2)){
      code.ui <- c(code.ui,ui.leaflet)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.leaflet)
    } else if(contents.n>=1 & (4 %in% n_con2)){
      code.ui <- c(code.ui,comma,ui.leaflet)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.leaflet)
    }
    # click.image
    if(contents.n==0 & (5 %in% n_con2)){
      code.ui <- c(code.ui,ui.clickimage)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.clickimage)
    } else if(contents.n>=1 & (5 %in% n_con2)){
      code.ui <- c(code.ui,comma,ui.clickimage)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.clickimage)
    }
    # click.plot
    if(contents.n==0 & (6 %in% n_con2)){
      code.ui <- c(code.ui,ui.clickplot)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.clickplot)
    } else if(contents.n>=1 & (6 %in% n_con2)){
      code.ui <- c(code.ui,comma,ui.clickplot)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.clickplot)
    }
    # DiagrammeR
    if(contents.n==0 & (7 %in% n_con2)){
      code.ui <- c(code.ui,ui.diagram)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.diagram)
    } else if(contents.n>=1 & (7 %in% n_con2)){
      code.ui <- c(code.ui,comma,ui.diagram)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.diagram)
    }
    # visNetwork
    if(contents.n==0 & (8 %in% n_con2)){
      code.ui <- c(code.ui,ui.visnet)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.visnet)
    } else if(contents.n>=1 & (8 %in% n_con2)){
      code.ui <- c(code.ui,comma,ui.visnet)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.visnet)
    }
    # verbatimTextOutput
    if(contents.n==0 & (9 %in% n_con2)){
      code.ui <- c(code.ui,ui.verbatimtext)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.verbatimtext)
    } else if(contents.n>=1 & (9 %in% n_con2)){
      code.ui <- c(code.ui,comma,ui.verbatimtext)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.verbatimtext)
    }
    # datatable
    if(contents.n==0 & (10 %in% n_con2)){
      code.ui <- c(code.ui,ui.datatable)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.datatable)
    } else if(contents.n>=1 & (10 %in% n_con2)){
      code.ui <- c(code.ui,comma,ui.datatable)
      contents.n <- contents.n+1
      code.server <- c(code.server,server.datatable)
    }
    
    # tab
    if(contents.n==0 & (input$tab==1)){
      code.ui <- c(code.ui,ui.tab)
      contents.n <- contents.n+1
    } else if(contents.n>=1 & (input$tab==1)){
      code.ui <- c(code.ui,comma,ui.tab)
      contents.n <- contents.n+1
    }
    
    # tail
    code.ui <- c(code.ui,ui.pagebody.t,ui.fluidpage.t)
    code.ui
    code.server <- c(code.server,server.t)
    
    # make whole code----
    # record shiny execute file---
    code.UI <- c(codelib,code.ui)
    write(code.UI,file = "ui.R")
    code.server <- c(codelib,code.server)
    write(code.server,file = "server.R")
    text <- 'shiny_template code was created '
  })
  output$comment1 <- renderText({
    comment1()
  })
  output$txt_lib <- renderText({
    input$library_list %>% str()
  })
  output$uicode <- renderText({
    input$confirm_code
    if("ui.R" %in% list.files(getwd())){
      uicode <- readLines("ui.R")
      unicode <- paste(uicode, collapse = "\n")
    } else {
      uicode <- "File does not exist"
    }
  })
  output$servercode <- renderText({
    input$confirm_code
    if("server.R" %in% list.files(getwd())){
      servercode <- readLines("server.R")
      servercode <- paste(servercode, collapse = "\n")
    } else {
      servercode <- "File does not exist"
    }
  })

}

# shinyApp----
shinyApp(ui,server)


















