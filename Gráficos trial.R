library(ggplot2)
library(dplyr)
library(lubridate)

nav_cies <- read.csv("D:\\SML\\PNMT_CIES\\datos_navegación_cies.csv")
nav_cabrera <- read.csv("D:\\SML\\PNMT_CABRERA\\datos_navegación_cabrera.csv")

nav_cies$date <- as.Date(nav_cies$date)
nav_cabrera$date <- as.Date(nav_cabrera$date)

# Crear el gráfico simple de lineas
ggplot(nav_cies, aes(x = date)) +
  geom_line(aes(y = fishing_hours, color = "Horas de Pesca"), size = 1) +
  geom_line(aes(y = navigation, color = "Horas de Navegación"), size = 1) +
  labs(title = "Evolución de Horas de Pesca y Navegación",
       x = "Fecha",
       y = "Horas") +
  scale_color_manual(values = c("Horas de Pesca" = "blue", "Horas de Navegación" = "green"))

# Grafico con datos agregados por dias de liheas
datos_agregados_dia <- nav_cies %>%
  group_by(date) %>%
  summarise(total_fishing_hours = sum(fishing_hours),
            total_navigation = sum(navigation))

ggplot(datos_agregados_dia, aes(x = date)) +
  geom_line(aes(y = total_fishing_hours, color = "Horas de Pesca"), size = 1) +
  geom_line(aes(y = total_navigation, color = "Horas de Navegación"), size = 1) +
  labs(title = "Evolución de Horas de Pesca y Navegación (Agregado por Día)",
       x = "Fecha",
       y = "Horas") +
  scale_color_manual(values = c("Horas de Pesca" = "blue", "Horas de Navegación" = "red"))

ggplot(datos_agregados_dia, aes(x = date)) +
  geom_line(aes(y = total_fishing_hours, color = "Horas de Pesca"), size = 1) +
  geom_line(aes(y = total_navigation, color = "Horas de Navegación"), size = 1) +
  labs(title = "Evolución de Horas de Pesca y Navegación (Agregado por Día)",
       x = "Fecha",
       y = "Horas") +
  scale_color_manual(values = c("Horas de Pesca" = "blue", "Horas de Navegación" = "red")) +
  facet_wrap(~year(date), scales = "free_x", ncol = 1)  # Envoltura por año
