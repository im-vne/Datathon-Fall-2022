#pre-processing

###  Load in Data

# set path - changeable
path= "/Datathon-Fall-2022/Dataset/all_data_v2"

# read all csvs
filenames = list.files(path, pattern="*.csv", full.names=TRUE)
dta = lapply(filenames, read.csv)

# change names for easier access
names(dta) = paste0("data_", 1:213)
