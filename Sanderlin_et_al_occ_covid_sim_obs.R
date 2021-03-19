# COVID model
# RMRS 
# Author: Jessie Golding, Jamie Sanderlin, Taylor Wilcox
# Date: 08/21/2020

# Code purpose: create files for running COVID simulations
# Function

#################################### Intro #####################################

# Name: sc1_sim_obs
# Description:  function to simulate observation  of a population at multiple sites
#               with two states of people at a site (infected and not infected) 
#               and repeat sampling events with a known number of samples taken 
#               at each event

################################## Creation ####################################

# Author: Jessie Golding, Jamie Sanderlin
# Date Updated: 8/21/2020

################################# Arguments ####################################
# z:
#       Occupancy of covid virus at each person. 0 or 1.
#       Manuscript terminology: psi subscript I
# mu.pop: 
#       Number of people per county. Whole number.
#       Manuscript terminology: Average county population
# n.counties:
#       Number of counties. Whole number.
#       Manuscript terminology: County
# p.test:
#       Test sensitivity. Between 0 and 1.
#       Manuscript terminology: Test sensitivity
# p.init.samp:
#       Proportion of county intially sampled. Between 0 and 1.
#       Manuscript terminology: Proportion of sampled individuals
# p.rep1.samp:
#       Proportion of people intially sampled that are resampled in repeat 1. Between 0 and 1.
#       Manuscript terminology: Proportion of sampled individuals with repeat swabs
# p.rep2.samp:
#       Proportion of people intially sampled that are resampled in repeat 2. Between 0 and 1.
#       Manuscript terminology: Proportion of sampled individuals with repeat swabs
# p.rep3.samp:
#       Proportion of people intially sampled that are resampled in repeat 3. Between 0 and 1.
#       Manuscript terminology: Proportion of sampled individuals with repeat swabs
# p.rep4.samp:
#       Proportion of people intially sampled that are resampled in repeat 4. Between 0 and 1.
#       Manuscript terminology: Proportion of sampled individuals with repeat swabs

################################## Output ######################################

# obsdata list saved to global environment. Contains p.test, y1, yselect, p.eff,
# n.obs, site (index value for site), event (index value for event), swab (index
# value for swab), n.events, n.swabs, n.init.samp (number of initial samples per county),
# n.rep1.samp (number of repeat samples per county), 
# n.rep2.samp (number of second repeat samples per county)

################################################################################
sc1_sim_obs <- function(z, p.test, n.counties, p.init.samp, p.rep1.samp, p.rep2.samp, p.rep3.samp, p.rep4.samp){
  
  # Effective detection probability
  p.eff <-z*p.test
  
  #Create indexing values
  n.init.samp = round(mu.pop*p.init.samp)
  n.rep1.samp = round(n.init.samp*p.rep1.samp)
  n.rep2.samp = round(n.init.samp*p.rep2.samp)
  n.rep3.samp = round(n.init.samp*p.rep3.samp)
  n.rep4.samp = round(n.init.samp*p.rep4.samp)
  n.obs <-mu.pop*n.counties
  county <-rep(1:n.counties, each = mu.pop)
  init.samp <-rep(c((rep(1, n.init.samp)), (rep(NA,mu.pop-n.init.samp))),n.counties)
  rep1.samp <-rep(c((rep(1, n.rep1.samp)), (rep(NA,mu.pop-n.rep1.samp))),n.counties)
  rep2.samp <-rep(c((rep(1, n.rep2.samp)), (rep(NA,mu.pop-n.rep2.samp))),n.counties)
  rep3.samp <-rep(c((rep(1, n.rep3.samp)), (rep(NA,mu.pop-n.rep3.samp))),n.counties)
  rep4.samp <-rep(c((rep(1, n.rep4.samp)), (rep(NA,mu.pop-n.rep4.samp))),n.counties)
  
  y1<-matrix(data=NA, nrow = mu.pop*n.counties, ncol = 12)
  colnames(y1)<-c("county","init.samp","detect.init","rep1.samp","detect.rep1","rep2.samp","detect.rep2","rep3.samp","detect.rep3","rep4.samp","detect.rep4","person")
  y1[,1] <-as.vector(county)
  y1[,2] <-as.vector(init.samp)
  y1[,4] <-as.vector(rep1.samp)
  y1[,6] <-as.vector(rep2.samp)
  y1[,8] <-as.vector(rep3.samp)
  y1[,10] <-as.vector(rep4.samp)
  y1[,12] <-as.vector(replicate(n.counties, sample(1:mu.pop,mu.pop,replace=FALSE)))
  
  for(i in 1:n.obs){
    y1[i,3] <- rbinom(1,1,p.eff[y1[i,12],county[i]])*y1[i,2]
    y1[i,5] <- rbinom(1,1,p.eff[y1[i,12],county[i]])*y1[i,4]
    y1[i,7] <- rbinom(1,1,p.eff[y1[i,12],county[i]])*y1[i,6]
    y1[i,9] <- rbinom(1,1,p.eff[y1[i,12],county[i]])*y1[i,8]
    y1[i,11] <- rbinom(1,1,p.eff[y1[i,12],county[i]])*y1[i,10]
  }
  
  obsdata <- list("p.test"= p.test, "y1"= y1, "p.eff"= p.eff,
                  "n.obs"= n.obs, "county" = county, 
                  "p.init.samp" = p.init.samp,"p.rep1.samp" = p.rep1.samp,
                  "p.rep2.samp" = p.rep2.samp,"p.rep3.samp" = p.rep3.samp,
                  "p.rep4.samp" = p.rep4.samp,"n.init.samp" = n.init.samp,
                  "n.rep1.samp"= n.rep1.samp,"n.rep2.samp"= n.rep2.samp,
                  "n.rep3.samp"= n.rep3.samp,"n.rep4.samp"= n.rep4.samp)
  list2env(obsdata ,.GlobalEnv)
}

