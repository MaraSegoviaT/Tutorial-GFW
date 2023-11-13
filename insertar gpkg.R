install.packages("sf")
library(sf)

#Cargar el archivo GeoPackage
zona_estudio_cabrera <- st_read("areapncabrera.gpkg") 
zona_estudio_cies <- st_read("areapncies.gpkg")



#Puedo conseguir la lista de vessels ID de un tipo determinado de barco? 

#TRAWLERS 
trawlers <- get_vessel_info(
  query = "geartype = 'trawlers'", 
  search_type = "advanced", 
  dataset = "fishing_vessel",
  key = key
)
head(trawlers)

trawlers_cabrera <- st_intersection(zona_estudio_cabrera, trawlers)
head(trawlers_cabrera)

trawlers_cies <- st_intersection(zona_estudio_cies, trawlers)
head(trawlers_cies)




#POTS AND TRAPS 
pots_and_traps <- get_vessel_info(
  query = "geartype = 'pots_and_traps'", 
  search_type = "advanced", 
  dataset = "fishing_vessel",
  key = key
)

head(pots_and_traps)

pots_and_traps_cabrera <- st_intersection(zona_estudio_cabrera, pots_and_traps)
head(pots_and_traps_cabrera)

pots_and_traps_cies <- st_intersection(zona_estudio_cies, pots_and_traps)
head(pots_and_traps_cies)





#DRIFTING LONGLINES 
drifting_longlines <- get_vessel_info(
  query = "geartype = 'drifting_longlines'", 
  search_type = "advanced", 
  dataset = "fishing_vessel",
  key = key
)
head(drifting_longlines)

drifting_longlines_cabrera <- st_intersection(zona_estudio_cabrera, drifting_longlines)
head(trawlers_cabrera)

drifting_longlines_cies <- st_intersection(zona_estudio_cies, drifting_longlines)
head(drifting_longlines_cies)



#Para obtener un listado de los vessel_id de barcos utilizando los API de Global Fishing Watch y restringiendo el área con un archivo geopackage, necesitarás seguir estos pasos:
  
#1. Importa el archivo geopackage a un sistema de información geográfica (SIG) compatible, como QGIS o ArcGIS.
#2. Abre el archivo geopackage en el SIG y visualiza el área geográfica que deseas restringir.
#3. Utiliza las herramientas de análisis espacial del SIG para obtener la geometría del área geográfica restringida.
#4. Exporta la geometría resultante a un formato compatible con los API de Global Fishing Watch, como GeoJSON o WKT.

#Una vez que tengas la geometría restringida, puedes utilizar los API de Global Fishing Watch para obtener el listado de vessel_id de los barcos dentro de esa área. Puedes hacerlo utilizando las siguientes API endpoints:
  
#- Utiliza el endpoint `/vessels` para obtener información general sobre los barcos, incluyendo sus vessel_id.
#- Utiliza el endpoint `/vessels/{vessel_id}/tracks` para obtener los tracks de un barco específico.