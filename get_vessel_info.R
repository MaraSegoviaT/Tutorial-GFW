library(gfwr)
#Coger la llave como objeto desde el R enviroment
key <- gfw_auth()

# Lee tu data frame original desde el archivo CSV
df_mmsi <- read.csv("D:\\SML\\PNMT_CABRERA\\mmsi_cabrera_2012.csv")

# Inicializa un vector para almacenar la información obtenida
info_vessel <- list()

for (mmsi in df_mmsi$mmsi) {
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

info_df <- do.call(rbind, info_vessel)

info_df <- info_df %>%
  mutate_all(as.character)
df_mmsi <- df_mmsi %>%
  mutate(mmsi = as.character(mmsi))

info_df <- info_df[, -1]#Todas las columnas deben mantenerse excepto la primea
str(info_df)
str(df_mmsi)

cabrera_2012_info <- left_join(df_mmsi, info_df, by = c("mmsi" = "mmsi"))
write.csv(cabrera_2012_info, 'D:\\SML\\PNMT_CABRERA\\cabrera_2012_info.csv', row.names = FALSE)
