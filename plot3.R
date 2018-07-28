# plot3.R
library(dplyr)

# Load Household Power Consumption Data for 1st and 2nd Feb 2007
dataFilename <- "household_power_consumption.txt"
plotFilename <- "plot3.png"
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

with(data, {
        # Plot the datetime vs Sub_metering_1
        plot(datetime, Sub_metering_1,
                col = "black",
                type = "l",
                xlab = "", 
                ylab = "Energy sub metering")
        # Add points for Sub_metering_2
        points(datetime, Sub_metering_2,
               col = "red",
               type = "l")
        # Add points for Sub_metering_3
        points(datetime, Sub_metering_3,
                         col = "blue",
                         type = "l")
        # Add Legends
        legend("topright", 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               col = c("black", "red", "blue"), 
               lty = c(1, 1, 1))
})

# Close PNG file
dev.off()
