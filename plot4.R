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

par(mfrow=c(2,2))

## plot 1
plot(data$dateTime, data$Global_active_power, type="l", xlab="" ,ylab = "Global Active Power (kilowatts)")

## plot 2
plot(data$dateTime, data$Voltage, type="l", xlab = "datetime", ylab = "Voltage")

## plot 3
with(data, plot(dateTime, Sub_metering_1,xlab="", ylab = "Energy Sub Metering", type="n"))
with(data, points(dateTime, Sub_metering_1, col="green", type="l"))
with(data, points(dateTime, Sub_metering_2, col="red", type="l"))
with(data, points(dateTime, Sub_metering_3, col="blue", type="l"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("green", "red", "blue"), lty=c(1,1), bty = "n", cex = 0.5)

## plot 4
plot(data$dateTime, data$Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power")


dev.copy(png, file ="plot4.png")
dev.off()
