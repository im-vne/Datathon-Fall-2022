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

