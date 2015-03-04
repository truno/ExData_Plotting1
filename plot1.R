# Assumes that household_power_consumption.txt has been unzipped from
# exdata_data_household_power_consumption.zip resides in the working data
# Also assumes that there are no NA values in the Date field

epc <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                  stringsAsFactors  = FALSE, na.strings = "?")

# Convert $Data character into Date class
epc$Date <- as.Date(epc$Date, "%d/%m/%Y")

# Subset the data to the two days needed for the plots
plotData <- epc[epc$Date >= "2007-02-01" & epc$Date <= "2007-02-02",]

# Convert $Time into POSIXlt class
plotData$Time <- strptime(paste(plotData$Date, plotData$Time), 
                          "%Y-%m-%d %H:%M:%S")

png(file = "rplot1.png", width = 480, height = 480)
hist(plotData$Global_active_power, col = "red", 
     xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()