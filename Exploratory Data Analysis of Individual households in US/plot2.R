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
png("./plot2.png",width = 480,  height = 480)

plot(dataOfIntrest$Global_active_power~dataOfIntrest$Datetime,type="l",ylab="Global Active Power (kilowatts)", xlab="")

dev.off()

