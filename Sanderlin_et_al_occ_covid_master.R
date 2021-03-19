# COVID model
# RMRS 
# Author: Jessie Golding, Jamie Sanderlin 
# Date: 08/21/2020

# Code purpose: create files for running COVID simulations

################################################################################
## Load functions 
############# UPDATE WITH DIRECTORY FOR YOUR COMPUTER ############## 
source("C:/Users/jgolding/Box/COVID-Modeling/3000_data/3100_rcode/BMC_Public_Health_final_code/Sanderlin_et_al_occ_covid_load_packages.R")
source("C:/Users/jgolding/Box/COVID-Modeling/3000_data/3100_rcode/BMC_Public_Health_final_code/Sanderlin_et_al_occ_covid_sim_bio.R")
source("C:/Users/jgolding/Box/COVID-Modeling/3000_data/3100_rcode/BMC_Public_Health_final_code/Sanderlin_et_al_occ_covid_sim_obs.R")
source("C:/Users/jgolding/Box/COVID-Modeling/3000_data/3100_rcode/BMC_Public_Health_final_code/Sanderlin_et_al_occ_covid_run_model.R")
source("C:/Users/jgolding/Box/COVID-Modeling/3000_data/3100_rcode/BMC_Public_Health_final_code/Sanderlin_et_al_occ_covid_perct_pos.R")

### Repitition of simulation
# Specify number of times to repeat each simulation
n.reps <-5

# Create empty list to hold rep info
fit <- list()

for(q in 1:n.reps){
  # Time each rep
  ptm <- proc.time()
  
  ## Simulate Data
  # Biological process
  sc1_sim_bio(n.counties = 1, mu.pop = 25000, psi.infected = 0.10)
  
  # Observation process
  sc1_sim_obs(z = z, p.test = 0.78, n.counties = n.counties, p.init.samp = 0.05, p.rep1.samp = 0.1, p.rep2.samp = 0.1, p.rep3.samp = 0.1, p.rep4.samp = 0.1)
  
  ## List data for running model
  # Main data
  data <- list(y1=y1,
               mu.pop = mu.pop, 
               population = population, 
               n.counties = n.counties,
               n.obs = n.obs,
               county = county, 
               n.init.samp = n.init.samp,
               n.rep1.samp = n.rep1.samp,
               n.rep2.samp = n.rep2.samp,
               n.rep3.samp = n.rep3.samp,
               n.rep4.samp = n.rep4.samp)
  
  #calculate observed percent positive
  per.positive <- sc1_sim_posi(data)
  
  # Initial value data
  inits <- function() {
    list(z = z)
  }
  
  # Parameters for the model to keep track of
  params <- c("psi_infected", "p","infect","uninfect")
  
  ## Run model
  out <-sc1_run(data = data, inits = inits, params = params, ni= 10000, nt = 1, nb = 1000, nc = 3, na = 1000)
  #add observed percent positive to output
  finalout <- c(out,per.positive)
  time <-proc.time() - ptm
  name <-paste("rep",q,"_",n.counties,"county", "_", mu.pop, "pop", 
               "_", psi.infected,"psi", "_", p.test,"ptest", 
               "_", ifelse(p.init.samp*100<100&p.init.samp*100>9,paste(0,p.init.samp*100,sep=""),
                           ifelse(p.init.samp*100<10,paste(0,0,p.init.samp*100,sep=""),p.init.samp*100)),"psamp",
               "_", ifelse(p.rep1.samp*100<100&p.rep1.samp*100>9,paste(0,p.rep1.samp*100,sep=""),
                           ifelse(p.rep1.samp*100<10,paste(0,0,p.rep1.samp*100,sep=""),p.rep1.samp*100)), "pr1",
               "_", ifelse(p.rep2.samp*100<100&p.rep2.samp*100>9,paste(0,p.rep2.samp*100,sep=""),
                           ifelse(p.rep2.samp*100<10,paste(0,0,p.rep2.samp*100,sep=""),p.rep2.samp*100)),"pr2",
               "_", ifelse(p.rep3.samp*100<100&p.rep3.samp*100>9,paste(0,p.rep3.samp*100,sep=""),
                           ifelse(p.rep3.samp*100<10,paste(0,0,p.rep3.samp*100,sep=""),p.rep3.samp*100)),"pr3",
               "_", ifelse(p.rep4.samp*100<100&p.rep4.samp*100>9,paste(0,p.rep4.samp*100,sep=""),
                           ifelse(p.rep4.samp*100<10,paste(0,0,p.rep4.samp*100,sep=""),p.rep4.samp*100)),"pr4",
               sep="")
  
  ############# UPDATE WITH APPROPRIATE DIRECTORY FOR YOUR COMPUTER ############## 
  save(finalout,file= paste0 ("C:/Users/jgolding/Box/COVID-Modeling/3000_data/3100_rcode/BMC_Public_Health_final_code/test/", name))

  fit[[q]]<-list(name, finalout, time)
}



