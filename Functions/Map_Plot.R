# Name: Valerie Espinosa
#Create  a map with the coordinates of each plot. 

source("Functions/Libraries.R")
source("Processing/Cleaning_Dataset.R")
engine_date = read.csv("Dataset/engine_data.csv")
site_data = read.csv("Dataset/site_data.csv")

# CO2 averages
engine_avg = c()
for(i in 1:length(dta)){
  engine_mean = mean(na.omit(dta[[i]][,5]))
  engine_avg = c(engine_avg,engine_mean)
}

engine_data$CO2 = engine_avg

co2_std_avg = engine_data %>%
  group_by(PLANT_NAME) %>%
  summarise(Avg_CO2 = round(sum(CO2),3))
  

site_data = site_data %>%
  left_join(co2_std_avg, by = "PLANT_NAME")


map_data = site_data %>% 
  dplyr::select(CUSTOMER_NAME,PLANT_NAME,LONGITUDE,LATITUDE,Avg_CO2)

leaflet(site_data) %>% 
  addTiles() %>%
  addCircles(lng = ~LONGITUDE, ~LATITUDE, 
             weight = 1, 
             radius = ~Avg_CO2*25000,
             popup = paste("Customer Name:", site_data$CUSTOMER_NAME, "<br>",
             "Plant Name:", site_data$PLANT_NAME, "<br>",
             "Average CO2 Emission:", site_data$Avg_CO2),
             color = ~qpal(site_data$CUSTOMER_NAME))
