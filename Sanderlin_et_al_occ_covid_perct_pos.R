# COVID model
# RMRS 
# Author: Jamie Sanderlin, Jessie Golding, Taylor Wilcox
# Date: 08/21/2020

# Code purpose: create files for running COVID simulations
# Function

#################################### Intro #####################################

# Name: sc1_posi
# Description:  function to calculate percent positive out of all tests from the observed samples.
# This will provide a comparison to the reported measure of percent positive that is used to
# make decisions, which is not individual based (i.e., repeated tests of individuals are not 
# accounted for within the observed reported measure, which is also not accounting for 
# uncertainty in testing)

################################## Creation ####################################

# Author: Jessie Golding, Jamie Sanderlin
# Date Updated: 08/21/2020

################################# Arguments ####################################
# data:
#       List of data to use for calculation of percent positive in observed samples.

sc1_sim_posi <- function(data){

  p.pos <-(sum(y1[1:n.init.samp,3],y1[1:n.rep1.samp,5],y1[1:n.rep2.samp,7],y1[1:n.rep3.samp,9],y1[1:n.rep4.samp,11],na.rm=TRUE))/(sum(y1[1:n.init.samp,2],y1[1:n.rep1.samp,4],y1[1:n.rep2.samp,6],y1[1:n.rep3.samp,8],y1[1:n.rep2.samp,10],na.rm=TRUE))

  p.pos
}