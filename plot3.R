# Get data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists("exdata_data_household_power_consumption.zip")) {
        download.file(fileURL, "exdata_data_household_power_consumption.zip", method = "curl")
}

if (!file.exists("household_power_consumption.txt")) {
        unzip("exdata_data_household_power_consumption.zip")
}

power <- read.csv("household_power_consumption.txt", header = TRUE, sep =";", na.strings = "?", nrows = 2075259, check.names = FALSE, stringsAsFactors = FALSE, comment.char = "", quote = '\"' )

# Subset data on Feb 1, 2007 and Feb 2, 2007
subPower <- subset(power, Date %in% c("1/2/2007","2/2/2007"))

# Convert Date to Date class
subPower$Date <- as.Date(subPower$Date, format = "%d/%m/%Y")

# Create new variable DateTime
DateTime <- paste(as.Date(subPower$Date), subPower$Time)
subPower$DateTime <- as.POSIXct(DateTime)

# Initiate and annotate plot
with(subPower, {
        plot(Sub_metering_1~DateTime, type = "l", xlab = "", ylab = "Energy sub metering")
        lines(Sub_metering_2~DateTime, col = "red")
        lines(Sub_metering_3~DateTime, col = "blue")
        legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

# Create PNG of plot
dev.copy(png, "plot3.png", width = 480, height = 480)
dev.off()