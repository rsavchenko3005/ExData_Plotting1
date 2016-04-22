## Check Working Directory for 'data' folder
## If the 'data' folder does not exist, create it
if(!file.exists("data")) {
  dir.create("data")
}


## Download file
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/power.zip")


## Extract files from the .zip file
unzip("./data/power.zip", exdir = "./data")


## Read data from .txt file with read.table() function
data <- subset(read.table("./data/household_power_consumption.txt", 
                          header = TRUE, sep = ";", na.strings = "?",
                          colClasses = c("character", "character", rep("numeric", 7))),
               Date == "1/2/2007" | Date == "2/2/2007")


## Combine data of variables Date and Time in new variable DateTime
## Save result in the new data.frame data2
data_dt <- within(data, {datetime = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")})


## Change locale of my R processes from default value to "english"
Sys.setlocale(category = "LC_ALL", locale = "english")


## Open PNG file device
## Create 'plot1.png' file in the './data' directory
png("./data/plot4.png", width = 480, height = 480, units = "px")


## Cpecify multiple plot
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))

## Create the first plot in the top left corner
with(data_dt, plot(datetime, Global_active_power, type = "l",
                 ylab = "Global Active Power (kilowatts)", xlab = ""))

## Create the second plot in the top right corner
with(data_dt, plot(datetime, Voltage, type = "l"))

## Create the third plot in the bottom left corner
with(data_dt, plot(datetime, Sub_metering_1, type = "n",
                 ylab = "Energy sub metering", xlab = ""))
with(data_dt, lines(datetime, Sub_metering_1, col = "black"))
with(data_dt, lines(datetime, Sub_metering_2, col = "red"))
with(data_dt, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", bty = "n", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Create the fourth plot in the bottom right corner
with(data_dt, plot(datetime, Global_reactive_power, type = "l"))


## Close the PNG file device
dev.off()


## Change locale to default value
Sys.setlocale(category = "LC_ALL", locale = "ukrainian")