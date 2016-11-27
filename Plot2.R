setwd("D:/Learning/DataScience/04ExploratoryDataAnalysis")

filename <- "exdataset.zip"
## Download an unzip the dataset
if(!file.exists(filename)){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, destfile = filename, method = "auto")    
}
if(!file.exists("household_power_consumption")){
    unzip(filename)
}

Electric <- read.table("household_power_consumption.txt", sep = ";", dec = ".",
                       header = TRUE)

Electric$Global_active_power <- as.numeric(Electric$Global_active_power)
Electric$Sub_metering_1 <- as.numeric(Electric$Sub_metering_1)
Electric$Sub_metering_2 <- as.numeric(Electric$Sub_metering_2)
Electric$Sub_metering_3 <- as.numeric(Electric$Sub_metering_3)
Datetime <- strptime(paste(Electric$Date, Electric$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
Electric$Date <- as.Date(Electric$Date, format = "%d/%m/%Y")
Electric <- data.frame(Electric, Datetime)
Electric_sub <- subset(Electric, Date == '2007-02-01' | Date == '2007-02-02')

png("Plot2.png", width = 480, height = 480)
plot(Electric_sub$Datetime, Electric_sub$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")
dev.off()