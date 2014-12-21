library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


NEI_Balt <- NEI[NEI$fips=="24510",]

byYearAndType<-ddply(NEI_Balt,c("year","type"),function(row) sum(row$Emissions))
colnames(byYearAndType)<-c("year", "type", "count")

byYearAndType$year<-as.character(byYearAndType$year)

#Start PNG graphics
png(file="plot3.png")
g<-ggplot(data=byYearAndType, aes(x=year, y=count)) + facet_grid(. ~ type) + guides(fill=F) +
      geom_bar(aes(fill=type),stat="identity") +
      ylab('PM2.5 Emissions') + xlab('Year') + 
      ggtitle('Emissions By Type in Baltimore') + geom_jitter(alpha=0.10)
print(g)

dev.off()
