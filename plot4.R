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

png(file = "rplot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
with(plotData, {
        plot(Time, Global_active_power, type = "l", 
             xlab = "", ylab = "Global Active Power (kilowatts)")
        plot(Time, Voltage, type = "l", 
             xlab = "datetime", ylab = "Voltage")
        plot(Time, Sub_metering_1, type = "l", 
             xlab = "", ylab = "Energy sub metering")
        points(Time, Sub_metering_2, type = "l", col = "red")
        points(Time, Sub_metering_3, type = "l", col = "blue")
        legend("topright", lty = 1, bty = "n",
               col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Time, Global_reactive_power, type = "l", xlab = "datetime")
})
dev.off()