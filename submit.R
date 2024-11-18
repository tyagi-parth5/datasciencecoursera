# Load the necessary library
library(data.table)

# Load the data
data <- fread("household_power_consumption.txt", sep=";", na.strings = "?")

# Convert Date and Time columns to Date/Time classes
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$Time <- strptime(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

# Subset data for the dates 2007-02-01 and 2007-02-02
data_sub <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")




# Load necessary library
library(data.table)

# Load and preprocess the data
data <- fread("household_power_consumption.txt", sep=";", na.strings = "?")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$Time <- strptime(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")
data_sub <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

# Plot 1: Histogram of Global Active Power
png("plot1.png", width=480, height=480)
hist(as.numeric(data_sub$Global_active_power), 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     col="red", 
     breaks=50)
dev.off()



# Plot 2: Time Series of Global Active Power
png("plot2.png", width=480, height=480)
plot(data_sub$Time, as.numeric(data_sub$Global_active_power), 
     type="l", 
     xlab="Time", 
     ylab="Global Active Power (kilowatts)", 
     main="Global Active Power Over Time", 
     col="black")
dev.off()



# Plot 3: Energy Sub-metering Comparison
png("plot3.png", width=480, height=480)
plot(data_sub$Time, as.numeric(data_sub$Sub_metering_1), 
     type="l", 
     xlab="Time", 
     ylab="Energy Sub Metering", 
     main="Energy Sub-metering Comparison", 
     col="black")
lines(data_sub$Time, as.numeric(data_sub$Sub_metering_2), col="red")
lines(data_sub$Time, as.numeric(data_sub$Sub_metering_3), col="blue")
legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), 
       lty=1)
dev.off()



# Plot 4: Voltage vs. Global Active Power
png("plot4.png", width=480, height=480)
plot(as.numeric(data_sub$Global_active_power), 
     as.numeric(data_sub$Voltage), 
     xlab="Global Active Power (kilowatts)", 
     ylab="Voltage (volts)", 
     main="Voltage vs. Global Active Power", 
     col="purple", 
     pch=20)
dev.off()

