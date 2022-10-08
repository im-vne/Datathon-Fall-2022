# Name: Valerie Espinosa
#Create  a map with the coordinates of each plot. 

engine_avg = c()
for(i in 1:length(dta)){
engine_mean = mean(na.omit(dta[[i]][,5]))
engine_avg = c(engine_avg,engine_mean)
}

engine_data %>% group_by(PLANT_NAME) %>% count(PLANT_NAME) 

#create vector out of tibble from engine_data

#assign vector as a way for for loop to attatch values?



points_sf <- st_as_sf(site_data, coords = c("LONGITUDE", "LATITUDE"), crs = 4326)
mapview(points_sf,zcol = "CUSTOMER_NAME", burst = T)

leaflet(points_sf) %>% 
  addTiles() %>%
  