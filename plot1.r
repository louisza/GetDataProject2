library(plyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Using plyr to help aggregate the data
byYear<-ddply(NEI,c("year"),function(row) sum(row$Emissions))
colnames(byYear)<-c("year","count")
#Scale to million
byYear$count<-round(byYear$count/1000000)

png(file="plot1.png",width=480,height=480)
barplot(byYear$count, xlab="Year",ylab="PM2.5 Emissions (in Million)",main="Plot of PM2.5 Emissions By Year",col="blue",
        names.arg=c("1999","2002","2005","2008"))

dev.off()
