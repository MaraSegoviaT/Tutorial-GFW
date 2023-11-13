#3 FUNCIONES PARA 3 APIS

#get_vessel_info   ID y caracteristicas desde VESSELS API 
#get_event         Eventos de pesca, encuentros, visitas a puerto desde EVENTS API 
#get_raster        Esfuerzo de pesca desde rasters en 4WINGS o MAP VISUALIZATION API 

#todos dan respuestas en data frame

#Buscar todos los buques con bandera argentina
library(gfwr)

key <- gfw_auth()
get_vessel_info(
  query = "flag = 'ARG'",
  search_type = "advanced",
  dataset = "all")

#Generar data frame de buques bolivianos + pesqueros
bolivian <- get_vessel_info(
  query = "flag = 'BOL'",
  search_type = "advanced",
  dataset = "fishing_vessel")

head(bolivian)

#Pegar IDs:
bol_ids <- paste0 (bolivian$id(1:nrow(bolivian)),collapse = ',')

#Obtener eventos de pesca
bol_fish <- get_event(event_type='fishing', vessel = bol_ids)

head(bol_fish, 6)
#¿Dónde se realiza la pesca (aparente)? 
install.packages("ggplot2")
library(ggplot2)

bol_sf <- sf::st_as_sf(bol_fish, courds = c("lon","lat"),
                       crs = '+proj = longlat + datum = WGS84')
SF::st_transform(.,crs="+proj = eqearthe + datum=W6S84 + WKtext")
land_sf <- rnaturalearth::ne_countries(scale = 50, 
                                       returnclass = "sf")
ggplot() + 
  geom_sf(data = bol_sf, color = "blue", size = 3)+
  geom_sf(data = land_sf)+
  theme_bw()+
  theme(panel.border = element_blank())+
  coord_sf(crs = "´+proj=eqearth +datum=W6S84 + wktext")







