## This is assignment from Week 1 Plot 2 of Coursera -> Data Science -> exploratory-data-analysis
## https://www.coursera.org/learn/exploratory-data-analysis/peer/ylVFo/course-project-1

## Downloading and unzip raw data

library(data.table)
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url, temp)
unzip(temp)

## Reading raw data and filter for the dates required
powerconsp<-read.table(file="household_power_consumption.txt", header = TRUE, sep = ";",na.strings = "?",strip.white = TRUE)
rm(temp)
data <- subset(powerconsp, Date =="1/2/2007" | Date =="2/2/2007")


## Creating a new DateTime field which joins the Date and Time columns for Plot2
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")


## Steps to create the png file
png("plot2.png", width = 480, height = 480, bg = "white")
with (data, plot(DateTime, Global_active_power, xlim=range(DateTime), ylim=range(Global_active_power), xlab="", ylab="Global Active Power (kilowatts)", main = "",pch="."))
with (data, lines(DateTime[order(DateTime)], Global_active_power[order(DateTime)], xlim=range(DateTime), ylim=range(Global_active_power), pch="."))
dev.off()
