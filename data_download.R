library(tidycensus)
library(dplyr)
library(purrr)
library(usethis)
library(gert)

year <- 2023

# Initialize git repo if not already done
if (!dir.exists(".git")) {
    usethis::use_git()
}

# Set Census API key - replace with your key
# census_api_key("YOUR_API_KEY_HERE")

# Get VA county population data
va_pop <- get_acs(
    geography = "tract",
    variables = "B01003_001", # Total population
    state = "VA",
    year = year
) %>%
    rename(population = estimate)

# Get VA housing data
va_housing <- get_acs(
    geography = "tract",
    variables = "B25001_001", # Total housing units
    state = "VA",
    year = year
) %>%
    rename(housing_units = estimate)

# Get VA income data
va_income <- get_acs(
    geography = "tract",
    variables = "B19013_001", # Median household income
    state = "VA",
    year = year
) %>%
    rename(median_income = estimate)

# Save data to respective app directories
saveRDS(va_pop, "population/population_data.rds")
saveRDS(va_housing, "housing/housing_data.rds")
saveRDS(va_income, "income/income_data.rds")

# Deploy function
deploy_apps <- function() {
    # Stage all changes
    gert::git_add(".")

    # Commit changes
    gert::git_commit("Update apps and data")

    # Initialize GitHub repo if not already done
    if (length(git_remote_list()) == 0) {
        # Create GitHub repository - this will open browser for authentication
        usethis::use_github(private = FALSE)
    } else {
        # Push to GitHub if repo exists
        gert::git_push()
    }
}

# Call deploy_apps() when you want to deploy
# deploy_apps()

cat("Data downloaded and saved to app directories.\n")
cat("Run deploy_apps() to commit and push to GitHub.\n")
