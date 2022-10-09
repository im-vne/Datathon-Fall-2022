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

# keep track of order
ind = c(1:213)
engines = engines%>%mutate(ENGINE_IND = ind)
engine.counts = table(engines$PLANT_NAME)

temp.sites = sites%>%arrange(sites$PLANT_NAME)
engines = engines%>%arrange(engines$PLANT_NAME)
lhv = c()
for (i in 1:45) {
  lhv = c(lhv, rep(temp.sites$FUEL_LHV[i], engine.counts[i]))
}

engines = engines%>%mutate(engines, FUEL_LHV = lhv)
engines = engines%>%arrange(ENGINE_IND)

# calculate thermal efficiency and add to each data_#.csv

for (i in 1:213){
  dta[[i]] = mutate(dta[[i]], THRM_EFF = dta[[i]]$POWER / (dta[[i]]$FUEL_FLOW * engines$FUEL_LHV[i]))
}

engines = engines%>% mutate(AVG_CO2 = engine_avg)
# add mean thermal efficiency and average co2 to each engine in engines
avgs.thrmeff = c()
avgs.co2 = c()
for (i in 1:213) {
  temp.thrmeff = mean(na.omit(dta[[i]]$THRM_EFF))
  avgs.thrmeff = c(avgs.thrmeff, temp.thrmeff)
  
  temp.co2 = mean(na.omit(dta[[i]]$CO2))
  avgs.co2 = c(avgs.co2, temp.co2)
}

engines = mutate(engines, AVG_THRM_EFF = avgs.thrmeff, AVG_CO2 = avgs.co2)
engines = mutate(engines, CO2_THRMEFF_RATE = AVG_CO2/AVG_THRM_EFF)
