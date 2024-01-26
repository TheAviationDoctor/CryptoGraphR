# ==============================================================================
#    NAME: scripts/1_download.R
#   INPUT: User's API key from https://min-api.cryptocompare.com/
# ACTIONS: Calls an API to download the historical price data for any crypto
#  OUTPUT: Data saved to a local file
# RUNTIME: ~4 seconds
#  AUTHOR: Thomas D. Pellegrin <thomas@pellegr.in>
#    YEAR: 2024
# ==============================================================================

# ==============================================================================
# 0 Housekeeping
# ==============================================================================

# Clear the environment
rm(list = ls())

# Load the required libraries
library(httr)

# Start a script timer
start_time <- Sys.time()

# Clear the console
cat("\014")

# ==============================================================================
# 1 Download the data
# ==============================================================================

# URL of the API
url <- "https://min-api.cryptocompare.com/data/v2/histoday?fsym=ETH&tsym=USD&allData=true&api_key="

# Your API key
api <- readChar(".api", 99)

# Set local data file
dat <- "data/eth_usd.dat"

# Save the data
res <- GET(url = paste(url, api, sep = ""), write_disk(dat, overwrite = TRUE))

# ==============================================================================
# 2 Housekeeping
# ==============================================================================

# Stop the script timer
Sys.time() - start_time

# EOF