library(ggplot2)
library(scales)
library(gridBase)
library(grid)
#Plot4

#Getting the Data of Interest - That is Baltimore Data
pollutantdata<- SCC[grepl("coal",SCC$Short.Name,ignore.case=TRUE),]

#MErging the Data to the NEI data

mergeeddata<- merge(NEI,pollutantdata,by='SCC')

#Aggregating the Merged Data accordig to requiremtns
aggregatedTotalByYear_Merged <- aggregate(Emissions ~ year, mergeeddata, sum)

png('plot4-Part1.png', width=800, height=500, units='px')

barplot(height=aggregatedTotalByYear_Merged$Emissions, names.arg=aggregatedTotalByYear_Merged$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions at various years due to coal'))

dev.off()

#Adding another plot for better understanding
png('plot4-additional.png',width=800, height=500, units='px')

ggplot(aggregatedTotalByYear_Merged,aes(x=year,y=Emissions))+geom_line( size = 0.5,linetype =3)+geom_point(aes(size = Emissions))+labs(x="Year", y ="Total Emissions ", title = "Total Emissions due to Coal vs Year")+scale_x_continuous(name= "Year",breaks = c(1999,2002,2005,2008))+theme(plot.title = element_text(hjust = 0.5))+scale_y_continuous(labels = comma)

dev.off()
