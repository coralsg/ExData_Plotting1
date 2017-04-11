## This is assignment from Week 1 Plot 1 of Coursera -> Data Science -> exploratory-data-analysis
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

## Subset data for dates required
data <- subset (powerconsp, Date =="1/2/2007" | Date == "2/2/2007")


## Steps to create the png file
png("plot1.png", width = 480, height = 480, bg = "white")
hist(data$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")
dev.off()
