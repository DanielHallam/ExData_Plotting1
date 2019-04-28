## script to read house energy data and save 4 plots to file

## downloads source file from website
## name of file on website
sourcezipfile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
## name of local zip file
destzipfile <-"household_power_consumption.zip"
## source file within zip file
datafile <- "household_power_consumption.txt"

## only download if not already downloaded
if(!file.exists(destzipfile)){
	download.file(
		sourcezipfile, 
		destzipfile, 
		method="curl"
	)
}

## unzips file and reads into data table
alldata <- read.table(unz(destzipfile, datafile), 
					  header=T, quote="\"", 
					  sep=";", 
					  na.strings = "?", 
					  stringsAsFactors = F
)

## subset relevant data
data <- subset(
	alldata, 
	as.Date(Date, format="%d/%m/%Y") >= "2007-02-01" & 
		as.Date(Date, format="%d/%m/%Y")<="2007-02-02"
)

## set to use 4 plots in 2x2 matrix
par(mfrow = c(2,2), mar = c(4,4,2,2))

## plot 1
## line chart of global active power vs time
plot(
	strptime(
		paste(data$Date, data$Time), 
		format="%d/%m/%Y %H:%M:%S"
	), 
	data$Global_active_power, 
	type="l",
	ylab = "Global Active Power (kilowatts)",
	xlab = ""
)

## plot 2
## line chart of voltage vs time
plot(
	strptime(
		paste(data$Date, data$Time), 
		format="%d/%m/%Y %H:%M:%S"
	), 
	data$Voltage, 
	type="l",
	ylab = "Voltage",
	xlab = "datetime"
)

## plot 3
## line plot of voltage vs time
plot(
	strptime(
		paste(data$Date, data$Time), 
		format="%d/%m/%Y %H:%M:%S"
	), 
	data$Sub_metering_1, 
	type="l",
	ylab = "Energy sub metering",
	xlab = ""
)

## add line plot of sub metering 2
lines(
	strptime(
		paste(data$Date, data$Time), 
		format="%d/%m/%Y %H:%M:%S"
	), 
	data$Sub_metering_2, 
	type="l",
	col = "red"
)

## add line plot of sub metering 3
lines(
	strptime(
		paste(data$Date, data$Time), 
		format="%d/%m/%Y %H:%M:%S"
	), 
	data$Sub_metering_3, 
	type="l",
	col = "blue"
)

## add legend
legend(
	"topright", 
	legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
	col = c("black", "red", "blue"),
	lty = 1
)

## plot 4
## line plot for global reactive power vs time
plot(
	strptime(
		paste(data$Date, data$Time), 
		format="%d/%m/%Y %H:%M:%S"
	), 
	data$Global_reactive_power, 
	type="l",
	ylab = "Global_reactive_power",
	xlab = "datetime"
)

## copy to png file
dev.copy(
	png, 
	filename = "plot4.png", 
	width = 480, 
	height = 480
)

## close png file
dev.off()