install.packages("sf")
library(sf)

# Reemplaza 'tu_archivo.gpkg' con la ruta a tu archivo GeoPackage
area_cabrera_original <- st_read('D:\\SML\\GFW\\GFW Descargable\\Download 2020\\areapncabrera.gpkg', quiet = TRUE)
area_cabrera <- st_transform(area_cabrera_original, crs = 4326)

# Obtener longitudes y latitudes máximas y mínimas
longitud_minima_cab <- min(st_coordinates(area_cabrera)[, 1])
longitud_maxima_cab <- max(st_coordinates(area_cabrera)[, 1])
latitud_minima_cab <- min(st_coordinates(area_cabrera)[, 2])
latitud_maxima_cab <- max(st_coordinates(area_cabrera)[, 2])

# Imprimir los resultados
cat("Longitud mínima_cab:", longitud_minima_cab, "\n")
cat("Longitud máxima_cab:", longitud_maxima_cab, "\n")
cat("Latitud mínima_cab:", latitud_minima_cab, "\n")
cat("Latitud máxima_cab:", latitud_maxima_cab, "\n")

# Sumar 0.1 grados a las longitudes y latitudes máximas y mínimas
longitud_minima_cab_n <- longitud_minima_cab - 0.1
longitud_maxima_cab_n <- longitud_maxima_cab + 0.1
latitud_minima_cab_n <- latitud_minima_cab - 0.1
latitud_maxima_cab_n <- latitud_maxima_cab + 0.1

