


# Creación de datos covid
                         
library(readxl)
divpola<- read_xlsx("Clase_Intro/Divipola_Dpto.xlsx")
                         
Covid<-read.csv("Clase_Intro/Covid_Colombia.csv",header = TRUE,sep = ",",dec = ".")                         

Covid$divi<- as.character(Covid$`CÃ³digo.DIVIPOLA.departamento`)
y<-replace(Covid$divi, which(Covid$divi=="5"),"05")
y<-replace(y, which(Covid$divi=="8"),"08")
Covid$y<-y

Data<-merge(Covid,divpola,by.x="y",by.y="COD")


Data.covid<-Data[,c(1,2,6,8,9,11)]
names(Data.covid)<-c("Divipola","Fecha","Departamento","Municipio","Edad","Sexo")
Data.covid2<-tidyr::separate(Data.covid, Fecha, c("date", "time"), sep = " ")

Data.covid2$Fecha<-format(as.Date(Data.covid2$date, format = "%d/%m/%Y"), "%Y-%m-%d")

head(Data.covid2)

Covid<-Data.covid2[,-c(2,3)]

head(Covid)

saveRDS(Covid,"Clase_Intro/Covid.rds")



# Creación de tabla y gráfico

library(crosstalk)
library(leaflet)
library(dplyr)
library(reactable)

# A SpatialPointsDataFrame for the map.
# Set a group name to share data points with the table.
brew_sp <- SharedData$new(covid_geo, group = "Departamento")


# A regular data frame (without coordinates) for the table.
# Use the same group name as the map data.
brew_data <- as_tibble(covid_geo) %>%
  SharedData$new(group = "Departamento")

map <- leaflet(brew_sp,width = 500, height=300) %>%
  addTiles() %>%
  addMarkers(~Longitud,~Latitud,popup = ~as.character(Casos), label = ~as.character(Casos))

tbl <- reactable(
  brew_data,
  selection = "multiple",
  onClick = "select",
  rowStyle = list(cursor = "pointer"),
  minRows = 7,
  defaultPageSize = 7
)

htmltools::browsable(
  htmltools::tagList(map, tbl)
)




# Mapa africa

# Get the shape file of Africa
library(maptools)
data(wrld_simpl)
afr=wrld_simpl[wrld_simpl$REGION==2,]

# We can visualize the region's boundaries with the plot function
plot(afr)

library(sf)

sfno <- st_as_sf(afr)
st_crs(sfno)

sfproj <- st_transform(sfno, crs = 23038)
st_crs(sfproj)

# We work with the cartogram library 
library(cartogram)

# construct a cartogram using the population in 2005
afr_cartogram <- cartogram_cont(sfproj, "POP2005", itermax=5)

# This is a new geospatial object, we can visualise it!
plot(afr_cartogram)


ggplot() +
  geom_sf(data = afr_cartogram, aes(fill = POP2005))



library(wordcloud2) 

# have a look to the example dataset
# head(demoFreq)

# Basic plot
wordcloud2(data=demoFreq, size=1.6)

demoFreq %>% 
  filter(freq > 5) %>% 
  wordcloud2()


