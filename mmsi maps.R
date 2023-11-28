##MAPAS MMSI

#install.packages("rnaturalearthdata")
library(ggplot2)
library(sf)
library(rnaturalearth)

# Carga tus datos (asegúrate de tener el formato correcto, como un archivo shapefile o GeoJSON)
# Aquí asumo que ya tienes un archivo shapefile llamado "MMSI_Cabrera_2020_comb.shp"

# Descarga datos del mundo con rnaturalearth
world <- ne_countries(scale = "medium", returnclass = "sf")

# Crea el gráfico MUNDIAL
ggplot() +
  geom_sf(data = world, fill = "#f0f0f0", color = "#bdbdbd", size = 0.2) +
  geom_sf(data = MMSI_Cabrera_2020_comb, color = "#3498db", size = 2) +
  labs(title = "Ubicación de los puntos MMSI en Cabrera 2020", x = "Longitud", y = "Latitud") +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    panel.border = element_blank(),
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    plot.title = element_text(size = 14, face = "bold")
  )

