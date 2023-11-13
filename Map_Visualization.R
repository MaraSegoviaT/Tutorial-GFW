#MAP VISUALIZATION API
#get_raster obtiene un raster del API 4WINGS y convierte la respuesta en un dataframe. Se debe especificar: 
#Resolución espacial: low (0,1 grado) o high (0,01 grado)
#Resolución temporal: daily, monthly or yearly
#Variable de agrupación: vessel_id, flag, gearType or flagAndGearType
#Rango temporal: debe ser máximo 1 año
#geojson region o codigo de region (ej. codigo EEZ) para filtrar el raster
#fuente de esa región (eez, mpa o user_json)
library(gfwr)
install.packages("readr")
library(readr)

region_json = '{"geojson":{"type":"Polygon","coordinates":[[[-76.11328125,-26.273714024406416],[-76.201171875,-26.980828590472093],[-76.376953125,-27.527758206861883],[-76.81640625,-28.30438068296276],[-77.255859375,-28.767659105691244],[-77.87109375,-29.152161283318918],[-78.486328125,-29.45873118535532],[-79.189453125,-29.61167011519739],[-79.892578125,-29.6880527498568],[-80.595703125,-29.61167011519739],[-81.5625,-29.382175075145277],[-82.177734375,-29.07537517955835],[-82.705078125,-28.6905876542507],[-83.232421875,-28.071980301779845],[-83.49609375,-27.683528083787756],[-83.759765625,-26.980828590472093],[-83.84765625,-26.35249785815401],[-83.759765625,-25.64152637306576],[-83.583984375,-25.16517336866393],[-83.232421875,-24.447149589730827],[-82.705078125,-23.966175871265037],[-82.177734375,-23.483400654325635],[-81.5625,-23.241346102386117],[-80.859375,-22.998851594142906],[-80.15625,-22.917922936146027],[-79.453125,-22.998851594142906],[-78.662109375,-23.1605633090483],[-78.134765625,-23.40276490540795],[-77.431640625,-23.885837699861995],[-76.9921875,-24.28702686537642],[-76.552734375,-24.846565348219727],[-76.2890625,-25.48295117535531],[-76.11328125,-26.273714024406416]]]}}'
flag_2021 <- get_raster(
  spatial_resolution = 'low',
  temporal_resolution = 'yearly',
  group_by = 'flag',
  date_range = '2021-01-01,2021-12-31',
  region = region_json,
  region_source = 'user_json',
  key = key
)

region_json = '{"geojson":{"type":"Polygon","coordinates":[[[-76.11328125,-26.273714024406416],[-76.201171875,-26.980828590472093],[-76.376953125,-27.527758206861883],[-76.81640625,-28.30438068296276],[-77.255859375,-28.767659105691244],[-77.87109375,-29.152161283318918],[-78.486328125,-29.45873118535532],[-79.189453125,-29.61167011519739],[-79.892578125,-29.6880527498568],[-80.595703125,-29.61167011519739],[-81.5625,-29.382175075145277],[-82.177734375,-29.07537517955835],[-82.705078125,-28.6905876542507],[-83.232421875,-28.071980301779845],[-83.49609375,-27.683528083787756],[-83.759765625,-26.980828590472093],[-83.84765625,-26.35249785815401],[-83.759765625,-25.64152637306576],[-83.583984375,-25.16517336866393],[-83.232421875,-24.447149589730827],[-82.705078125,-23.966175871265037],[-82.177734375,-23.483400654325635],[-81.5625,-23.241346102386117],[-80.859375,-22.998851594142906],[-80.15625,-22.917922936146027],[-79.453125,-22.998851594142906],[-78.662109375,-23.1605633090483],[-78.134765625,-23.40276490540795],[-77.431640625,-23.885837699861995],[-76.9921875,-24.28702686537642],[-76.552734375,-24.846565348219727],[-76.2890625,-25.48295117535531],[-76.11328125,-26.273714024406416]]]}}'
get_raster(
  spatial_resolution = 'low',
  temporal_resolution = 'yearly',
  group_by = 'vessel_id',
  date_range = '2021-01-01,2021-12-31',
  region = region_json,
  region_source = 'user_json',
  key = key
)

# use EEZ function to get EEZ code of Cote d'Ivoire
code_eez <- get_region_id(region_name = 'CIV', region_source = 'eez', key = key)
get_raster(spatial_resolution = 'low',
           temporal_resolution = 'yearly',
           group_by = 'vessel_id',
           date_range = '2021-01-01,2021-10-01',
           region = code_eez$id,
           region_source = 'eez',
           key = key)

# use EEZ function to get EEZ code of Cote d'Ivoire
code_eez <- get_region_id(region_name = 'CIV', region_source = 'eez', key = key)
get_raster(spatial_resolution = 'low',
           temporal_resolution = 'yearly',
           group_by = 'flag',
           date_range = '2021-01-01,2021-10-01',
           region = code_eez$id,
           region_source = 'eez',
           key = key)



(get_region_id(region_name = 'France', region_source = 'eez', key = key))
get_raster(spatial_resolution = 'low',
           temporal_resolution = 'yearly',
           group_by = 'flag',
           date_range = '2021-01-01,2021-10-01',
           region = 5677,
           region_source = 'eez',
           key = key)

# use region id function to get MPA code of Phoenix Island Protected Area
code_mpa <- get_region_id(region_name = 'Phoenix', region_source = 'mpa', key = key)
get_raster(spatial_resolution = 'low',
           temporal_resolution = 'yearly',
           group_by = 'flag',
           date_range = '2015-01-01,2015-06-01',
           region = code_mpa$id[1],
           region_source = 'mpa',
           key = key)

code_mpa0 <- get_region_id(region_name = 'Cabrera', region_source = 'mpa', key = key)
datos_cabrera_flag <- get_raster(spatial_resolution = 'low',
                                 temporal_resolution = 'yearly',
                                 group_by = 'flag',
                                 date_range = '2021-01-01,2021-12-01',
                                 region = code_mpa0$id[1],
                                 region_source = 'mpa',
                                 key = key)
head(datos_cabrera_flag)

code_mpa1 <- get_region_id(region_name = 'Illas Atlánticas de Galicia', region_source = 'mpa', key = key)
get_raster(spatial_resolution = 'low',
           temporal_resolution = 'yearly',
           group_by = 'gearType',
           date_range = '2015-01-01,2015-06-01',
           region = code_mpa1$id[1],
           region_source = 'mpa',
           key = key)

code_mpa2 <- get_region_id(region_name = 'Illa Cíes', region_source = 'mpa', key = key)
datos_cies_geartype <- get_raster(spatial_resolution = 'low',
                                  temporal_resolution = 'yearly',
                                  group_by = 'vessel_id',
                                  date_range = '2015-01-01,2015-06-01',
                                  region = code_mpa2$id[1],
                                  region_source = 'mpa',
                                  key = key)
head(datos_cies_geartype)

get_raster(spatial_resolution = 'low',
           temporal_resolution = 'daily',
           group_by = 'flag',
           date_range = '2021-01-01,2021-01-15',
           region = 'ICCAT',
           region_source = 'rfmo',
           key = key)

usa_trawlers <- get_vessel_info(
  query = "flag = 'USA' AND geartype = 'trawlers'", 
  search_type = "advanced", 
  dataset = "fishing_vessel",
  key = key
)

# Collapse vessel ids into a commas separated list to pass to Events API
usa_trawler_ids <- paste0(usa_trawlers$id[1:10], collapse = ',')

get_event(event_type = 'fishing',
          vessel = usa_trawler_ids,
          start_date = "2020-01-01",
          end_date = "2020-02-01",
          include_regions = TRUE,
          key = key)


# extract EEZ id code
dplyr::mutate(eez = as.character(purrr::map(purrr::map(regions, pluck, 'eez'), 
                                            paste0, collapse = ','))) %>%
  dplyr::select(id, type, start, end, lat, lon, eez) %>%
  dplyr::rowwise() %>%
  dplyr::mutate(eez_name = get_region_id(region_name = as.numeric(eez),
                                         region_source = 'eez',
                                         key = key)$label)

#--------------------------------------------------------------------------------
#Intento 1 de usar poligono de Javi para delimitar zona de estudio CABRERA
library(sp)
library(raster)
library(sf)  







