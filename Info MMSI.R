library(gfwr)
key <- gfw_auth()

#Obtener la información de un vessel con MMSI = 228128000
info_228128000 <- get_vessel_info(query = 228128000, 
                search_type = "basic", 
                dataset = "all", 
                key = key)

#Bucle para obtener toda la info de toda la lista de vessels ID de Cabrera? (ALGUNOS MMSI = VARIOS BUQUES??!!)

