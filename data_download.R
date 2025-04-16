library(tidycensus)
library(tidyverse)
library(usethis)
library(gert)

year <- 2022

# Initialize git repo if not already done
if (!dir.exists(".git")) {
    usethis::use_git()
}

# Set Census API key - replace with your key
# census_api_key("YOUR_API_KEY_HERE")

# Get VA county population data
va_pop <- get_acs(
    geography = "tract",
    variables = "B01003_001",
    state = "VA",
    year = year
) %>%
    mutate(year = year)

# Get VA housing data
va_housing <- get_acs(
    geography = "tract",
    variables = "B25001_001",
    state = "VA",
    year = year
) %>%
    mutate(year = year)

# Get VA income data
va_income <- get_acs(
    geography = "tract",
    variables = "B19013_001",
    state = "VA",
    year = year
) %>%
    mutate(year = year)

# Save data to respective app directories
write_rds(va_pop, "population/population_data.rds")
write_rds(va_housing, "housing/housing_data.rds")
write_rds(va_income, "income/income_data.rds")

cat("Data downloaded and saved to app directories.\n")


# git_remote_add(url = "https://github.com/walkerke/deployment-demo.git")

deploy_apps <- function() {
    # Stage all changes
    git_add(".")

    # Commit changes
    git_commit("Update apps and data")

    git_push()
}

deploy_apps()
cat("Apps deployed and changes pushed to GitHub.\n")
