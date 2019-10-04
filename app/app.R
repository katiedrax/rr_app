# install packages

library(shiny)
library(tidyverse)
library(googlesheets)

##################
#### import data ####
###################

# register sheet via url
df <- googlesheets::gs_url("https://docs.google.com/spreadsheets/d/1D4_k-8C_UENTRtbPzXfhjEyu3BfLxdOsn9j-otrO870/edit#gid=0") %>%
  #read in
  googlesheets::gs_read(skip = 1)

#df <- read.csv(file = "data/Comparison of Registered Reports - Sheet1.csv", stringsAsFactors = F, header = T, skip =1,
               #na.strings = c("", NA), encoding = "UTF-8") 

#df <- rename(df, "Includes pre-study peer review" = "X1..Includes.pre.study.peer.review", "Offers provisional pre-study acceptance" = "X2..Offers.provisional.pre.study.acceptance")

##################
#### clean data ####
###################  

# remove all rows without a journal

df <- df[!is.na(df$Journal),]

# replace unicode tick
df[] <- lapply(df, function(x) gsub("[\u2713]", "Yes", x))

# replace NA with no

df[is.na(df)] <- "No"

# replace TBD

df[df == "TBD"] <- "To be decided"

# replace TBA

df[df == "TBA"] <- "To be announced"

# clean headers

colnames(df) <- gsub("[0-9]\\. |[0-9][0-9]\\. ","", colnames(df))

# replace all carriage return separately (lapply with str_replace_all, trimws and gsub doesn't seem to work)


df$`Offered for meta-analysis` <- gsub("[\n]", "No", df$`Offered for meta-analysis`)
df$`Offered for analyses of existing data sets` <- gsub("[\n]", "No", df$`Offered for analyses of existing data sets`)
df$`Publishes Registered Reports only`<- gsub("[\n]", "No", df$`Publishes Registered Reports only`)
df$`Publishes accepted protocols, in full or part, prior to study completion`<- gsub("[\n]", "No", df$`Publishes accepted protocols, in full or part, prior to study completion`)
df$`Offers incremental (sequential) registration`<- gsub("[\n]", "No", df$`Offers incremental (sequential) registration`)
df$`Offers incremental addition of unregistered studies`<- gsub("[\n]", "No", df$`Offers incremental addition of unregistered studies`)
df$`Offered for qualitative research`<- gsub("[\n]", "No", df$`Offered for qualitative research`)


# subset rows that do not have pre-study peer review OR don't offer IPA

not_rr <- df[(df$`Includes pre-study peer review`!= "Yes" | df$`Offers provisional pre-study acceptance` != "Yes"),]

# subset rows that have pre-study peer review AND IPA

rr <- df[(df$`Includes pre-study peer review`== "Yes" & df$`Offers provisional pre-study acceptance` == "Yes"),]

######
#app###
#####

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Comparison of Registered Reports"),
  
  # Sidebar with a select input for variables
  sidebarLayout(
    sidebarPanel(
      #heading
      h1("Select variable", align = "left"),
      
      # help text
      helpText("Select which variable you want to examine across journals offering Registered Reports"),
      
      # select input
      selectInput("vars", "Variable", colnames(rr)),
      
      # data source info
      hr(),
      h2("The data"),
      textOutput("rr_n"),
      p(),
      textOutput("not_rr_n"),
      p(),
      helpText("Data from the Center for Open Science which can be found here:"), 
      a("Comparison of Registered Reports Google Sheet", href = "https://docs.google.com/spreadsheets/d/1D4_k-8C_UENTRtbPzXfhjEyu3BfLxdOsn9j-otrO870/edit#gid=0")
    ),
    
    # main panel is a table
    mainPanel(
      tableOutput("table")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  ##############
  #### define input ####
  ###############
  
  observe({
    #define input as variables in rr
    updateSelectInput(session, "vars", choices = colnames(rr))
  })
  
  ################
  #### define output ####
  ################
  
  output$rr_n <- renderText({
    paste("To date (", format(Sys.time(), "%a %b %d"), ")", length(unique(rr$Journal)), "journals offer Registered Reports.", sep = " ")
  })
  
  output$not_rr_n <- renderText({
    paste(length(unique(not_rr$Journal)), 
          "journals offer formats that do not qualify as Registered Reports but provide some similar features.", sep = " ")
  })
  
  output$table <- renderTable({
    # output table of each variable
    var <- subset(rr, select = input$vars)
    table(var, useNA = "ifany", dnn = colnames(var))
  })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)

