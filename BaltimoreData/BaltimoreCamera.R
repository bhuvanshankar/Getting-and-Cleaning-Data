#####################

#Baltimore Fixed Camera Data

#Create a directory
if (!file.exists("BaltimoreData")) {
  dir.create("BaltimoreData")
}

#Download the file to the folder
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "BaltimoreData/cameras.csv", method = "curl")
dateDownloaded <- date()

#Get the Table
CameraData <- read.table("./BaltimoreData/cameras.csv", sep = ",", header = TRUE)

#####################


##### THIS CODE DOES NOT WORK #####
cameras <- read.csv("~/Documents/git/CleaningGettingData/BaltimoreData/cameras.csv")
mymarkers <- cbind.data.frame(cameras$Latitude, cameras$Longitude)

library(RgoogleMaps)
lat <- c(39.19991302, 39.37049296) #define our map's ylim
lon <- c(-76.53236586, -76.71024274) #define our map's xlim
center = c(mean(lat), mean(lon))  #tell what point to center on
zoom <- 13  #zoom: 1 = furthest out (entire globe), larger numbers = closer in
terrmap <- GetMap(center=center, zoom=zoom, maptype= "roadmap", destfile = "roadmap") #lots of visual options, just like google maps: maptype = c("roadmap", "mobile", "satellite", "terrain", "hybrid", "mapmaker-roadmap", "mapmaker-hybrid")

#map('state','maryland', xlim=c(-76.53236586, -76.71024274), ylim=c(39.19991302, 39.37049296))

