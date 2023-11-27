library(sf)
library(dplyr)
library(tools)

#GENERAR BUCLE PARA TODOS LISTAR TODOS LOS MMSI DE TODOS LOS DÍAS DE 2019 EN CABRERA
#Documento con polígono
area_cabrera_original <- st_read('D:\\SML\\GFW\\GFW Descargable\\Download 2020\\areapncabrera.gpkg', quiet = TRUE)
area_cabrera <- st_transform(area_cabrera_original, crs = 4326)

#Carpeta que contiene los días de ese año
carpeta_datos_2019 <- 'D:\\SML\\GFW\\GFW Descargable\\Download 2020\\MMSI_2012-2020\\mmsi-daily-csvs-10-v2-2019'



#Obten la lista de archivos CSV en la carpeta principal y sus subcarpetas
archivos_mmsi_csv_2019 <- list.files(path = carpeta_datos_2019, pattern = "\\.csv$", recursive = TRUE, full.names = TRUE)

#Inicia una lista para almacenar los resultados de cada archivo
MMSI_Cabrera_2019 <- list()

#Bucle para procesar cada archivo CSV
for (archivo_csv in archivos_mmsi_csv_2019) {
  MMSI_01_01_2019 <- read.csv(archivo_csv)
  
  #######Aplica tu proceso o analisis a los datos 
  
  #Crear objeto espacial con ese poligono
  sf_MMSI_01_01_2019 <- st_as_sf(MMSI_01_01_2019, coords = c("cell_ll_lon","cell_ll_lat"), crs = 4326)
  
  # Realizar la intersección directa entre geometrías
  intersecciones <- st_intersection(sf_MMSI_01_01_2019, area_cabrera)
  
  # Filtrar las filas que tienen intersección
  MMSI_01_01_2019_cabrera <- intersecciones[!is.na(intersecciones$geometry), ]
  
  #Almacenar resultados en la lista
  MMSI_Cabrera_2019[[archivo_csv]] <- MMSI_01_01_2019_cabrera
}

MMSI_Cabrera_2019_comb <- do.call(rbind, MMSI_Cabrera_2020)

##EXPORTAR DATOS DE ESE AÑO
MMSI_Cabrera_2019_comb$geometry <- NULL

# Exportar a CSV
sf::st_write(MMSI_Cabrera_2019_comb, 'D:\\SML\\PNMT_CABRERA\\MMSI_Cabrera_2019.csv', driver = 'CSV')

# Opcional: Exportar a GeoJSON
sf::st_write(MMSI_Cabrera_2019_comb, 'D:\\SML\\PNMT_CABRERA\\MMSI_Cabrera_2019.geojson', driver = 'GeoJSON')

