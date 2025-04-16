library(shiny)
library(tidyverse)

x <- "test"

ctys <- c(
    "Accomack County",
    "Albemarle County",
    "Alexandria city",
    "Alleghany County",
    "Amelia County",
    "Amherst County",
    "Appomattox County",
    "Arlington County",
    "Augusta County",
    "Bath County",
    "Bedford County",
    "Bland County",
    "Botetourt County",
    "Bristol city",
    "Brunswick County",
    "Buchanan County",
    "Buckingham County",
    "Buena Vista city",
    "Campbell County",
    "Caroline County",
    "Carroll County",
    "Charles City County",
    "Charlotte County",
    "Charlottesville city",
    "Chesapeake city",
    "Chesterfield County",
    "Clarke County",
    "Colonial Heights city",
    "Covington city",
    "Craig County",
    "Culpeper County",
    "Cumberland County",
    "Danville city",
    "Dickenson County",
    "Dinwiddie County",
    "Emporia city",
    "Essex County",
    "Fairfax city",
    "Fairfax County",
    "Falls Church city",
    "Fauquier County",
    "Floyd County",
    "Fluvanna County",
    "Franklin city",
    "Franklin County",
    "Frederick County",
    "Fredericksburg city",
    "Galax city",
    "Giles County",
    "Gloucester County",
    "Goochland County",
    "Grayson County",
    "Greene County",
    "Greensville County",
    "Halifax County",
    "Hampton city",
    "Hanover County",
    "Harrisonburg city",
    "Henrico County",
    "Henry County",
    "Highland County",
    "Hopewell city",
    "Isle of Wight County",
    "James City County",
    "King and Queen County",
    "King George County",
    "King William County",
    "Lancaster County",
    "Lee County",
    "Lexington city",
    "Loudoun County",
    "Louisa County",
    "Lunenburg County",
    "Lynchburg city",
    "Madison County",
    "Manassas city",
    "Manassas Park city",
    "Martinsville city",
    "Mathews County",
    "Mecklenburg County",
    "Middlesex County",
    "Montgomery County",
    "Nelson County",
    "New Kent County",
    "Newport News city",
    "Norfolk city",
    "Northampton County",
    "Northumberland County",
    "Norton city",
    "Nottoway County",
    "Orange County",
    "Page County",
    "Patrick County",
    "Petersburg city",
    "Pittsylvania County",
    "Poquoson city",
    "Portsmouth city",
    "Powhatan County",
    "Prince Edward County",
    "Prince George County",
    "Prince William County",
    "Pulaski County",
    "Radford city",
    "Rappahannock County",
    "Richmond city",
    "Richmond County",
    "Roanoke city",
    "Roanoke County",
    "Rockbridge County",
    "Rockingham County",
    "Russell County",
    "Salem city",
    "Scott County",
    "Shenandoah County",
    "Smyth County",
    "Southampton County",
    "Spotsylvania County",
    "Stafford County",
    "Staunton city",
    "Suffolk city",
    "Surry County",
    "Sussex County",
    "Tazewell County",
    "Virginia Beach city",
    "Warren County",
    "Washington County",
    "Waynesboro city",
    "Westmoreland County",
    "Williamsburg city",
    "Winchester city",
    "Wise County",
    "Wythe County",
    "York County"
)

# Load data
housing_data <- read_rds("housing_data.rds")


ui <- fluidPage(
    titlePanel("Virginia Housing Units by County"),

    sidebarLayout(
        sidebarPanel(
            selectInput("county", "Select County:", choices = ctys)
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
            filter(str_detect(NAME, input$county))

        acs_end <- as.numeric(unique(county_data$year))
        acs_start <- acs_end - 4

        # Create histogram
        ggplot(county_data, aes(x = estimate)) +
            geom_histogram(fill = "darkgreen", bins = 10) +
            labs(
                title = paste(
                    "Housing Units Distribution in",
                    input$county,
                    "Census Tracts"
                ),
                subtitle = paste0(acs_start, "-", acs_end, " ACS"),
                x = "Housing Units",
                y = "Number of Tracts"
            ) +
            theme_minimal()
    })
}

shinyApp(ui = ui, server = server)
