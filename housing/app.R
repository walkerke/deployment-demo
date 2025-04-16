library(shiny)
library(ggplot2)
library(dplyr)

# Load data
housing_data <- readRDS("housing_data.rds")

# Get unique county names
counties <- unique(gsub(".*,\\s*", "", housing_data$NAME))

ui <- fluidPage(
  titlePanel("Virginia Housing Units by County"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("county", 
                  "Select County:",
                  choices = counties)
    ),
    
    mainPanel(
      plotOutput("housingPlot")
    )
  )
)

server <- function(input, output) {
  output$housingPlot <- renderPlot({
    # Filter data for selected county
    county_data <- housing_data %>%
      filter(grepl(paste0(", ", input$county), NAME))
    
    # Create histogram
    ggplot(county_data, aes(x = housing_units)) +
      geom_histogram(fill = "darkgreen", bins = 10) +
      labs(title = paste("Housing Units Distribution in", input$county, "Census Tracts"),
           x = "Housing Units",
           y = "Number of Tracts") +
      theme_minimal()
  })
}

shinyApp(ui = ui, server = server)