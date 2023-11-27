library(gfwr)
key <- gfw_auth()

#Obtener la información de un vessel con MMSI = 224106220
info_228128000 <- get_vessel_info(query = 224106220, 
                search_type = "basic", 
                dataset = "all", 
                key = key)

