library(dplyr)


# Lista con los nombres de tus archivos CSV
cab12 <- read.csv("D:\\SML\\PNMT_CIES\\mmsi_cies_2012.csv")
cab13 <- read.csv("D:\\SML\\PNMT_CIES\\mmsi_cies_2013.csv")
cab14 <- read.csv("D:\\SML\\PNMT_CIES\\mmsi_cies_2014.csv")
cab15 <- read.csv("D:\\SML\\PNMT_CIES\\mmsi_cies_2015.csv")
cab16 <- read.csv("D:\\SML\\PNMT_CIES\\mmsi_cies_2016.csv")
cab17 <- read.csv("D:\\SML\\PNMT_CIES\\mmsi_cies_2017.csv")
cab18 <- read.csv("D:\\SML\\PNMT_CIES\\mmsi_cies_2018.csv")
cab19 <- read.csv("D:\\SML\\PNMT_CIES\\mmsi_cies_2019.csv")
cab20 <- read.csv("D:\\SML\\PNMT_CIES\\mmsi_cies_2020.csv")


datos_cabrera <- bind_rows(cab12, cab13, cab14, cab15, cab16, cab17, cab18, cab19, cab20 )
View(datos_cabrera)

##CSV con listado de MMSI únicos en cabrera 12-20 para obtener info
mmsi_unicos_cabrera <- datos_cabrera %>% distinct(mmsi)
View(mmsi_unicos_cabrera)                                                                

write.csv(mmsi_unicos_cabrera, "D:\\SML\\PNMT_CIES\\mmsi_unicos_cies.csv", row.names = FALSE)


##CSV con df: mmsi, date, fishing hours and navigation 
datos_cabrera_horas_todo <- datos_cabrera %>%
  mutate(navigation = hours - fishing_hours) %>%
  select(-hours)
View(datos_cabrera_horas_todo)

#Lo siguiente solo vale en cabrera que tenia variables de más
#datos_cabrera_horas <- datos_cabrera_horas_todo [, c(1, 2, 3, 19)]
View(datos_cabrera_horas)
write.csv(datos_cabrera_horas_todo, "D:\\SML\\PNMT_CIES\\datos_navegación_cies.csv", row.names = FALSE)
