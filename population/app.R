library(shiny)
library(ggplot2)
library(dplyr)

# Load data
pop_data <- readRDS("population_data.rds")

# Get unique county names
counties <- unique(gsub(".*,\\s*", "", pop_data$NAME))

ui <- fluidPage(
  titlePanel("Virginia Population by County"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("county", 
                  "Select County:",
                  choices = counties)
    ),
    
    mainPanel(
      plotOutput("populationPlot")
    )
  )
)

server <- function(input, output) {
  output$populationPlot <- renderPlot({
    # Filter data for selected county
    county_data <- pop_data %>%
      filter(grepl(paste0(", ", input$county), NAME))
    
    # Create histogram
    ggplot(county_data, aes(x = population)) +
      geom_histogram(fill = "steelblue", bins = 10) +
      labs(title = paste("Population Distribution in", input$county, "Census Tracts"),
           x = "Population",
           y = "Number of Tracts") +
      theme_minimal()
  })
}

shinyApp(ui = ui, server = server)