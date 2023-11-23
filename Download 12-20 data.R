#WD <- 'D:\\SML\\GFW\\GFW Descargable\\Download 2020'

#fishing_vessels <- read_csv('D:\\SML\\GFW\\GFW Descargable\\Download 2020\\fishing-vessels-v2.csv')






#DEFINIR WORKFLOW PARA SACAR LISTADO DE MMSI PARA 1 DÍA DE 1 AÑO (UN .CSV) DENTRO DE POLIGONO

#Instalar y cargar paquetes
install.packages(rt)
install.packages("sf")
#install.packages("dplyr")
library(sf)
library(dplyr)

#Cargar CSV de MMSI de un día 
MMSI_01_01_2020 <- read.csv('D:\\SML\\GFW\\GFW Descargable\\Download 2020\\MMSI_2012-2020\\mmsi-daily-csvs-10-v2-2020\\2020-01-01.csv')

#Crear un objeto espacial sf con los datos de un día y definirlo en stma global de coord 4326
sf_MMSI_01_01_2020 <- st_as_sf(MMSI_01_01_2020, coords = c("cell_ll_lon","cell_ll_lat"), crs = 4326)
#class(sf_MMSI_01_01_2020)

#Cargar cabrera como objeto espacial POLIGONO JAVI 
area_cabrera_original <- st_read('D:\\SML\\GFW\\GFW Descargable\\Download 2020\\areapncabrera.gpkg', quiet = TRUE)
#st_crs(area_cabrera_original)
#class(area_cabrera_original)

#Cambiar sistema de coordenadas de cabrera a stma global (EPSG 4326)
area_cabrera <- st_transform(area_cabrera_original, crs = 4326)
#st_crs(area_cabrera)
#str(area_cabrera)
#poligono_cabrera <- area_cabrera$geom

#asegurar que area_Cabrera solo sea clase sf (sin data.frame)
area_cabrera <- st_as_sf(area_cabrera)
poligono_cabrera <- st_geometry(area_cabrera)

#Cargar cabrera como objeto espacial ESPACIOS NATURALES PROTEGIDOS GOV
#ENP <- st_read('D:\\SML\\GFW\\GFW Descargable\\Download 2020\\enp.shp', quiet = TRUE)
#str(ENP)
#ENP$objectid <- as.factor(ENP$objectid)
#ENP_cabrera <- subset(ENP, objectid == 21075)
#st_crs(ENP_cabrera)
#ENP_cabrera_universal <- st_transform(ENP_cabrera, crs = 4326)




#Opción 1: Filtrar barcos (geometria de puntos) dentro del PN (geometria de poligono)
sf_MMSI_01_01_2020_cabrera <- sf_MMSI_01_01_2020[st_within(MMSI_01_01_2020, poligono_cabrera), ]



#Opción 2: Filtrado más especifico
sf_MMSI_01_01_2020_cabrera <- sf_MMSI_01_01_2020 %>%
  filter(st_within(., poligono_cabrera))

#Opción 3
# Realizar la intersección directa entre geometrías
intersecciones <- st_intersection(sf_MMSI_01_01_2020, area_cabrera)
str(intersecciones)

# Filtrar las filas que tienen intersección
sf_MMSI_01_01_2020_cabrera <- intersecciones[!is.na(intersecciones$geometry), ]

#IGUAL ESTOY HACIENDO EL TONTO Y NO HAY INTERSECCIONES?? 
# Verificar si hay intersecciones
if (nrow(intersecciones) > 0) {
  # Filtrar las filas que tienen intersección
  sf_MMSI_01_01_2020_cabrera <- intersecciones[!is.na(intersecciones$geometry), ]
} else {
  # En caso de no haber intersecciones, asignar un objeto vacío
  sf_MMSI_01_01_2020_cabrera <- st_sf()
}

# Mostrar la estructura del resultado
str(sf_MMSI_01_01_2020_cabrera)

