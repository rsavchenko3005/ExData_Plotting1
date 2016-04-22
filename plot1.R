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


## Open PNG file device
## Create 'plot1.png' file in the './data' directory
png("./data/plot1.png", width = 480, height = 480, units = "px")


## Create plot and send it to a file
with(data, hist(Global_active_power, col = "red", main = "Global Active Power", 
                xlab = "Global Active Power (kilowatts)"))


## Close the PNG file device
dev.off()