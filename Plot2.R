## Plot 2: Global Active Power from Thursday to Sat

## download and unzip the data file
fileUrl_1 =  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
f1 = file.path(getwd(), "household_power_consumption.zip")
download.file(fileUrl_1, f1, method = "curl")
unzip("household_power_consumption.zip")

## Load the data set.
df_1 <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "NA")

## change the class of "Date" column from character to data.
df_1$Date <- as.Date(df_1$Date, format = "%d/%m/%Y")

## Subset data from Feb 1 2007 to Feb 2 2007
df_1_subset <- subset(df_1, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

## Change the class of Global_active_power from character to numeric
df_1_subset$Global_active_power <- as.numeric(df_1_subset$Global_active_power)

## Add a new column, DateTime, by combining "Date" column and "Time" column. 
df_1_subset$DateTime <- strptime(paste(df_1_subset$Date, df_1_subset$Time, sep = ""), "%Y-%m-%d %H:%M:%S")

## Launch a PNG (graphic device) to create a PNG file with a width of 480 pixels and a height of 480 pixels
png(filename = "plot2.png", width = 480, height = 480)
with(df_1_subset, plot(df_1_subset$DateTime, df_1_subset$Global_active_power, type = "l", xlab = "", 
                       ylab = "Global Active Power (kilowatts)"))
dev.off()
