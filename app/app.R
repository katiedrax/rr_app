# install packages

library(shiny)

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
      selectInput("vars", "Variable", "placeholder")
    ),
    
    # main panel is a table
    mainPanel(
      tableOutput("prop")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  ##################
  #### subset data ####
  ###################
  
  # import data
  df <- read.csv("../data/Comparison of Registered Reports - Sheet1.csv", stringsAsFactors = F, skip = 1, encoding = "latin1", na.strings = c("", "NA"))
  
  # remove all rows without a journal
  
  df <- df[!is.na(df$Journal),]
  
  # replace tick
  df[] <- lapply(df, function(x) gsub("âœ“", "yes", x))
  
  # replace NA with no
  
  df[is.na(df)] <- "no"
  
  # clean headers
  
  colnames(df) <- gsub("X[0-9]\\..|X[0-9][0-9]\\..","", colnames(df))
  
  # subset rows that do not have pre-study peer review OR don't offer IPA
  not_rr <- subset(df, 
                   (is.na(df[, "Includes.pre.study.peer.review"])) | (is.na(df[, "Offers.provisional.pre.study.acceptance"])))
  
  # subset rows that have pre-study peer review AND IPA
  
  rr <- subset(df, 
               (!is.na(df[, "Includes.pre.study.peer.review"])) & (!is.na(df[, "Offers.provisional.pre.study.acceptance"])))
  
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
  
  output$prop <- renderTable({
    # output proportion table of each variable
    var <- subset(rr, select = input$vars)
    prop <- prop.table(table(var, useNA = "ifany", dnn = colnames(var)))
  })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)

