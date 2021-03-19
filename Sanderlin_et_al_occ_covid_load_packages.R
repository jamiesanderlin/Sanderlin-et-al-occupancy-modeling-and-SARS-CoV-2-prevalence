# COVID model
# RMRS 
# Author: Jessie Golding 
# Date: 8/25/2020

# Code purpose: create files for running COVID simulations
# Load packages (check if installed and if not install them)

################################################################################
## Load required packages
# Function from https://vbaliga.github.io/verify-that-r-packages-are-installed-and-loaded/
## First specify the packages of interest
packages = c("jagsUI", "mcmcplots","reshape2","here",
             "dplyr", "ggplot2","psych", "extraDistr")

## Now load or install&load all
package.check <- lapply(
  packages,
  FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
      library(x, character.only = TRUE)
    }
  }
)


