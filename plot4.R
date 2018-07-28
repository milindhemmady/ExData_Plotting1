# plot4.R
library(dplyr)

# Load Household Power Consumption Data for 1st and 2nd Feb 2007
dataFilename <- "household_power_consumption.txt"
plotFilename <- "plot4.png"
startDateTime = as.POSIXct("2007-02-01 00:00:00")
endDateTime = as.POSIXct("2007-02-02 23:59:59")

dataColClasses <- c("character", "character", 
                     "numeric", "numeric", "numeric",
                     "numeric", "numeric", "numeric", 
                     "numeric")

data <- read.table(dataFilename, header = TRUE, sep = ";", 
              colClasses = dataColClasses,
              stringsAsFactors = FALSE,
              na.strings = "?") %>%
        mutate(
                datetime = as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))
        ) %>%
        filter(
                datetime >= startDateTime & datetime <= endDateTime
        )
              
# Open PNG file to write the graph 
png(filename=plotFilename,
    width = 480, height = 480, units = "px")

par(mfrow = c(2, 2))

with(data, {
        # Plot 1: datetime vs Global_active_power
        plot(datetime, Global_active_power, 
             type = "l", 
             xlab = "", ylab = "Global Active Power")
        # Plot 2: datetime vs Voltage
        plot(datetime, Voltage, 
             type = "l",
             ylab = "Voltage")
        # Plot 3: datetime vs Sub_metering
        plot(datetime, Sub_metering_1, col = "black", type = "l", 
             xlab = "", ylab = "Energy sub metering")
        points(datetime, Sub_metering_2, col = "red", type = "l")
        points(datetime, Sub_metering_3, col = "blue", type = "l")
        legend("topright", 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               col = c("black", "red", "blue"), 
               lty = c(1, 1, 1), bty="n")
        # Plot 4: datetime vs Global_reactive_power
        plot(datetime, Global_reactive_power, type = "l")
})

# Close PNG file
dev.off()
