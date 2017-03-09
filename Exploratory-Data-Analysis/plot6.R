library(ggplot2)
library(scales)

#Getting the data of interest
motorvehicles_data_baltimore <- subset(NEI,(fips == "24510" & type =="ON-ROAD"))

#Aggregating the data
aggregatedTotalByYear_mtrveh_balti <- aggregate(Emissions ~ year, motorvehicles_data_baltimore, sum)

#Getting the data of interest
motorvehicles_data_losangeles <- subset(NEI,(fips == "06037" & type =="ON-ROAD"))

#Aggregating the data
aggregatedTotalByYear_mtrveh_la <- aggregate(Emissions ~ year, motorvehicles_data_losangeles, sum)

#Creating new columns to add cities information
aggregatedTotalByYear_mtrveh_balti$city <- "BM" #BM- BaltiMore
aggregatedTotalByYear_mtrveh_la$city <-"LA"   #LA - LosAngeles

merged2<- rbindlist(list(aggregatedTotalByYear_mtrveh_la,aggregatedTotalByYear_mtrveh_balti))

#adding the data fo LA first to the plot
plot6_init<- ggplot(data=aggregatedTotalByYear_mtrveh_balti, aes(x=year,y=Emissions)) +
        geom_line(size=1,linetype=2,color= "blue") + 
        geom_point(aes(size=Emissions))+
        theme(plot.title = element_text(hjust = 0.5))+scale_y_continuous(labels = comma)


# Adding the data of Baltimore to the plot
plot6<- plot6_init +
        geom_line(data=aggregatedTotalByYear_mtrveh_la, aes(x=year,y=Emissions),size=1,linetype=2,color="red") + 
        geom_point(data=aggregatedTotalByYear_mtrveh_la, aes(x=year,y=Emissions,size=Emissions))+
        labs(x="Year", y ="Total Emissions ", title = "Vehicle Emissions in Baltimore vs LA",size = "Emissions",color = "Cities")+scale_x_continuous(breaks = c(1999,2002,2005,2008))+
        annotate("text",x=2008,y=4500,label ="LA")+ annotate("text",x=2006,y=500,label ="Baltimore")

#getting the image
png('plot6.png', width=800, height=500, units='px')
print(plot6)
dev.off()

