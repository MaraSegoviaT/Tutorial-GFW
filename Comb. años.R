library(dplyr)

### NECESITO QUE EL ARCHIVO CABRERA_2012_INFO INCLUYA LA INFORMACION DE HORAS, REPETIR TODOS LOS BUCLES CON EL CAMBIO EN EL SCRIP !!! 
# Lista con los nombres de tus archivos CSV
wd <- "D:\\SML\\PNMT_CABRERA"
csv_cabrera <- c("cabrera_2012_info.csv", "cabrera_2013_info.csv", "cabrera_2014_info.csv", "cabrera_2015_info.csv", "cabrera_2016_info.csv", "cabrera_2017_info.csv", "cabrera_2018_info.csv", "cabrera_2019_info.csv", "cabrera_2020_info.csv")
datos_cabrera <- file.path(wd, csv_cabrera)

# Leer y combinar los archivos
datos_combinados <- do.call(rbind, lapply(datos_cabrera, read.csv))
str(datos_combinados)

#Modificar data.frame
datos_combinados <- datos_combinados %>%
  mutate(diferencia = hours - columna1)# Obtener navigation_hours
  select(columna1, columna2, diferencia, ultima_columna)

# Escribir el archivo combinado
write.csv(datos_combinados, "D:\\SML\\PNMT_CABRERA\\combinado_Cabrera.csv", row.names = FALSE)
