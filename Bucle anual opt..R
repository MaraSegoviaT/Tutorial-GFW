library(sf)
library(dplyr)
library(tools)

#GENERAR BUCLE PARA TODOS LISTAR TODOS LOS MMSI DE TODOS LOS DÍAS DE 2019 EN CABRERA
#Documento con polígono
#area_cabrera_original <- st_read('D:\\SML\\GFW\\GFW Descargable\\Download 2020\\areapncabrera.gpkg', quiet = TRUE)
#area_cabrera <- st_transform(area_cabrera_original, crs = 4326)
area_cies_original <- st_read('D:\\SML\\PNMT_CIES\\areapncies.gpkg', quiet = TRUE)
area_cies <- st_transform(area_cies_original, crs = 4326)


#Carpeta que contiene los días de ese año
carpeta_datos_año <- 'D:\\SML\\GFW\\GFW Descargable\\Download 2020\\MMSI_2012-2020\\mmsi-daily-csvs-10-v2-2020'


#Obten la lista de archivos CSV en la carpeta principal y sus subcarpetas
archivos_mmsi_csv_año <- list.files(path = carpeta_datos_año, pattern = "\\.csv$", recursive = TRUE, full.names = TRUE)

#Inicia una lista para almacenar los resultados de cada archivo
lista <- list()

#Bucle para procesar cada archivo CSV
for (archivo_csv in archivos_mmsi_csv_año) {
  archivo <- read.csv(archivo_csv)
  
  #######Aplica tu proceso o analisis a los datos 
  # Filtrar las geometrías que se encuentran dentro de las nuevas longitudes y latitudes
  archivo_filtrado <- archivo %>%
    filter(cell_ll_lon >= longitud_minima_cab_n,
           cell_ll_lon <= longitud_maxima_cab_n,
           cell_ll_lat >= latitud_minima_cab_n,
           cell_ll_lat <= latitud_maxima_cab_n)
  
  #Crear objeto espacial con ese poligono
  sf_archivo <- st_as_sf(archivo_filtrado, coords = c("cell_ll_lon","cell_ll_lat"), crs = 4326)
  

  # Realizar la intersección directa entre geometrías
  intersecciones <- st_intersection(sf_archivo, area_cabrera)
  
  # Filtrar las filas que tienen intersección
  archivo_cabrera <- intersecciones[!is.na(intersecciones$geometry), ]
  
  #Almacenar resultados en la lista
  lista[[archivo_csv]] <- archivo_cabrera
}

#Combinar todos los archivos en una lista única
lista.comb <- do.call(rbind, lista)

# Convertir lista.comb a un data frame sin información espacial
data_frame_sin_sf <- st_drop_geometry(lista.comb)

# Supongamos que deseas eliminar las columnas llamadas "columna1" y "columna2"
columnas_utiles <- c("date", "mmsi", "hours", "fishing_hours")
df_limpio <- data_frame_sin_sf[, columnas_utiles]


write.csv(df_limpio, 'D:\\SML\\PNMT_CIES\\mmsi_cies_2020.csv', row.names = FALSE)
