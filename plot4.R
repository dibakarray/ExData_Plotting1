setwd("C:\\exdt")
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
localzipfie<- "household_power_consumption.zip"
localfile <- "household_power_consumption.txt"
##
if (!file.exists(localfile)) {
  download.file(fileURL, localzipfie)
  unzip(localzipfie, overwrite = T, exdir = ".")
}
## Read Complete Data set
bigdataset <- read.csv(localfile , header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
# convert date and time variables 

    bigdataset$Time <- strptime(paste(bigdataset$Date, bigdataset$Time), "%d/%m/%Y %H:%M:%S")
    bigdataset$Date <- as.Date(bigdataset$Date, "%d/%m/%Y")

# Filter out data for the Date range 2007-02-01 and 2007-02-02
    data <- subset(bigdataset , subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# Plot 4
## Multiple graph in same page. 2 X 2
par(mfrow=c(2,2))
# First Plot
    plot(data$Time, data$Global_active_power,
         type="l",
         xlab="",
         ylab="Global Active Power")
# Second Plot
    plot(data$Time, data$Voltage, type="l",
         xlab="datetime", ylab="Voltage")
# Third Plot
    plot(data$Time, data$Sub_metering_1, type="l", col="black",
         xlab="", ylab="Energy sub metering")
    lines(data$Time, data$Sub_metering_2, col="red")
    lines(data$Time, data$Sub_metering_3, col="blue")


##Legend
##Most important issue is positioning the legend. use cex ,y.intersp,x.intersp for adjust position of the legend 
##Using  option bty = "n" in legend to remove the box around the legend

legend("topright",           col=c("black", "red", "blue"),           c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),  fill = 1:5, lty=1,  bty = "n",box.lwd=0,cex = 0.6,y.intersp=.2,x.intersp=.1) 
 
# Forth Plot
    plot(data$Time, data$Global_reactive_power, type="n",
         xlab="datetime", ylab="Global_reactive_power")
    lines(data$Time, data$Global_reactive_power)

## Put to file Png4

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()




