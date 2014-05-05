library(devtools)
source_url('https://gist.github.com/menugget/7689145/raw/dac746aa322ca4160a5fe66c70fec16ebe26faf9/image.scale.2.r')
source_url('https://gist.github.com/menugget/7864454/raw/f698da873766347d837865eecfa726cdf52a6c40/plot.stream.4.R')
source_url('https://gist.github.com/menugget/7864471/raw/8127dfaae183233d203580bc247a73a564d5feab/plot.stacked.2.R')


set.seed(1)
m <- 500
n <- 30
x <- seq(m)
x
y <- matrix(0, nrow=m, ncol=n)
colnames(y) <- seq(n)
for(i in seq(ncol(y))){
  mu <- runif(1, min=0.25*m, max=0.75*m)
  SD <- runif(1, min=5, max=20)
  TMP <- rnorm(1000, mean=mu, sd=SD)
  HIST <- hist(TMP, breaks=c(0,x), plot=FALSE)
  fit <- smooth.spline(HIST$counts ~ HIST$mids)
  y[,i] <- fit$y
}
y <- replace(y, y<0.01, 0)


y
#Plot Ex. 1 - Color by max value
pal <- colorRampPalette(c(rgb(0.85,0.85,1), rgb(0.2,0.2,0.7)))
BREAKS <- pretty(apply(y,2,max),8)
LEVS <- levels(cut(1, breaks=BREAKS))
COLS <- pal(length(BREAKS )-1)
z <- val2col(apply(y,2,max), col=COLS)

png("C:/study/columbia study/Exploratory Data Analys/Blog Post1/stream graph/stacked_stream_color_by_max.png", width=7, height=6, units="in", res=400)
layout(matrix(1:3, nrow=3, ncol=1), widths=7, heights=c(2.5,2.5,1), respect=TRUE)
par(mar=c(2,4,2,1), cex=0.75)
plot.stacked(x,y, xlim=c(100, 400), ylim=c(0, 1.2*max(apply(y,1,sum), na.rm=TRUE)), yaxs="i", col=z, border="white", lwd=0.5)
mtext("Stacked plot", line=0.25, side=3)
box()
plot.stream(x,y, xlim=c(100, 400), center=TRUE, order.method="max", spar=0.3, frac.rand=0.2, col=z, border="white", lwd=0.5)
mtext("Stream plot", line=0.25, side=3)
box()
par(mar=c(1,4,0,1))
plot(1,t="n", xlab="", ylab="", axes=FALSE)
legend("center", legend=LEVS, border="white", fill=COLS, ncol=5, bty="n", title="Max value") #pch=22, pt.bg=COL)
dev.off()


#Plot Ex. 2 - Color by first value
ord <- order(apply(y, 2, function(r) min(which(r>0))))
y2 <- y[, ord]
pal <- colorRampPalette(c("blue", "cyan", "yellow", "red"))
z <- pal(ncol(y2))

png("C:/study/columbia study/Exploratory Data Analys/Blog Post1/stream graph/stacked_stream_color_by_first.png", width=7, height=5, units="in", res=400)
layout(matrix(1:2, nrow=2, ncol=1), widths=7, heights=c(2.5,2.5), respect=TRUE)
par(mar=c(2,4,2,1), cex=0.75)
plot.stacked(x,y2, xlim=c(100, 400), ylim=c(0, 1.2*max(apply(y2,1,sum), na.rm=TRUE)), yaxs="i", col=z, border=1, lwd=0.25)
mtext("Stacked plot", line=0.25, side=3)
box()
plot.stream(x,y2, xlim=c(100, 400), center=FALSE, order.method="max", spar=0.1, frac.rand=0.05, col=z, border=1, lwd=0.25)
mtext("Stream plot", line=0.25, side=3)
box()
dev.off()
