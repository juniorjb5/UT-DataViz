

########### Leaflet


library(leaflet)
library(rgdal)

#####Grafico de shapefile
dpto <- readOGR("4_Interactive/shp_dpto/MGN_DPTO_POLITICO.shp")
plot(dpto)


#####Grafico en leaflet
leaflet(dpto) %>% 
  addPolygons()


####Con color y etiquetas
leaflet(dpto) %>% 
addPolygons(
  fillColor = "red",
  weight = 2,
  opacity = 1,
  color = "white",
  dashArray = "3",
  fillOpacity = 0.7,
  highlight = highlightOptions(
    weight = 5,
    color = "#666",
    dashArray = "",
    fillOpacity = 0.7,
    bringToFront = TRUE),
  label = dpto$DPTO_CNMBR)


#### CAPAS

basemap <- leaflet() %>%
  # add different provider tiles
  addProviderTiles(
    "OpenStreetMap",
    # give the layer a name
    group = "OpenStreetMap"
  ) %>%
  addProviderTiles(
    "Stamen.Toner",
    group = "Stamen.Toner"
  ) %>%
  addProviderTiles(
    "Stamen.Terrain",
    group = "Stamen.Terrain"
  ) %>%
  addProviderTiles(
    "Esri.WorldStreetMap",
    group = "Esri.WorldStreetMap"
  ) %>%
  addProviderTiles(
    "Wikimedia",
    group = "Wikimedia"
  ) %>%
  addProviderTiles(
    "CartoDB.Positron",
    group = "CartoDB.Positron"
  ) %>%
  addProviderTiles(
    "Esri.WorldImagery",
    group = "Esri.WorldImagery"
  ) %>%
  # add a layers control
  addLayersControl(
    baseGroups = c(
      "OpenStreetMap", "Stamen.Toner",
      "Stamen.Terrain", "Esri.WorldStreetMap",
      "Wikimedia", "CartoDB.Positron", "Esri.WorldImagery"
    ),
    # position it on the topleft
    position = "topleft"
  )


basemap



##############################################################

basemap %>% 
  addPolygons(data=dpto,
    fillColor = "red",
    weight = 2,
    opacity = 1,
    color = "white",
    dashArray = "3",
    fillOpacity = 0.7,
    highlight = highlightOptions(
      weight = 5,
      color = "#666",
      dashArray = "",
      fillOpacity = 0.7,
      bringToFront = TRUE),
    label = dpto$DPTO_CNMBR)


##############################################################



covid_geo<- readRDS("4_Interactive/covid_geo.RDS")

covid_geo



basemap %>% 
  addPolygons(data=dpto,
              fillColor = "red",
              weight = 2,
              opacity = 1,
              color = "white",
              dashArray = "3",
              fillOpacity = 0.7,
              highlight = highlightOptions(
                weight = 5,
                color = "#666",
                dashArray = "",
                fillOpacity = 0.7,
                bringToFront = TRUE),
              label = dpto$DPTO_CNMBR)  %>% 
  addMarkers(data=covid_geo,
             ~Longitud,~Latitud,popup = ~as.character(Casos),
             label = ~as.character(Casos))


###################################################################



leaflet(dpto) %>% 
  addPolygons(
              fillColor = "red",
              weight = 2,
              opacity = 1,
              color = "white",
              dashArray = "3",
              fillOpacity = 0.7,
              highlight = highlightOptions(
                weight = 5,
                color = "#666",
                dashArray = "",
                fillOpacity = 0.7,
                bringToFront = TRUE),
              label = dpto$DPTO_CNMBR)  %>% 
  addMarkers(data=covid_geo,
             ~Longitud,~Latitud,popup = ~as.character(Casos),
             label = ~as.character(Casos)) %>% 
  addLegend(
    colors = "#E84A5F",
    labels = "Casos Covid-Colombia",
    title = "2021",
    opacity = 1, 
    position = "bottomleft"
  )


#####################################################################


# Crear colores variable categórica
factpal <- colorFactor(topo.colors(47), dpto$DPTO_CCDGO)

# Crear colores variable númerica
pal <- colorNumeric(
  palette = "Blues",
  domain = dpto$SHAPE_AREA)


# Color categorico
leaflet(dpto) %>% 
addPolygons(
  fillColor = ~factpal(DPTO_CCDGO),
  weight = 2,
  opacity = 1,
  color = "white",
  dashArray = "3",
  fillOpacity = 0.7,
  highlight = highlightOptions(
    weight = 5,
    color = "#666",
    dashArray = "",
    fillOpacity = 0.7,
    bringToFront = TRUE),
  label = dpto$DPTO_CNMBR)



# Color númerico
leaflet(dpto) %>% 
  addPolygons(
    fillColor = ~pal(SHAPE_AREA),
    weight = 2,
    opacity = 1,
    color = "white",
    dashArray = "3",
    fillOpacity = 0.7,
    highlight = highlightOptions(
      weight = 5,
      color = "#666",
      dashArray = "",
      fillOpacity = 0.7,
      bringToFront = TRUE),
    label = dpto$DPTO_CNMBR)


###############################################
# Actividad Final

# Realice el mapa para Tolima y los casos covid por municipios.



MPIO <- readOGR("4_Interactive/shp_mcpio/MGN_MPIO_POLITICO.shp")
Tolima<-subset(MPIO, MPIO$DPTO_CCDGO %in% c("73"))


leaflet(Tolima) %>% 
  addPolygons()









