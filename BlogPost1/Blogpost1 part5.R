testy <- matrix(0, nrow=35, ncol=22)
colnames(testy) <- colnames(ggdata2)
for(i in seq(ncol(testy))){
  TMP <- rnorm(22, mean=0, sd=0.5)
  fit <- smooth.spline(ggdata1[i,] ~ TMP)
  testy[i,] <- fit$y
}
testy <- replace(testy, testy<0.01, 0)
testy<-data.frame(testy)
testy
pal <- colorRampPalette(c(rgb(0.85,0.85,1), rgb(0.2,0.2,0.7)))
BREAKS <- pretty(apply(testy,2,max),8)
LEVS <- levels(cut(1, breaks=BREAKS))
COLS <- pal(length(BREAKS )-1)
z <- val2col(apply(testy,2,max), col=COLS)

png("C:/study/columbia study/Exploratory Data Analys/Blog Post1/stream graph/try5.png", width=7, height=5, units="in", res=400)
layout(matrix(1:2, nrow=2, ncol=1), widths=7, heights=c(2.5,2.5), respect=TRUE)
par(mar=c(2,4,2,1), cex=0.75)
plot.stacked(cc,testy, xlim=c(0, 100), ylim=c(0, 1.2*max(apply(testy,1,sum), na.rm=TRUE)), yaxs="i", col=z, border=1, lwd=0.25)
mtext("Stacked plot", line=0.25, side=3)
box()
plot.stream(cc,testy, xlim=c(0, 100), center=FALSE, order.method="max", spar=0.1, frac.rand=0.05, col=z, border=1, lwd=0.25)
mtext("Stream plot", line=0.25, side=3)
box()
dev.off()