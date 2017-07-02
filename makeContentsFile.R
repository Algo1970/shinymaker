
UI.ContentsText <- c('column(4,\ntextInput("title", label="title",value="")\n)'
                     , 'column(4,\ncheckboxGroupInput("icons", "Choose icons:",\nchoiceNames=list(icon("calendar"),icon("bed")),\nchoiceValues=list("calendar","bed")),\ntextOutput("txt")\n)'
                     , 'column(4,\ndateInput("date2", "Date:"))'
                     , 'column(4,\ndateRangeInput("daterange4", "Date range:",start = Sys.Date()-10,end = Sys.Date()+10)\n)'
                     , 'column(4,\nfileInput("file",label = "Input File:"),\ntableOutput("contents")\n)'
                     , 'column(4,\nnumericInput("obs1", "Obs:", 10, min = 1, max = 100),\nverbatimTextOutput("value")\n)'
                     , 'column(4,\nradioButtons("rb", "Choose one:", c("A" = "1","B" = "2","C" = "3")\n),\ntextOutput("txt2")\n)'
                     , 'column(4,\nsliderInput("obs", "Number of observations:",min = 0, max = 1000, value = 500),\nplotOutput("distPlot",height = 150)\n)'
                     , 'column(4,\nselectInput("moji","Choose:",list(`group1`=c("A","B","C"),`group2`=c("D","E","F"))),\ntextOutput("result")\n)'
                     , 'column(4,\nactionButton("save","save data"),\nverbatimTextOutput("comment_button")\n)'
                     , 'column(4,\ntabsetPanel(\ntabPanel("tabA",h3("testA")),\ntabPanel("tabB",h3("testB"))\n)\n)'
                     , 'column(4,\nplotlyOutput("plotly")\n)'
                     , 'column(4,\nplotOutput("ggplot",height=200)\n)'
                     , 'column(4,\nimageOutput("myImages")\n)'
                     , 'column(4,\nleafletOutput("mymap")\n)'
                     , 'column(4,\nimageOutput("myImage",click = "image_click"),\nverbatimTextOutput("info")\n)'
                     , 'column(4,\nplotOutput("plot1",click ="plot_click"),\nverbatimTextOutput("info2")\n)'
                     , 'column(4,\ngrVizOutput("diagram",width ="100%",height="300px")\n)'
                     , 'column(4,\nvisNetworkOutput("network")\n)'
                     , 'column(4,\nverbatimTextOutput("verba_text")\n)'
                     , 'column(4,\ndataTableOutput("DT1")\n)')
UI.ContentsText

UI.ContentsText <- c(  'textInput("title", label="title",value="")'
                     , 'checkboxGroupInput("icons", "Choose icons:",\nchoiceNames=list(icon("calendar"),icon("bed")),\nchoiceValues=list("calendar","bed")),\ntextOutput("txt")'
                     , 'dateInput("date2", "Date:")'
                     , 'dateRangeInput("daterange4", "Date range:",start = Sys.Date()-10,end = Sys.Date()+10)'
                     , 'fileInput("file",label = "Input File:"),\ntableOutput("contents")'
                     , 'numericInput("obs1", "Obs:", 10, min = 1, max = 100),\nverbatimTextOutput("value")'
                     , 'radioButtons("rb", "Choose one:", c("A" = "1","B" = "2","C" = "3")\n),\ntextOutput("txt2")'
                     , 'sliderInput("obs", "Number of observations:",min = 0, max = 1000, value = 500),\nplotOutput("distPlot",height = 150)'
                     , 'selectInput("moji","Choose:",list(`group1`=c("A","B","C"),`group2`=c("D","E","F"))),\ntextOutput("result")'
                     , 'actionButton("save","save data"),\nverbatimTextOutput("comment_button")'
                     , 'tabsetPanel(\ntabPanel("tabA",h3("testA")),\ntabPanel("tabB",h3("testB"))\n)'
                     , 'plotlyOutput("plotly")'
                     , 'plotOutput("ggplot",height=200)'
                     , 'imageOutput("myImages")'
                     , 'leafletOutput("mymap")'
                     , 'imageOutput("myImage",click = "image_click"),\nverbatimTextOutput("info")'
                     , 'plotOutput("plot1",click ="plot_click"),\nverbatimTextOutput("info2")'
                     , 'grVizOutput("diagram",width ="100%",height="300px")'
                     , 'visNetworkOutput("network")'
                     , 'verbatimTextOutput("verba_text")'
                     , 'dataTableOutput("DT1")')
UI.ContentsText


UI.ContentsName <- c('ui.textinput',      
                     'ui.checkbox',       
                     'ui.dateinput',      
                     'ui.daterangeinput', 
                     'ui.fileinput',      
                     'ui.numericinput',   
                     'ui.radiobutton',    
                     'ui.sliderinput',    
                     'ui.selectinput',    
                     'ui.actionbutton',   
                     'ui.tab',            
                     'ui.plotly',         
                     'ui.ggplot',         
                     'ui.image',          
                     'ui.leaflet',        
                     'ui.clickimage',     
                     'ui.clickplot',      
                     'ui.diagram',        
                     'ui.visnet',         
                     'ui.verbatimtext',   
                     'ui.datatable'   )  
UI.ContentsName


UI.ContentsCode <- data.frame(contentsName=UI.ContentsName,contentsText=UI.ContentsText)
UI.ContentsCode %>% tail()
write.csv(UI.ContentsCode,file = "UIContentsCode.csv", row.names=FALSE)

##########################################
ServerContentsText <- c(
'output$txt <- renderText({\nicons <- paste(input$icons,collapse = ", ");paste("You chose", icons)\n})',
'output$contents <- renderTable({\ninFile <- input$file1\nif (is.null(inFile))\nreturn(NULL)\nread.csv(inFile$datapath, header = input$header)\n})',
'output$value <- renderText({\ninput$obs1\n})',
'output$txt2 <- renderText({\npaste("You chose", input$rb)\n})',
'output$distPlot <- renderPlot({\nhist(rnorm(input$obs))\n})',
'output$result <- renderText({\npaste("You chose", input$state)\n})',
'comment_save <- eventReactive(input$save,{\ncat("saveButton was pushed"\n)})\noutput$comment_button <- renderText({\ncomment_save()\n})',
'output$ggplot <- renderPlot({\nggplot(iris,aes(Sepal.Width,Sepal.Length))+geom_point()\n})',
'output$plotly <- renderPlotly({\nplot_ly(z=volcano,type="heatmap")\n})',
'output$myImages <- renderImage({\nif(!("rlogo.png" %in% list.files(getwd()))){\nimage_read("https://www.r-project.org/logo/Rlogo.png") %>% image_write("rlogo.png")\n}\nlist(src = "rlogo.png",filetype = "image/png",width = 300,height = 300,alt = "alternate text")}, deleteFile = FALSE)',
'output$mymap <- renderLeaflet({\nleaflet() %>% \naddProviderTiles(providers$Stamen.TonerLite,options = providerTileOptions(noWrap = TRUE))} %>% \naddMiniMap(tiles = providers$Esri.WorldStreetMap,toggleDisplay = TRUE))',
'output$myImage <- renderImage({\nif("ebi_miso.JPG" %in% list.files(getwd())){\nlist(src = "ebi_miso.JPG",\nfiletype = "image/jpeg",\nwidth = 400,\nheight = 300,\nalt = "ramen")\n}\n}, deleteFile = FALSE)\noutput$info <- renderText({\npaste0("x=",input$image_click$x,"y=",input$image_click$y)\n})',
'output$plot1 <- renderPlot({\nggplot(iris,aes(Sepal.Width,Sepal.Length))+geom_point()\n})
output$info2 <- renderText({\npaste0("x=", input$plot_click$x, "\ny=", input$plot_click$y)\n})',
'output$diagram <- renderGrViz({\nnodes <-create_nodes(nodes = 1:3)\nedges <-create_edges(from = 1:3,to = c(2,3,1))\ngraph <-create_graph(nodes_df = nodes,edges_df = edges)\ngrViz({graph$dot_code})})',
'output$network <- renderVisNetwork({\nnodes <- data.frame(id = 1:3,label=1:3)\nedges <- data.frame(from = c(1,2,3), to = c(2,3,1))\nvisNetwork(nodes, edges)})',
'output$verba_text <- renderText({\ntext <- "sample text"\n})',
'output$DT1 <- renderDataTable({\nhead(iris[,c(1,2)],3) },options = list(pageLength = 5,searching = T))')

ServerContentsText

ServerContentsName <- c('server.checkbox',
                     'server.fileinput',
                     'server.numericinput',
                     'server.radiobutton',
                     'server.sliderinput',
                     'server.selectinput',
                     'server.actionbutton',
                     'server.ggplot',
                     'server.plotly',
                     'server.image',
                     'server.leaflet',
                     'server.clickimage',
                     'server.clickplot',
                     'server.diagram',
                     'server.visnet',
                     'server.verbatimtext',
                     'server.datatable')
ServerContentsName

ServerContentsCode <- data.frame(contentsName=ServerContentsName,contentsText=ServerContentsText)
ServerContentsCode %>% tail()
write.csv(ServerContentsCode,file = "ServerContentsCode.csv", row.names=FALSE)



