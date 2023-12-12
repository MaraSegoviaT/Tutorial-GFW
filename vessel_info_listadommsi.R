library(sf)
library(dplyr)
library(tools)
library(gfwr)
#Coger la llave como objeto desde el R enviroment
key <- gfw_auth()

# Lee tu data frame original desde el archivo CSV
mmsi_unicos_cabrera <- read.csv("D:\\SML\\PNMT_CABRERA\\mmsi_unicos_cabrera.csv")

# Inicializa un vector para almacenar la información obtenida
info_vessel <- list()

for (mmsi in mmsi_unicos_cabrera$mmsi) {
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
mmsi_unicos_cabrera <- mmsi_unicos_cabrera %>%
  mutate(mmsi = as.character(mmsi))

str(info_df)
write.csv(info_df, 'D:\\SML\\PNMT_CABRERA\\mmsi_unicos_cabrera_info.csv', row.names = FALSE)
