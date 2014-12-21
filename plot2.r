library(plyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


NEI_Balt <- NEI[NEI$fips=="24510",]

byYear<-ddply(NEI_Balt,c("year"),function(row) sum(row$Emissions))
colnames(byYear)<-c("year","count")

png(file="plot2.png",width=480,height=480)
plot(byYear, xlab="Year",ylab="PM2.5 Emissions",main="Plot of PM2.5 Emissions By Year in Baltimore",type="o",col="darkgreen",pch=19)

dev.off()
