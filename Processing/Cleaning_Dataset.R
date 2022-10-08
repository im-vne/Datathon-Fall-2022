#pre-processing

source("Functions/Libraries.R")

###  Load in Data

# set path
path = "Dataset/all_data_v2"

# read all csvs
filenames = list.files(path, pattern="*.csv", full.names=TRUE)
dta = lapply(filenames, read.csv)

# change names for easier access
names(dta) = paste0("data_", 1:213)

engines = read.csv("Dataset/engine_data.csv")
sites = read.csv("Dataset/site_data.csv")

# assigning LHV from sites to engines table

engine.counts = table(engines$PLANT_NAME)

temp.sites = sites%>%arrange(sites$PLANT_NAME)
engines = engines%>%arrange(engines$PLANT_NAME)
lhv = c()
for (i in 1:45) {
  lhv = c(lhv, rep(temp.sites$FUEL_LHV[i], engine.counts[i]))
}
engines = engines%>%mutate(engines, FUEL_LHV = lhv)
engines = engines%>%arrange(FILE_ID)

# calculate thermal efficiency and add to each data_#.csv

lapply(dta, mutate(THRM_EFF = ))

for (i in 1:213){
  dta[[i]] = mutate(dta[[i]], THRM_EFF = dta[[i]]$POWER / (dta[[i]]$FUEL_FLOW * engines$FUEL_LHV[i]))
}