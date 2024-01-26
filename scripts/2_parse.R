# ==============================================================================
#    NAME: scripts/2_parse.R
#   INPUT: Crypto historical price data
# ACTIONS: Parse the JSON format
#  OUTPUT: Time series of daily prices
# RUNTIME: ~1 seconds
#  AUTHOR: Thomas D. Pellegrin <thomas@pellegr.in>
#    YEAR: 2024
# ==============================================================================

# ==============================================================================
# 0 Housekeeping
# ==============================================================================

# Clear the environment
rm(list = ls())

# Load the required libraries
library(jsonlite)
library(tidyverse)

# Start a script timer
start_time <- Sys.time()

# Clear the console
cat("\014")

# ==============================================================================
# 1 Parse the data
# ==============================================================================

# Set local data file
dat <- "data/eth_usd.dat"

# Parse the data
df <- fromJSON(dat)$Data$Data |>
  as.data.frame() |>
  select(time, close) |>
  subset(close > 0) |>
  mutate(time = as.POSIXct(time, origin = "1970-01-01"))

# Plot the data
hist(x = df$close, breaks = 100L, main = "ETH/USD", xlab = "Price (USD)", ylab = "Days")

# Add the mean
abline(v = mean(df$close), col = "red", lwd = 2L)
text(x = mean(df$close) + 100, y = 635, col = "red", labels = round(mean(df$close)))

# Add the median
abline(v = median(df$close), col = "blue", lwd = 2L)
text(x = median(df$close) + 100, y = 635, col = "blue", labels = round(median(df$close)))

# ==============================================================================
# 2 Housekeeping
# ==============================================================================

# Stop the script timer
Sys.time() - start_time

# EOF