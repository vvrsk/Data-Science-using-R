
library(ggplot2)
library(scales)

#Plot 3- ggplot plot

#Aggregarting the data based on the condition
aggregatedTotalByType_baltimore <- aggregate(Emissions ~ type, baltimore_data, sum)

plot3<-ggplot(aggregatedTotalByType_baltimore,aes(x=type,y=Emissions))+geom_bar(stat="identity")+labs(x="Type", y ="Total Emissions ", title = "Total Emissions vs Type")+theme(plot.title = element_text(hjust = 0.5))

png('plot3.png', width=800, height=500, units='px')
print(plot3)
dev.off()