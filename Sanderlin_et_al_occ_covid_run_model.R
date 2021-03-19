# COVID model
# RMRS 
# Author: Jessie Golding, Jamie Sanderlin, Taylor Wilcox
# Date: 08/21/2020

# Code purpose: create files for running COVID simulations
# Function

#################################### Intro #####################################

# Name: sc1_run
# Description:  function to run bayesian heirarchical model of biological 
#               conditions of a population at multiple sites with two states of 
#               people at a site (infected and not infected), governed by a 
#               given prevalance of covid infection (sc1_sim_bio). 

################################## Creation ####################################

# Author: Jessie Golding, Jamie Sanderlin
# Date Updated: 08/21/2020

################################# Arguments ####################################
# data:
#       List of data to use for model.
# inits: 
#       Initial values for z (occupancy of virus).
# params: 
#       Parameters to keep track of.
# ni: 
#       Number of iterations to run the Bayesian model.
# nt: 
#       Thinning parameter for JAGS.
# nb: 
#       Number of burn in iterations.
# nc: 
#       Number of MCMC chains to run.
# na: 
#       Adapt parameter - number of adaptive iterations to start the simulation .

################################## Output ######################################

# out, a large jags list object saved to global environment

################################################################################
sc1_run <- function(data, inits, params, ni, nt, nb, nc, na){

  ### JAGS MODEL
  sink("Model.txt")
  cat("
    model{
    # Priors
    # inf
    psi_infected ~ dunif(0.1, 1)  
    
    # test sensitivity
    p ~ dunif(0.1, 1)   
    
    for(i in 1:mu.pop){
    for (j in 1:n.counties){
      # Biological model
      z[i,j] ~ dbern(psi_infected)
      
      # Detection model - random sample
      p.eff[i,j] <-z[i,j] * p
    }
    }
    
    # Derived abundance values in each class
    for (i in 1:n.counties){
      uninfect[i] <-population[i]-sum(z[,i])
      infect[i] <-sum(z[,i])
    }
    
    for (i in 1:n.obs){
      y1[i,3] ~ dbern(p.eff[y1[i,12],county[i]]) 
      y1[i,5] ~ dbern(p.eff[y1[i,12],county[i]]) 
      y1[i,7] ~ dbern(p.eff[y1[i,12],county[i]])
      y1[i,9] ~ dbern(p.eff[y1[i,12],county[i]])
      y1[i,11] ~ dbern(p.eff[y1[i,12],county[i]])
    }
    }
    ", fill = TRUE)
  sink()
  
  out<- list(jags(data=data, inits=inits, parameters.to.save = params, "Model.txt",
                         n.chains=nc,n.thin=nt, n.iter=ni, n.burnin=nb, n.adapt=na,
                         parallel = TRUE))
  out
}
