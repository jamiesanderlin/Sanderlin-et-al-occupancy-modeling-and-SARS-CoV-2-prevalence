# COVID model
# RMRS 
# Author: Jessie Golding, Jamie Sanderlin, Taylor Wilcox
# Date: 08/21/2020

# Code purpose: create files for running COVID simulations
# Function

#################################### Intro #####################################

# Name: sc1_sim_bio
# Descirption:  function to simulate biological conditions of a population at 
#               multiple sites with two states of people at a site (infected and 
#               not infected), governed by a given prevalance of covid infection 

################################## Creation ####################################

# Author: Jessie Golding
# Date Updated: 8/5/2020

################################# Arguments ####################################
# n.counties:
#       Number of counties. Whole number.
#       Manuscript terminology: County
# mu.pop: 
#       Number of people per county. Whole number.
#       Manuscript terminology: Average county population
# psi.infected: 
#       Average occupancy of the covid infection per county. Between 0 and 1.
#       Manuscript terminology: Probability of being infected 

################################## Output ######################################

# biodata list saved to global environment. Contains n.counties, mu.pop, psi.infected,
# infected, uninfected, and z

################################################################################
sc1_sim_bio <- function(n.counties, mu.pop, psi.infected){
  
  # Total population size each location
  population <- rep(mu.pop, n.counties) 
  
  # Infection status per individual
  z <- matrix(data=NA, nrow = mu.pop, ncol = n.counties)
  for(i in 1:mu.pop){
    for (j in 1:n.counties){
      z[i,j] <- rbinom(1,1,psi.infected)
    }
  }
  
  # Number of uninfected people per location
  uninfect <- c()
  infect <- c()
  for (i in 1:n.counties){
    uninfect[i] <-population[i]-sum(z[,i])
    infect[i] <-sum(z[,i])
  }
  biodata <- list("n.counties"= n.counties, "mu.pop"=mu.pop,"population"=population, 
                  "z"= z, "uninfect" = uninfect, "infect"= infect, "psi.infected"=psi.infected)
  list2env(biodata ,.GlobalEnv)
}


