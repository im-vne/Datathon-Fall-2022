# Name: Valerie Espinosa
#Create  a map with the coordinates of each plot. 

# CO2 averages
engine_avg = c()
for(i in 1:length(dta)){
engine_mean = mean(na.omit(dta[[i]][,5]))
engine_avg = c(engine_avg,engine_mean)
}

engines = engines%>% mutate(AVG_CO2 = engine_avg)
engines = engines %>% arrange(PLANT_NAME) %>% group_by(PLANT_NAME) %>% mutate(TOT_CO2 = sum(AVG_CO2))

#create vector out of tibble from engine_data
###  these stay in order
# unique(engines$TOT_CO2)
#assign to respective sites

sites = sites %>% arrange(PLANT_NAME) %>% mutate(TOT_CO2 = unique(engines$TOT_CO2)) 


points_sf <- st_as_sf(site_data, coords = c("LONGITUDE", "LATITUDE"), crs = 4326)
mapview(points_sf,zcol = "CUSTOMER_NAME", burst = T)

leaflet(points_sf) %>% 
  addTiles() %>%
  