#!/bin/bash
#! chmod +x deploy.sh


# Log start time
echo "Starting data download and deployment at $(date)"

# Set working directory to the script location
cd "$(dirname "$0")"

# Run R script to download and deploy data
Rscript data_download.R

# Log completion
echo "Data download and deployment completed at $(date)"
