# Load the Shiny library
library(shiny)

# Create the UI (User Interface)
ui <- fluidPage(
  
  titlePanel("CSV File Viewer"), # Title panel
  
  hr(), # Horizontal line for visual separation
  
  tabsetPanel(
    
    tabPanel("Upload CSV", # Tab named "Upload CSV"
             br(), # Add a blank line for better formatting
             fileInput("file1", "Choose CSV File", accept = ".csv"), # File input for uploading a CSV file
             tableOutput("table") # Output area to display the table
    )
    
  )
)

# Create the Server function
server <- function(input, output, session) {
  
  # Reactive function to read the CSV file
  df <- reactive({
    req(input$file1) # Input file is required, no operation is performed if a file is not selected
    read.csv(input$file1$datapath) # Read the selected CSV file
  })
  
  # Render the table by populating it with data from the CSV file
  output$table <- renderTable({
    df() # Transfer the value of the reactive function to the table
  })
}

# Start the Shiny application
shinyApp(ui = ui, server = server)
