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

##Draw Plot 2

    
plot(data$Time, data$Global_active_power,
         type="l",
         xlab="",
         ylab="Global Active Power (kilowatts)")



## Save output to File plot2.png
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()


