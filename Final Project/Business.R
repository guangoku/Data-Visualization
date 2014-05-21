#import business data and data munging
require(RJSONIO)
data<-fromJSON("C:/study/columbiastudy/EDA/finalproject/Yelp/busi1.json")
business <- do.call(cbind, data)
business2<-unlist(business[1],recursive = FALSE)

for(i in 2:nrow(business))
{
  temp <-unlist(business[i],recursive = FALSE)
  business2 <- rbind(business2,temp)
}
row.names(business2)<-business2[,1]
busi<-business2[,-1]
busi<-data.frame(busi)

#find restaurat
category<-do.call(cbind,category)
category<-t(category)
rest<-subset(category,category[,1]=="Restaurants"| category[,2]=="Restaurants"
             |  category[,3]=="Restaurants"| category[,4]=="Restaurants"
             | category[,5]=="Restaurants"| category[,6]=="Restaurants"
             | category[,7]=="Restaurants"| category[,8]=="Restaurants"
             | category[,9]=="Restaurants"| category[,10]=="Restaurants")

restaurant<-subset(busi, row.names==row.names(rest))
restaurant<-busi[row.names(rest), ] 

#Wordcloud
library(wordcloud)
words<-unlist(restaurant$categories)
words.freq<-sort(table(words),decreasing=TRUE)
words.freq1<-words.freq[-1]
wordcloud(words=names(words.freq1),freq=words.freq1,min.freq=5,max.words=100,
          random.order=F,rot.per=.15, colors=brewer.pal(8,"Dark2"))
#Restaurant data munging
require(plyr)
restaurant<-restaurant[,-14]
attr<-restaurant$attributes
attr2<-data.frame(do.call(rbind,attr[1]))
for(i in 2:nrow(restaurant))
{
  temp <-data.frame(do.call(rbind,attr[i]))
  attr2<-rbind.fill(attr2,temp)
}
restaurant.new<-cbind(restaurant,attr2)

#hours<-restaurant$hours
#hours2<-data.frame(t(unlist(hours[[1]])))
#for(i in 2:nrow(restaurant))
#{
#  temp<-data.frame(t(unlist(hours[[i]])))
#  hours2 <- rbind.fill(hours2,temp)
#}
cate<-restaurant$categories
cate2<-unlist(cate[[1]])))
for(i in 2:nrow(restaurant))
{
  temp<-data.frame(t(unlist(cate[[i]])))
  cate2<-rbind(cate2,temp)
}
restaurant.new<-restaurant.new[,4:49]
restaurant.new <- subset(restaurant.new, select = -c(name) )
restaurant.new <- subset(restaurant.new, select = -c(neighborhoods,state,
                                attributes,Good.For,Ambience,Parking,Music) )
restaurant.new <- subset(restaurant.new, select = -c(Dietary.Restrictions) )
restaurant.new <- restaurant.new[,1:22]
#Chord Diagram
usedwords<-row.names(words.freq1[1:20])
cate.data<-restaurant.new$categories
library(qdap)          #http://stackoverflow.com/questions/11403196/r-count-times-word-appears-in-element-of-list
words2 <- list2df(lapply(cate.data, paste, collapse = " "), "wl", "list")[2:1]
cate.matrix<-with(words2, termco2mat(termco(wl, list, match.list=usedwords)))
cate.matrix<-t(cate.matrix)
cate.matrix<-cbind(cate.matrix,row.sums<-apply(cate.matrix,1,sum))
cate.matrix.used<-subset(cate.matrix,cate.matrix[,21]>=2)

inds = which(cate.matrix.used >= 1, arr.ind=TRUE)
inds
cnames = colnames(cate.matrix.used)[inds[,2]]
test<-cbind(inds,cnames)
test[which(row==11)]
test2<-aggregate(x=test$cnames, by=list(test$row),c)
library(tm)
library(RWeka)
test2<-aggregate(cnames ~ row, data=test, FUN=paste)
#5 group chord
usedwords.c<-row.names(words.freq1[1:5])
cate.data.c<-restaurant.new$categories
library(qdap)          #http://stackoverflow.com/questions/11403196/r-count-times-word-appears-in-element-of-list
words2.c <- list2df(lapply(cate.data.c, paste, collapse = " "), "wl", "list")[2:1]
cate.matrix.c<-with(words2.c, termco2mat(termco(wl, list, match.list=usedwords.c)))
cate.matrix.c<-t(cate.matrix.c)
cate.matrix.c<-cbind(cate.matrix.c,row.sums<-apply(cate.matrix.c,1,sum))
cate.matrix.used.c<-subset(cate.matrix.c,cate.matrix.c[,6]>=2)

inds.c = which(cate.matrix.used.c >= 1, arr.ind=TRUE)
inds.c
cnames.c = colnames(cate.matrix.used.c)[inds.c[,2]]
test.c<-cbind(inds.c,cnames.c)
test2<-aggregate(x=test$cnames, by=list(test$row),c)
library(tm)
library(RWeka)
test2.c<-aggregate(cnames.c ~ row, data=test.c, FUN=paste)
test.aa<-lapply(test2.c$cnames.c, paste))
#matrix
#Mexican	Sandwiches	American(Traditional)	Fast Food	Pizza
#Mexican	0	1	9	95	0
#Sandwiches	1	0	23	45	80
#American(Traditional)	9	23	0	50	7
#Fast Food	95	45	50	0	15
#Pizza	0	80	7	15	0

http://guangoku.github.io/chord-diagram.html