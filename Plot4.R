## Plot 4: Multiple base plots

## download and unzip the data file
fileUrl_1 =  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
f1 = file.path(getwd(), "household_power_consumption.zip")
download.file(fileUrl_1, f1, method = "curl")
unzip("household_power_consumption.zip")

## Load the data set.
df_1 <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "NA")

## change class of "Date" column form character to data.
df_1$Date <- as.Date(df_1$Date, format = "%d/%m/%Y")

## Subset data from Feb 1 2007 to Feb 2 2007
df_1_subset <- subset(df_1, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

## Change class of Global_active_power from character to numeric
df_1_subset$Global_active_power <- as.numeric(df_1_subset$Global_active_power)

## Change class of Sub_meterings
df_1_subset$Sub_metering_1 <- as.numeric(df_1_subset$Sub_metering_1)
df_1_subset$Sub_metering_2 <- as.numeric(df_1_subset$Sub_metering_2)
df_1_subset$Sub_metering_3 <- as.numeric(df_1_subset$Sub_metering_3)

## Add a new column, DateTime by combining "Date" column and "Time" column. 
df_1_subset$DateTime <- strptime(paste(df_1_subset$Date, df_1_subset$Time, sep = ""), "%Y-%m-%d %H:%M:%S")

## Launch a PNG (graphic device) to create a PNG file with a width of 480 pixels and a height of 480 pixels
png(filename = "plot4.png", width = 480, height = 480)

## Draw multiple base plots (2 by 2)
par(mfrow = c(2, 2))

## Make the 1st plot; Global Active Power over time
with(df_1_subset, plot(df_1_subset$DateTime, df_1_subset$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))

## Make the 2nd plot; Voltage over time
with(df_1_subset, plot(df_1_subset$DateTime, df_1_subset$Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))

## Make the 3rd plot; Energy Submetering over time
with(df_1_subset, plot(df_1_subset$DateTime, df_1_subset$Sub_metering_1, type = "l", xlab = "",
                       ylab = "Energy sub metering"))
lines(df_1_subset$DateTime, df_1_subset$Sub_metering_2, type = "l", col = "red")
lines(df_1_subset$DateTime, df_1_subset$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Make the 4th plot; Global Reactive Power over time
with(df_1_subset, plot(df_1_subset$DateTime, df_1_subset$Global_reactive_power, type = "l", xlab = "datetime", 
                       ylab = "Global_reactive_power"))

dev.off()
