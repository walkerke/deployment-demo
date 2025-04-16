# Virginia County Data Shiny Apps

This repository contains three Shiny apps showing data for Virginia counties:

1. **Population**: Shows population distribution across census tracts by county
2. **Housing**: Shows housing units distribution across census tracts by county
3. **Income**: Shows median income distribution across census tracts by county

## Setup

1. Install required packages:
```R
install.packages(c("shiny", "tidycensus", "dplyr", "ggplot2", "usethis", "gert"))
```

2. Set your Census API key in the `data_download.R` script
3. Run `data_download.R` to fetch and save the data

## Running the apps

Navigate to each app directory and run the app:
```R
shiny::runApp("population")
shiny::runApp("housing")
shiny::runApp("income")
```

## Deployment

To deploy all apps and push to GitHub:
1. Make any necessary changes
2. Run `source("data_download.R")`
3. Run `deploy_apps()` function from the R console