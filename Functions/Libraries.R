#Save and call all Files in same area

#inset all libraries needed
packages <- c("tidyverse", "ggplot2" , "sf", "mapview", "astsa", "readr")

#install packages that are not already on computer
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}

#load packages
invisible(lapply(packages, library, character.only = TRUE))

