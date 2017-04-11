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
png("plot4.png", width = 480, height = 480, bg = "white")
par(mfrow=c(2,2))

## Chart 1
with (data, plot(DateTime, Global_active_power, ylim=range(Global_active_power), xlab="", ylab="Global Active Power", main = "", pch=".", col = "black"))
with (data,	lines(DateTime[order(DateTime)], Global_active_power[order(DateTime)], pch=".", col = "black"))

## Chart 2
with (data, plot(DateTime, Voltage, ylim=range(Voltage), xlab="datetime", ylab="Voltage", main = "", pch=".", col = "black"))
with (data,	lines(DateTime[order(DateTime)], Voltage[order(DateTime)], pch=".", col = "black"))

## Chart 3
with (data, plot(DateTime, Sub_metering_1, xlim=range(DateTime), ylim=range(Sub_metering_1), xlab="", ylab="Energy sub metering", main = "", pch=".", col = "black"))
with (data,	lines(DateTime[order(DateTime)], Sub_metering_1[order(DateTime)], pch=".", col = "black"))
par(new=T)
with (data, plot(DateTime, Sub_metering_2, xlim=range(DateTime), ylim=range(Sub_metering_1), pch=".", xlab="", ylab="Energy sub metering", col = "red"))
with (data,	lines(DateTime[order(DateTime)], Sub_metering_2[order(DateTime)], pch=".", col = "red"))
par(new=T)
with (data, plot(DateTime, Sub_metering_3, xlim=range(DateTime), ylim=range(Sub_metering_1), pch=".", xlab="", ylab="Energy sub metering", col = "blue"))
with (data,	lines(DateTime[order(DateTime)], Sub_metering_3[order(DateTime)], pch=".", col = "blue"))
with(data, legend( x="topright", 
        legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), 
        col=c("black","red","blue"), lwd=1, lty=c(1,1,1), 
        merge=FALSE ))

## Chart 4
with (data, plot(DateTime, Global_reactive_power, ylim=range(Global_reactive_power), xlab="datetime", ylab="Global_reactive_power", main = "", pch=".", col = "black"))
with (data,	lines(DateTime[order(DateTime)], Global_reactive_power[order(DateTime)], pch=".", col = "black"))
dev.off()
