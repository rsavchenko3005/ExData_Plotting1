## Check Working Directory for 'data' folder
## If the 'data' folder does not exist, create it
if(!file.exists("data")) {
  dir.create("data")
}


## Download .zip file with data to create graph
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
data_dt <- within(data, {DateTime = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")})
class(data2$DateTime)


## Change locale of my R processes from default value to "english"
Sys.setlocale(category = "LC_ALL", locale = "english")


## Open PNG file device
## Create 'plot1.png' file in the './data' directory
png("./data/plot3.png", width = 480, height = 480, units = "px")


## Create plot without any data on it
with(data2, plot(DateTime, Sub_metering_1, type = "n",
                 ylab = "Energy sub metering", xlab = ""))

## Plotting data for each variables
with(data2, lines(DateTime, Sub_metering_1, col = "black"))
with(data2, lines(DateTime, Sub_metering_2, col = "red"))
with(data2, lines(DateTime, Sub_metering_3, col = "blue"))

## Add legend into the plot
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


## Close the PNG file device
dev.off()


## Change locale to default value
Sys.setlocale(category = "LC_ALL", locale = "ukrainian")