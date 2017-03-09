# Read the data
directory <- "./data/household_power_consumption.txt"

household_power_consumption <- read.csv(directory, sep=";", na.strings="?", stringsAsFactors=FALSE)

# Convert the date into Date Type
household_power_consumption$Date <-as.Date(household_power_consumption$Date, format = "%d/%m/%Y")

#Subsetting the data
dataOfIntrest <- subset(household_power_consumption, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# Open device to save as PNG

png(filename = "./plot1.png",width = 480, height = 480 )

#Plot the histogram
hist(dataOfIntrest$Global_active_power,main = "Global Active Power",xlab="Global_active_power(in kilowatts)",col = "red")

#Turn off the device
dev.off()

