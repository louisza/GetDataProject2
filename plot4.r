library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


coalIdx<-grep("coal",tolower(SCC$Short.Name),fixed = TRUE)
SCC_Coal<-SCC[coalIdx,c("SCC","Short.Name")]

NEI_Coal<-merge(NEI, SCC_Coal, by="SCC")

byYear<-ddply(NEI_Coal,c("year"),function(row) sum(row$Emissions))
colnames(byYear)<-c("year", "count")

byYear$count<-round(byYear$count/1000)


png(file="plot4.png",width=480,height=480)
g<-ggplot(data=byYear, aes(x=year, y=count)) + 
      geom_line() + geom_point(aes(size=2)) + 
      ggtitle('Total Emissions of PM2.5 from Coal') + 
      ylab('PM2.5 Emissions (in thousands)') + xlab('Year') + 
      geom_text(aes(label=round(count,digits=0), size=2, hjust=1.5, vjust=1.5))
print(g)

dev.off()
