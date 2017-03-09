# Read the data
directory <- "./data/household_power_consumption.txt"

household_power_consumption <- read.csv(directory, sep=";", na.strings="?", stringsAsFactors=FALSE)

# Convert the date into Date Type
household_power_consumption$Date <-as.Date(household_power_consumption$Date, format = "%d/%m/%Y")

#Subsetting the data
dataOfIntrest <- subset(household_power_consumption, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# conerting the Dates
datetime <- paste(as.Date(dataOfIntrest$Date),dataOfIntrest$Time)
dataOfIntrest$Datetime <- as.POSIXct(datetime)

# Plot for the Graph
png("./plot3.png",width = 480,  height = 480)

with(dataOfIntrest, { 
        plot(Sub_metering_1~dataOfIntrest$Datetime,type="l",ylab="Energy Sub Metering", xlab="")
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue')
})

legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))

dev.off()

