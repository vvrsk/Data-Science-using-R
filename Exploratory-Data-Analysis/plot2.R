#Plot 2
#Getting the Data of Interest - That is Baltimore Data

baltimore_data <- subset(NEI, fips == "24510") 

#Aggregarting the data based on the condition
aggregatedTotalByYear_baltimore <- aggregate(Emissions ~ year, baltimore_data, sum)
plot.new()
png('Plot2_submit.png', width=800, height=500, units='px')

barplot(height=aggregatedTotalByYear_baltimore$Emissions, names.arg=aggregatedTotalByYear_baltimore$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions at various years'))

#Closing the device
dev.off()

