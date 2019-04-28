## script to read house energy data and save plot of global active power to file

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

## copy to png file
dev.copy(
	png, 
	filename = "plot2.png", 
	width = 480, 
	height = 480
)

## close png file
dev.off()