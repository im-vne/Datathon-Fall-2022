# Name: Valerie Espinosa
#Create  a map with the coordinates of each plot. 

# CO2 averages
engine_avg = c()
for(i in 1:length(dta)){
engine_mean = mean(na.omit(dta[[i]][,5]))
engine_avg = c(engine_avg,engine_mean)
}
engine_data$CO2 = engine_avg

co2_std_avg = engine_data %>%
  group_by(PLANT_NAME) %>%
  summarise(Avg_CO2 = sum(CO2))
  

site_data = site_data %>%
  left_join(co2_std_avg, by = "PLANT_NAME")
  

#engines = engines %>% mutate(AVG_CO2 = engine_avg)
#engines = engines %>% arrange(PLANT_NAME) %>% group_by(PLANT_NAME) %>% mutate(TOT_CO2 = sum(AVG_CO2))

#create vector out of tibble from engine_data
###  these stay in order
# unique(engines$TOT_CO2)
#assign to respective sites



#sites = sites %>% arrange(PLANT_NAME) %>% mutate(TOT_CO2 = unique(engines$TOT_CO2)) 


points_sf <- st_as_sf(site_data, coords = c("LONGITUDE", "LATITUDE"), crs = 4326)
mapview(points_sf,zcol = "CUSTOMER_NAME", burst = T)


leaflet(site_data) %>% 
  addTiles() %>%
  addCircles(lng = ~LONGITUDE, ~LATITUDE, weight = 1, radius = ~Avg_CO2*10000, popup = ~PLANT_NAME, fillColor = ~CUSTOMER_NAME)
  
  