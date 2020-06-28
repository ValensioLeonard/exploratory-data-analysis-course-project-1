library(data.table)


url <-" https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists("household_power_consumption.txt")){
        download.file(url, destfile = "data.zip")
        unzip(data.zip)
}

data <- data.table::fread("./household_power_consumption.txt", na.strings = "?")
data$Global_active_power <- as.numeric(data$Global_active_power)

data[, dateTime:=as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]


data <- data[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]


plot(data$dateTime, data$Global_active_power, type="l", xlab="" ,ylab = "Global Active Power (kilowatts)")

dev.copy(png, file ="plot2.png")
dev.off()