#load ceafsMOS  package
library(cefasMOS) #needs ggplot2 cmocean data.table geosphere lubridate


#query functions in package
lsf.str("package:cefasMOS")

#documentation for data.table
browseVignettes("data.table")

#generate date in POSIXct format
date1=as.POSIXct("10/01/09 14:00:00", format = "%d/%m/%y %H:%M:%S", tz="UTC")

#load test smartbuoy data
test=smartbuoy.fetch(deployment = NA, deployment_group = "DOWSING", after = NA,before = NA, parameters = c("FLUORS"), min_QA_reached = TRUE, RQ0 = TRUE, ct_temp_only = TRUE,averaging_period = NA, night_flu_only = FALSE,db_name = "smartbuoydblive")

#plot fluo as line
ggplot(test,aes(dateTime,value))+geom_path(lineend="butt",linejoin="round",linemitre=1)

#find where in 'test' time series data is for given time
test[,.(dateTime==as.POSIXct("10/01/09 14:00:00", format = "%d/%m/%y %H:%M:%S",tz="UTC"))] #returns logicals as list---.( is same as list function
which(test[,(dateTime==as.POSIXct("10/01/09 14:00:00", format = "%d/%m/%y %H:%M:%S",tz="UTC"))])  #returns index

#returns positions of smartbuoys
pos=smartbuoy.positions(db_name = "smartbuoydblive", group = T)
ggplot(pos,aes(lon,lat))+geom_point()

#add to map 
library(ggplot2)
library(dplyr)
require(maps)
require(viridis)

uk.map=map_data("world", region = "UK")
ggplot() +geom_polygon(data=uk.map,aes(long,lat,group=group),fill="lightgray", colour = "white")+geom_point(data=pos,aes(lon,lat))


#now loop by deployment date?
yearstart=pos[,.(year(dateFrom))]
yearend=pos[,.(year(dateTo))]


for x=min(yearstart):max(yearend)

ggplot() +geom_polygon(data=uk.map,aes(long,lat,group=group),fill="lightgray", colour = "white")+geom_point(data=pos,aes(lon,lat))