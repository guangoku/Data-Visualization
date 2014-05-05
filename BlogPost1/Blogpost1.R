rm(list=ls())
data<-read.csv("C:/study/columbia study/Exploratory Data Analys/Blog Post1/stream graph/data.csv")
datagai<-read.csv("C:/study/columbia study/Exploratory Data Analys/Blog Post1/stream graph/data gai.csv")
money<-as.factor(datagai$date)
summary(money)
KEY<-c(rep("Boom Beach",27),rep("Clash of Clans",27),rep("Hay Day",27),rep("Royal Revolt",27),rep("Clumsy Ninja",27),
         rep("Dungeon Keeper",27),rep("Simpsons Tapped Out",27),rep("Empire",27),rep("Knights & Dragons",27),rep("Hobbit KoM",27),
         rep("Kingdoms of Camelot",27),rep("Monster world",27),rep("Pocket Village",27),rep("Moshi Monsters Village",27),rep("Smurfs Village",27)
         ,rep("CastleVille Legends",27),rep("Samurai Siege",27),rep("Game of War",27),rep("Modern War",27),rep("Subway Surfers",27)
         ,rep("Puzzle & Dragons",27),rep("Jelly Splash",27),rep("Disco Zoo",27),rep("Juice Cubes",27),rep("Angry Birds Go",27)
         ,rep("Farm Heros Saga",27),rep("Papa Pear Saga",27),rep("Real Racing 3",27),rep("CSR Racing",27),rep("8 Ball Pool",27)
         ,rep("Kingdoms at War",27),rep("Top Eleven",27))
c<-c(0.69,  1.49  ,1.99 , 2.99,  3.99  ,4.99  ,5.49 , 6.99 , 7.49 , 9.99 
    , 13.99 ,15.49, 15.99 ,17.49, 19.99, 20.99 ,23.99 ,27.99 ,29.99 ,30.99 ,34.99, 37.99, 39.99, 49.99, 69.99 ,74.99, 99.99 )
DATE<-c(rep(c,32))
VALUE<-c(rep(0,864))
DATA.GAI<-cbind(KEY,VALUE,DATE)
DATA.GAI<-data.frame(DATA.GAI)
write.csv(DATA.GAI, file = "C:/study/columbia study/Exploratory Data Analys/Blog Post1/stream graph/DATA.GAI.csv",
          quote = FALSE, eol = "\n",row.names = FALSE)
####################################################3

newdata<-read.csv("C:/study/columbia study/Exploratory Data Analys/Blog Post1/stream graph/data.csv")
require(reshape2)
head(newdata)
datacast <-dcast(newdata, date ~ key, value.var="value")
datacast1<-datacast[,-1]

ord <- order(apply(datacast1, 2, function(r) min(which(r>0))))
y2 <- y[, ord]
pal <- colorRampPalette("blue")
z <- pal(ncol(datacast1))

png("C:/study/columbia study/Exploratory Data Analys/Blog Post1/stream graph/try1.png", width=7, height=5, units="in", res=400)
layout(matrix(1:2, nrow=2, ncol=1), widths=7, heights=c(2.5,2.5), respect=TRUE)
par(mar=c(2,4,2,1), cex=0.75)
plot.stacked(c,datacast1, xlim=c(0, 100), ylim=c(0, 1.2*max(apply(datacast1,1,sum), na.rm=TRUE)), yaxs="i", col=z, border=1, lwd=0.25)
mtext("Stacked plot", line=0.25, side=3)
box()
plot.stream(c,datacast1, xlim=c(0, 100), center=FALSE, order.method="max", spar=0.1, frac.rand=0.05, col=z, border=1, lwd=0.25)
mtext("Stream plot", line=0.25, side=3)
box()
dev.off()


################################333
write.csv(datacast, file = "C:/study/columbia study/Exploratory Data Analys/Blog Post1/stream graph/GGDAT.csv",
          quote = FALSE, eol = "\n",row.names = FALSE)
ggdata<-read.csv("C:/study/columbia study/Exploratory Data Analys/Blog Post1/stream graph/GGDAT.csv")
head(ggdata)
cc<-as.numeric(ggdata$date)
ggdata1<-ggdata[,-1]

ord <- order(apply(ggdata1, 2, function(r) min(which(r>0))))
 ggdata2<- ggdata1[, ord]
pal <- colorRampPalette("blue", "cyan", "yellow", "red")
z <- pal(ncol(ggdata1))

png("C:/study/columbia study/Exploratory Data Analys/Blog Post1/stream graph/try6.png", width=7, height=5, units="in", res=400)
layout(matrix(1:2, nrow=2, ncol=1), widths=7, heights=c(2.5,2.5), respect=TRUE)
par(mar=c(2,4,2,1), cex=0.75)
plot.stacked(cc,ggdata2, xlim=c(0, 76), ylim=c(0, 1.2*max(apply(ggdata2,1,sum), na.rm=TRUE)), yaxs="i", col=z, border=1, lwd=0.25)
mtext("Stacked plot", line=0.25, side=3)
box()
plot.stream(cc,ggdata2, xlim=c(0, 76), center=FALSE, order.method="max", spar=0.1, frac.rand=0.05, col=z, border=1, lwd=0.25)
mtext("Stream plot", line=0.25, side=3)
box()
dev.off()

pal <- colorRampPalette(c(rgb(0.85,0.85,1), rgb(0.2,0.2,0.7)))
BREAKS <- pretty(apply(ggdata2,2,max),8)
LEVS <- levels(cut(1, breaks=BREAKS))
COLS <- pal(length(BREAKS )-1)
z <- val2col(apply(ggdata2,2,max), col=COLS)

png("C:/study/columbia study/Exploratory Data Analys/Blog Post1/stream graph/try3.png", width=7, height=5, units="in", res=400)
layout(matrix(1:2, nrow=2, ncol=1), widths=7, heights=c(2.5,2.5), respect=TRUE)
par(mar=c(2,4,2,1), cex=0.75)
plot.stacked(cc,ggdata1, xlim=c(0, 100), ylim=c(0, 1.2*max(apply(ggdata1,1,sum), na.rm=TRUE)), yaxs="i", col=z, border=1, lwd=0.25)
mtext("Stacked plot", line=0.25, side=3)
box()
plot.stream(cc,ggdata1, xlim=c(0, 100), center=FALSE, order.method="max", spar=0.1, frac.rand=0.05, col=z, border=1, lwd=0.25)
mtext("Stream plot", line=0.25, side=3)
box()
dev.off()

#########################################################3333
#bar#
bardata<-t(ggdata1)
colnames(bardata)<-ggdata$date
head(bardata)
bardata<-as.matrix(bardata)
barplot(bardata)
write.csv(bardata, file = "C:/study/columbia study/Exploratory Data Analys/Blog Post1/stream graph/bardata.csv",
          quote = FALSE, eol = "\n")

bardataclean<-read.csv("C:/study/columbia study/Exploratory Data Analys/Blog Post1/stream graph/bardataclean.csv")
colnames(bardataclean)<-c("X","0.69","1.49","1.99","2.99","3.99","4.99","5.49","6.99","7.49","9.99","13.99","15.49","17.49",
"19.99","20.99","23.99","27.99","29.99","30.99","34.99","37.99","39.99","49.99","69.99","74.99")
head(bardataclean)
barcleanmelt <- melt(bardataclean, value.name="Value", variable.name="Metric")
colnames(barcleanmelt)<-c("PricePack", "Value", "frequency")
head(barcleanmelt)
?barplot

bardataclean<-as.matrix(bardataclean)
barplot(bardataclean)
require(ggplot2)
ggplot(barcleanmelt, aes(factor(Value),frequency))+geom_bar(aes(fill = factor(PricePack)))
