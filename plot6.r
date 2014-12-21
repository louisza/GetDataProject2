library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI.onroad <- NEI[NEI$type == 'ON-ROAD',]
NEI.onroad.balt.la <- NEI.onroad[NEI.onroad$fips=="24510" | NEI.onroad$fips=="06037",]

byYearAndFips<-ddply(NEI.onroad.balt.la,c("year","fips"),function(row) sum(row$Emissions))

byYearAndFips[byYearAndFips$fips=='06037',]$fips<-"Los Angeles"
byYearAndFips[byYearAndFips$fips=='24510',]$fips<-"Baltimore"
colnames(byYearAndFips)<-c("year", "city", "count")

byYearAndFips$count<-log(byYearAndFips$count) #log trick, thx to tip from github


png(file="plot6.png")
g<-ggplot(byYearAndFips, aes(x=year, y=count, color = city)) 
g<-g + geom_line(aes(width=3.0)) + xlab("Year") + ylab("log PM2.5 Emissions")
g<-g + ggtitle('Motor Vehicle Emissions of PM2.5 in Baltimore and Los Angeles') 
g<-g + theme_bw()
print(g)

dev.off()
