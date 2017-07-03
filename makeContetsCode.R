ServerContentsCode <- read.csv("ServerContentsCode.csv", header = T,stringsAsFactors = F)
ServerContentsCode$contentsName->name
ServerContentsCode$contentsText->text
name
name2 <- c("server.textinput",name[4],name[3],name[5],name[6],"server.dateinput","server.daterangeinput",name[2],name[7],"server.checkboxgroupinput",
           name[8],name[9],name[10],name[11],name[12],name[13],name[14],name[15],name[16],name[17]);name2

# text <- as.character(text)
text
text2 <- c("",text[4],text[3],text[5],text[6],"","",text[2],text[7],text[1],text[8],text[9],text[10],
           text[11],text[12],text[13],text[14],text[15],text[16],text[17]);text2

data <- data.frame(contentsName=name2,contentsText=text2)
data[,1]
data[,2]
write.csv(data,file = "ServerContentsCode.csv", row.names=FALSE)


x <- letters[1:10]
paste(x[2:3],collapse = ",")


x <- c("a","b","","d","","f");x
x <- x[!(x=="")]  
paste(x,collapse = ",")


UIContentsCode <- read.csv("UIContentsCode.csv", header = T,stringsAsFactors = F)
UIContentsCode[,1]
UIContentsCode[,2]
UIContentsCode %>% head()
ServerContentsCode[,1]

name <- character() 
text <- character()

insertdata <- function(n,UI){
  name[n] <<- UIContentsCode[UI,1]
  text[n] <<- UIContentsCode[UI,2]
}
insertdata(20,21)
name
text
data <- data.frame(contentsName=name,contentsText=text)
data[1,]
data[,2]
write.csv(data,file = "UIContentsCode.csv", row.names=FALSE)
