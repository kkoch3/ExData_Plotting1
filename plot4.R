# Ken Koch
# Exploratory Data Analysis
# Project 1
# plot4.R
# November 30, 2016

library(sqldf)
library(lubridate)

# Use sql to only load the data for Feb 1 and Feb 2, 2007
df <- read.csv.sql("household_power_consumption.txt", header = TRUE, sep = ";", 
                   sql = "select * from file where Date = '2/1/2007' or Date = '2/2/2007'")

closeAllConnections()  #Close the SQL Connection

png("plot4.png")

#Set the palette to accept 4 plots and set margins
par(mfrow=c(2,2))
par(mar=c(3.5, 3.5, 2, 1))
par(oma=c(1,1,1,1))
par(mgp=c(2,1,0)) #margins for the labels relative to the plots

#Create the Global Active Power Plot
plot(as.POSIXct(strptime(paste(df$Date,df$Time), "%m/%d/%Y %H:%M:%S")), 
     df$Global_active_power, type = "o", pch = NA_integer_, xlab = NA_character_,
     ylab = "Global Active Power", axes = FALSE, ylim = range(0:8), cex.lab = 1)

#Here we add the axis labels. 
axis(1,at=c(as.POSIXct(strptime(paste(df$Date,"00:00:00"), "%m/%d/%Y %H:%M:%S")), 
            as.POSIXct(strptime("2/3/2007 00:00:00", "%m/%d/%Y %H:%M:%S"))),
     labels=format(c(as.POSIXct(strptime(paste(df$Date,"00:00:00"), "%m/%d/%Y %H:%M:%S")), 
                     as.POSIXct(strptime("2/3/2007 00:00:00", "%m/%d/%Y %H:%M:%S"))), "%a"),
     cex.axis=1)

axis(2, at = seq(0,6,by=2), labels = seq(0,6,by=2), xpd=TRUE, cex.axis=1)

#Draw a border around the plot
box(lty = "solid")


#Create the Voltage Plot
plot(as.POSIXct(strptime(paste(df$Date,df$Time), "%m/%d/%Y %H:%M:%S")), 
     df$Voltage, type = "o", pch = NA_integer_, xlab = "datetime",
     ylab = "Voltage", axes = FALSE, ylim = range(min(df$Voltage), max(df$Voltage)),
     cex.lab = 1)

#Here we add the axis labels. 
axis(1,at=c(as.POSIXct(strptime(paste(df$Date,"00:00:00"), "%m/%d/%Y %H:%M:%S")), 
            as.POSIXct(strptime("2/3/2007 00:00:00", "%m/%d/%Y %H:%M:%S"))),
     labels=format(c(as.POSIXct(strptime(paste(df$Date,"00:00:00"), "%m/%d/%Y %H:%M:%S")), 
                     as.POSIXct(strptime("2/3/2007 00:00:00", "%m/%d/%Y %H:%M:%S"))), "%a"),
     cex.axis=1)

minVoltage <- as.integer(min(df$Voltage))
if(minVoltage %% 2 != 0)
    minVoltage <- minVoltage + 1
maxVoltage <- as.integer(max(df$Voltage))

axis(2, at = seq(minVoltage, maxVoltage,by=2), 
     labels = seq(minVoltage, maxVoltage,by=2), xpd=TRUE, cex.axis=1)

#Draw a border around the plot
box(lty = "solid")


#Create the Sub Metering Plot
plot(as.POSIXct(strptime(paste(df$Date,df$Time), "%m/%d/%Y %H:%M:%S")), 
     df$Sub_metering_1, type = "l", pch = NA_integer_, xlab = NA_character_,
     ylab = "Energy Sub Metering", axes = FALSE, ylim = range(0:30), 
     cex.lab = 1)

lines(as.POSIXct(strptime(paste(df$Date,df$Time), "%m/%d/%Y %H:%M:%S")), 
      df$Sub_metering_2, type = "l", pch = NA_integer_, col = "red")

lines(as.POSIXct(strptime(paste(df$Date,df$Time), "%m/%d/%Y %H:%M:%S")), 
      df$Sub_metering_3, type = "l", pch = NA_integer_, col = "blue")

#Here we add the axis labels. 
axis(1,at=c(as.POSIXct(strptime(paste(df$Date,"00:00:00"), "%m/%d/%Y %H:%M:%S")), 
            as.POSIXct(strptime("2/3/2007 00:00:00", "%m/%d/%Y %H:%M:%S"))),
     labels=format(c(as.POSIXct(strptime(paste(df$Date,"00:00:00"), "%m/%d/%Y %H:%M:%S")), 
                     as.POSIXct(strptime("2/3/2007 00:00:00", "%m/%d/%Y %H:%M:%S"))), "%a"),
     cex.axis=1)

axis(2, at = seq(0,30,by=10), labels = seq(0,30,by=10), xpd=TRUE, cex.axis=1)

#Draw a border around the plot
box(lty = "solid")

#Create the legend
legend("topright", names(df)[7:9], col=c("black", "red", "blue"), lty = 1,
       cex = 1)


#Create the Global Reactive Power Plot
plot(as.POSIXct(strptime(paste(df$Date,df$Time), "%m/%d/%Y %H:%M:%S")), 
     df$Global_reactive_power, type = "l", pch = NA_integer_, xlab = "datetime",
     ylab = "Global_reactive_power", axes = FALSE, cex.lab = 1)

#Here we add the axis labels. 
axis(1,at=c(as.POSIXct(strptime(paste(df$Date,"00:00:00"), "%m/%d/%Y %H:%M:%S")), 
            as.POSIXct(strptime("2/3/2007 00:00:00", "%m/%d/%Y %H:%M:%S"))),
     labels=format(c(as.POSIXct(strptime(paste(df$Date,"00:00:00"), "%m/%d/%Y %H:%M:%S")), 
                     as.POSIXct(strptime("2/3/2007 00:00:00", "%m/%d/%Y %H:%M:%S"))), "%a"),
     cex.axis=1)

axis(2, at = seq(0, max(df$Global_reactive_power),by=0.1), 
     labels = seq(0, max(df$Global_reactive_power),by=0.1), xpd=TRUE, 
     cex.axis=1)

#Draw a border around the plot
box(lty = "solid")

dev.off()  #Close the device so the file is written

