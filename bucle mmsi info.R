library(gfwr)
key <- gfw_auth()

# Leer el CSV que contiene los MMSI
ruta_csv <- "D:\\SML\\PNMT_CABRERA\\MMSI_Cabrera_2020_1.csv" 
datos_embarcaciones_2020 <- read.csv(ruta_csv, sep = ".", header = TRUE)

# Inicializar una lista para almacenar los resultados
lista_info_embarcaciones <- list()

# Bucle para obtener información de cada MMSI
for (mmsi_actual in datos_embarcaciones_2020$) {
  
  # Obtener información del vessel
  info_vessel <- get_vessel_info(query = mmsi_actual, 
                                 search_type = "basic", 
                                 dataset = "all", 
                                 key = key)
  
  # Almacenar la información en la lista
  lista_info_embarcaciones[[as.character(mmsi_actual)]] <- info_vessel
}

# Convertir la lista a un data frame si es necesario
df_info_embarcaciones <- do.call(rbind, lista_info_embarcaciones)
