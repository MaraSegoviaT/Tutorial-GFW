WD <- 'D:\\SML\\GFW\\GFW Descargable\\Download 2020'

fishing_vessels <- read_csv('D:\\SML\\GFW\\GFW Descargable\\Download 2020\\fishing-vessels-v2.csv')






#DEFINIR WORKFLOW PARA SACAR LISTADO DE MMSI PARA 1 DÍA DE 1 AÑO DENTRO DE POLIGONO

#Instalar y cargar paquetes
install.packages("sf")
install.packages("dplyr")
library(sf)
library(dplyr)

#Ruta al archivo CSV de MMSI de un día 
MMSI_01_01_2020 <- read.csv('D:\\SML\\GFW\\GFW Descargable\\Download 2020\\MMSI_2012-2020\\mmsi-daily-csvs-10-v2-2020\\2020-01-01.csv')

#Crear objeto espacial
area_cabrera <- st_read('D:\\SML\\GFW\\GFW Descargable\\Download 2020\\areapncabrera.gpkg', quiet = TRUE)
st_crs(area_cabrera)

#Crear un objeto espacial sf
sf_MMSI_01_01_2020 <- st_as_sf(MMSI_01_01_2020, coords = c("cell_ll_lon","cell_ll_lat"), crs = 25831)

#Filtrar barcos dentro del polígono
MMSI_01_01_2020_cabrera <- st_join(sf_MMSI_01_01_2020, area_cabrera)





#GENERAR BUCLE PARA TODOS LISTAR TODOS LOS MMSI DE TODOS LOS DÍAS DE 2020 EN CABRERA
#Documento con polígono
area_cabrera <- st_read('D:\\SML\\GFW\\GFW Descargable\\Download 2020\\areapncabrera.gpkg', quiet = TRUE)
#Crear objeto espacial con ese poligono
sf_MMSI_01_01_2020 <- st_as_sf(MMSI_01_01_2020, coords = c("cell_ll_lon","cell_ll_lat"), crs = 25831)

#Carpeta que contiene los días de ese año
carpeta_datos <- 'D:\\SML\\GFW\\GFW Descargable\\Download 2020\\MMSI_2012-2020'

#Obten la lista de archivos CSV en la carpeta principal y sus subcarpetas
archivos_mmsi_csv <- list.files(path = carpeta_datos, pattern = "\\.csv$", recursive = TRUE, full.names = TRUE)

#Inicia una lista para almacenar los resultados de cada archivo
MMSI_Cabrera <- list()

#Bucle para procesar cada archivo CSV
for (archivo_csv in archivos_mmsi_csv) {
  MMSI_01_01_2020 <- read.csv('D:\\SML\\GFW\\GFW Descargable\\Download 2020\\MMSI_2012-2020\\mmsi-daily-csvs-10-v2-2020\\2020-01-01.csv')
  
  #Aplica tu proceso o analisis a los datos 
  
  #Filtrar barcos dentro del polígono
  MMSI_01_01_2020_cabrera <- st_join(sf_MMSI_01_01_2020, area_cabrera)
  
  #Almacenar resultados en la lista
  MMSI_Cabrera[[archivo_csv]] <- MMSI_01_01_2020_cabrera
}

MMSI_Cabrera_comb <- do.call(rbind, MMSI_Cabrera)