# Ken Koch
# Exploratory Data Analysis
# Project 1
# plot2.R
# November 30, 2016

library(sqldf)
library(lubridate)

# Use sql to only load the data for Feb 1 and Feb 2, 2007
df <- read.csv.sql("household_power_consumption.txt", header = TRUE, sep = ";", 
                   sql = "select * from file where Date = '2/1/2007' or Date = '2/2/2007'")

closeAllConnections()  #Close the SQL Connection

png("plot2.png")

#Create the plot without axis labels, we'll add them later to make them look as 
#specified in the assignment instructions
plot(as.POSIXct(strptime(paste(df$Date,df$Time), "%m/%d/%Y %H:%M:%S")), 
     df$Global_active_power, type = "o", pch = NA_integer_, xlab = NA_character_,
     ylab = "Global Active Power (kilowatts)", axes = FALSE, ylim = range(0:6))

#Here we add the axis labels. 
axis(1,at=c(as.POSIXct(strptime(paste(df$Date,"00:00:00"), "%m/%d/%Y %H:%M:%S")), 
            as.POSIXct(strptime("2/3/2007 00:00:00", "%m/%d/%Y %H:%M:%S"))),
     labels=format(c(as.POSIXct(strptime(paste(df$Date,"00:00:00"), "%m/%d/%Y %H:%M:%S")), 
                     as.POSIXct(strptime("2/3/2007 00:00:00", "%m/%d/%Y %H:%M:%S"))), "%a"))

axis(2, at = seq(0,6,by=2), labels = seq(0,6,by=2), xpd=TRUE)

#Draw a border around the plot
box(lty = "solid")

dev.off()  #Close the device so the file is written

