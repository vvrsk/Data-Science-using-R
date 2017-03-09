
library(ggplot2)
library(scales)

#Reading the Data into the System
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

#Function for finding the total Emissisos

totalemissons<- function(x=NULL,y=NULL){
        
        #Finding the Sum of the Values
        #total <-ifelse(missing(y),sum(NEI$Emissions[which(NEI$year == x)]),sum(NEI$Emissions[which(NEI$fips == y)]))
        total <-ifelse(missing(x),ifelse(missing(y),stop("Enter any Input to function!"),sum(NEI$Emissions[which(NEI$fips == y)])),ifelse(missing(y),sum(NEI$Emissions[which(NEI$year == x)]),with(NEI,which(fips==y & year==x))))
        # Returning the values
        total
}

#Plot 1- Using Base plot System


#Aggregarting the data based on the condition
aggregatedTotalByYear <- aggregate(Emissions ~ year, NEI, sum)

png('plot1.png', width=800, height=500, units='px')

barplot(height=aggregatedTotalByYear$Emissions, names.arg=aggregatedTotalByYear$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions at various years'))

#Closing the device
dev.off()

#Plot 1 - using ggplot2  

emiss_1999<- totalemissons(1999)
emiss_2002 <- totalemissons(2002)
emiss_2005 <- totalemissons(2005)
emiss_2008 <- totalemissons(2008)

data <-data.frame(yearofIntrst=c(1999,2002,2005,2008), Emissions= c(emiss_1999,emiss_2002,emiss_2005,emiss_2008))

png('plot1-ggplot2.png', width=800, height=500, units='px')

plot1<-ggplot(data,aes(x=yearofIntrst,y=Emissions/(10^6)))+geom_line( size = 0.5,linetype =3)+geom_point(aes(size = Emissions))+labs(x="Year", y ="Total Emissions (in millions)", title = "Total Emissions vs Year")+scale_x_continuous(name= "Year",breaks = c(1999,2002,2005,2008))+theme(plot.title = element_text(hjust = 0.5))+scale_y_continuous(labels = comma)

dev.off()
