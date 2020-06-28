url <-" https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists("household_power_consumption.txt")){
        download.file(url, destfile = "data.zip")
        unzip(data.zip)
}

data <- read.csv2("./household_power_consumption.txt")

data <- data[grep("^1/2/2007$|^2/2/2007$", data$Date),]

hist(as.numeric(data$Global_active_power), 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", col="blue")

dev.copy(png, file= "plot1.png", width =480, height =480)
dev.off()