# install packages

library(shiny)

rr <- read.csv("../data/Comparison of Registered Reports - Sheet1.csv", skip = 1)

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
      mainPanel(
        tableOutput("table")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

  observe({
    updateSelectInput(session, "vars", choices = colnames(rr))
  })
  
  output$table <- renderTable({
    subset(rr, select = input$vars)
  })
   

}

# Run the application 
shinyApp(ui = ui, server = server)

