#get_vessel_info permite obtener detalles de los buques.

#hay 3 tipos de busqueda:

#basic: MMSI, IMO, callsign, shipname como imputs e identifica todos los buques que coincidan con esa busqueda.
#advances: puedes buscar con el ID de GFW. 
#id: permite al usuario especificar el vessel id (de GFW)

#Tambien se pueden definir tipos de embarcacion: carrier_vessel, support_vessel, fishing_vessel o all. 

#usando MMSI
get_vessel_info(query = 224224000,
                search_type = "basic",
                dataset = "all",
                key = key)

#usando IMO
get_vessel_info(query = "83300949",
                search_type = "advanced",
                dataset = "carrier_vessel",
                key = key)

#para especificar más de un ID: 
get_vessel_info(query = "insert GFW_ID1, insert GFW_ID2, insert GFWID3",
                search_type = 'id', key = key)
