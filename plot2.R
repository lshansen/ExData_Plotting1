# Get data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists("exdata_data_household_power_consumption.zip")) {
        download.file(fileURL, "exdata_data_household_power_consumption.zip", method = "curl")
}

if (!file.exists("exdata_data_household_power_consumption.txt")) {
        unzip("exdata_data_household_power_consumption.zip")
}

power <- read.csv("exdata_data_household_power_consumption.txt", header = TRUE, sep =";", na.strings = "?", nrows = 2075259, check.names = FALSE, stringsAsFactors = FALSE, comment.char = "", quote = '\"' )

# Subset data on Feb 1, 2007 and Feb 2, 2007
subPower <- subset(power, Date %in% c("1/2/2007","2/2/2007"))

# Convert Date to Date class
subPower$Date <- as.Date(subPower$Date, format = "%d/%m/%Y")

# Create new variable DateTime
DateTime <- paste(as.Date(subPower$Date), subPower$Time)
subPower$DateTime <- as.POSIXct(DateTime)

# Initiate and annotate plot
with(subPower, plot(Global_active_power~DateTime, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

# Create PNG of plot
dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()