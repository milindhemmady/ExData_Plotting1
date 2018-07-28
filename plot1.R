# plot1.R
library(dplyr)

# Load Household Power Consumption Data for 1st and 2nd Feb 2007
dataFilename <- "household_power_consumption.txt"
plotFilename <- "plot1.png"
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

# Plot the Histogram for Global_active_power
with(data, {
        hist(Global_active_power,
             main = "Global Active Power",
             xlab = "Global Active Power (kilowatts)",
             col = "red",
             plot = TRUE)
})        

# Close PNG file
dev.off()
