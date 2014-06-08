##Read in electric power consumption data.  Raw data must be unzipped and in working directory
power <- read.table("household_power_consumption.txt", sep=";", header = TRUE, stringsAsFactors = FALSE)
##Convert Date variable to date format
newdate <- as.Date(as.character(power$Date), format = "%d/%m/%Y")
power$Date <- newdate
##Subset to only days 2007-02-01 and 2007-02-02
usepower <- power[(power$Date == "2007-02-01")|(power$Date == "2007-02-02"),]
##Merge date and time variables into single column
newtime <- paste(as.character(usepower$Date), as.character(usepower$Time), sep = " ")
datetime <- strptime(newtime, format = "%Y-%m-%d %H:%M:%S")
usepower$datetime <- datetime
##Convert power variables to numeric
usepower$Global_active_power <- as.numeric(usepower$Global_active_power)
usepower$Global_reactive_power <- as.numeric(usepower$Global_reactive_power)
usepower$Voltage <- as.numeric(usepower$Voltage)
usepower$Sub_metering_1 <- as.numeric(usepower$Sub_metering_1)
usepower$Sub_metering_2 <- as.numeric(usepower$Sub_metering_2)
usepower$Sub_metering_3 <- as.numeric(usepower$Sub_metering_3)

##Generate plot 2 and save to png file
png(filename = "plot2.png", width = 480, height = 480)
plot(usepower$datetime, usepower$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab="")
dev.off()