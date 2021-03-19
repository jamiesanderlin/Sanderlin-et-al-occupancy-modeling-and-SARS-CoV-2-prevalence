Data simulation and analysis for Sanderlin et al. 2021. Occupancy modeling and resampling overcomes low test sensitivity to produce accurate SARS-CoV-2 prevalence estimates. BMC Public Health. 

Programs needed to run code:
R

Files needed to run simulation:
Sanderlin_et_al_occ_covid_master.R
Sanderlin_et_al_occ_covid_load_packages.R
Sanderlin_et_al_occ_covid_sim_bio.R 
Sanderlin_et_al_occ_covid_sim_obs.R
Sanderlin_et_al_occ_covid_run_model.R 
Sanderlin_et_al_occ_covid_perct_pos.R

R Code for processing. Complete the following steps in this order:
1) Open Sanderlin_et_al_occ_covid_master.R (all code will be run from here)

2) Set the appropriate working directory for your computer that contains the files listed above.

3) Modify n.reps (line 19) according to how many times you want each simulation to repeat (the paper uses 100, but we recommend testing the functionality with a low # first and then increasing it).

4) Biological Process
Modify the following values within line 30 - sc1_sim_bio function - according to what scenario you want to test:
mu.pop = startign population (values 1 and above)
n.counties = number of counties (values 1 and above)
psi.infected = proportion of county population infected (values between 0 and 1)

5) Observation Process
Modify the following values within line 33 - sc1_sim_obs function - according to what scenario you want to test:
p.test = 0.78
p.init.samp = propoprtion of population intially tested (values between 0 and 1)
p.rep1.samp = propoprtion of population repeat tested (values between 0 and 1)
p.rep2.samp = propoprtion of repeat tested individuals repeat tested (tested for the 3rd time) (values between 0 and 1)
p.rep3.samp = propoprtion of repeat tested individuals repeat tested (tested for the 4th time)  (values between 0 and 1)
p.rep4.samp = propoprtion of repeat tested individuals repeat tested (tested for the 5th time)   (values between 0 and 1)

6) Assign output location for results
Modify line 80 with appropriate filepath for where you want to save results.