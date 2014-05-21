
restaurant.P<-subset(restaurant.new, city=="Phoenix")
write.table(restaurant.P, file = "C:/study/columbiastudy/EDA/finalproject/Yelp/restaurant.p.csv")
restaurant.P$longitude<-as.numeric(restaurant.P$longitude)
restaurant.P$latitude<-as.numeric(restaurant.P$latitude)
restaurant.P$stars<-as.numeric(restaurant.P$stars)

lapply(restaurant.P$Price.Range, write, "C:/study/columbiastudy/EDA/finalproject/Yelp/pricerange.txt", append=TRUE, ncolumns=1000)
pricerange<-read.table("C:/study/columbiastudy/EDA/finalproject/Yelp/pricerange.new.txt")
restaurant.P<-cbind(restaurant.P,pricerange)

lapply(restaurant.P$Alcohol, write, "C:/study/columbiastudy/EDA/finalproject/Yelp/Alcohol.txt", append=TRUE, ncolumns=1000)
alcohol<-read.table("C:/study/columbiastudy/EDA/finalproject/Yelp/Alcohol.new.txt")
alcohol<-data.frame(alcohol)
restaurant.P<-cbind(restaurant.P,alcohol)


library(ggplot2)
library(ggmap)
map.p<-get_googlemap(location = center.p,        zoom = 2,scale = 2)
map.p<-ggmap(get_map(location = center.p,        zoom = 2,scale = 2))
pmap <- qmap("Phoenix", zoom = 10, color = "bw", legend = "topleft")
pmap
map.p

p.total<-pmap +geom_point(data=restaurant.P,aes(x = longitude, y = latitude),color="red",size=0.2)
p.Alcohol<-pmap +geom_point(data=restaurant.P,aes(x = longitude, y = latitude,colour=Alcohol),size=0.2)
p.Alcohol
#
p.stars<-pmap +geom_point(data=restaurant.P,aes(x = longitude, y = latitude,colour=stars,size=0.2,alpha=0.2))
p.stars
p.pricerange<-pmap +geom_point(data=restaurant.P,aes(x = longitude, y = latitude,colour=V1,size=0.2,alpha=0.2))
p.pricerange
p.alcohol<-pmap +geom_point(data=restaurant.P,aes(x = longitude, y = latitude,colour=V1,size=0.2,alpha=0.1))
p.alcohol
HoustonMap +
  stat_density2d(
    aes(x = lon, y = lat, fill = ..level.., alpha = ..level..),
    size = 2, bins = 4, data = violent_crimes,
    geom = "polygon"
  )
overlay <- stat_density2d(
  aes(x = lon, y = lat, fill = ..level.., alpha = ..level..),
  bins = 4, geom = "polygon",
  data = violent_crimes
)
HoustonMap + overlay + inset(
  grob = ggplotGrob(ggplot() + overlay + theme_inset()),
  xmin = -95.35836, xmax = Inf, ymin = -Inf, ymax = 29.75062
)
