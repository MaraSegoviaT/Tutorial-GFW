library(gfwr)
#Coger la llave como objeto desde el R enviroment
key <- gfw_auth()

# Lee tu data frame original desde el archivo CSV
df <- read.csv("D:\\SML\\PNMT_CABRERA\\mmsi_cabrera_2020.csv")

# Inicializa un vector para almacenar la información obtenida
info_vessel <- list()

# Itera sobre cada MMSI en tu data frame
for (mmsi in df$mmsi) {
  tryCatch({
    # Obtiene la información del MMSI
    info <- get_vessel_info(query = mmsi, search_type = "basic", dataset = "all", key = key)
    
    # Agrega la información al vector
    info_vessel[[as.character(mmsi)]] <- info
  }, error = function(e) {
    # Imprime un mensaje de error más informativo
    cat("Error para MMSI:", mmsi, " - ", conditionMessage(e), "\n")
  })
}

# Convierte la lista de información a un data frame
info_df <- do.call(rbind, info_vessel)

# Combina la información con tu data frame original usando el MMSI como clave
result_df <- merge(df, info_df, by.x = "mmsi", by.y = "id")

# Guarda el nuevo data frame en un archivo CSV
write.csv(result_df, "D:\\SML\\PNMT_CABRERA\\cabrera_2020_info.csv", row.names = FALSE)
