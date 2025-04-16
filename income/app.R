library(shiny)
library(ggplot2)
library(dplyr)

# Load data
income_data <- readRDS("income_data.rds")

# Get unique county names
counties <- unique(gsub(".*,\\s*", "", income_data$NAME))

ui <- fluidPage(
  titlePanel("Virginia Median Income by County"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("county", 
                  "Select County:",
                  choices = counties)
    ),
    
    mainPanel(
      plotOutput("incomePlot")
    )
  )
)

server <- function(input, output) {
  output$incomePlot <- renderPlot({
    # Filter data for selected county
    county_data <- income_data %>%
      filter(grepl(paste0(", ", input$county), NAME))
    
    # Create histogram
    ggplot(county_data, aes(x = median_income)) +
      geom_histogram(fill = "darkred", bins = 10) +
      labs(title = paste("Median Income Distribution in", input$county, "Census Tracts"),
           x = "Median Income ($)",
           y = "Number of Tracts") +
      theme_minimal()
  })
}

shinyApp(ui = ui, server = server)