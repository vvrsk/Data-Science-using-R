library(ggplot2)
library(scales)

#Getting the Data of Interest - That is Baltimore Data
baltimore_data_motorvehicles <- subset(NEI,(fips == "24510" & type =="ON-ROAD"))


#Aggregating the Merged Data accordig to requiremtns
aggregatedTotalByYear_balti_MV <- aggregate(Emissions ~ year, baltimore_data_motorvehicles, sum)

png('plot5.png', width=800, height=500, units='px')
barplot(height=aggregatedTotalByYear_balti_MV$Emissions, names.arg=aggregatedTotalByYear_balti_MV$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions at various years due to coal'))
dev.off()

png('plot5-Line.png', width=800, height=500, units='px')
ggplot(aggregatedTotalByYear_balti_MV,aes(x=year,y=Emissions))+geom_line( size = 0.5,linetype =3)+geom_point(aes(size = Emissions))+labs(x="Year", y ="Total Emissions ", title = "Total Emissions of Motor Vehicels in Baltimore vs Year")+scale_x_continuous(name= "Year",breaks = c(1999,2002,2005,2008))+theme(plot.title = element_text(hjust = 0.5))+scale_y_continuous(labels = comma)
dev.off()

png('plot5- Box plot.png', width=800, height=500, units='px')
boxplot(Emissions~year, data= baltimore_data_motorvehicles,log = "y", xlab= "Year", ylab = "Log(Emissisons)", main = "Log(Emissisons) vs Year for Baltimore Motor Vehicles")

dev.off()