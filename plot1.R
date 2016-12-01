# Ken Koch
# Exploratory Data Analysis
# Project 1
# plot1.R
# November 30, 2016

library(sqldf)
# Use sql to only load the data for Feb 1 and Feb 2, 2007
df <- read.csv.sql("household_power_consumption.txt", header = TRUE, sep = ";", 
                   sql = "select * from file where Date = '2/1/2007' or Date = '2/2/2007'")

closeAllConnections()  #Close the SQL Connection

png("plot1.png")

#Create the histogram without axis labels, we'll add them later to make them look as 
#specified in the assignment instructions
hist(df$Global_active_power, main = "Global Active Power", col = "red", 
     xlab = "Global Active Power (kilowatts)", axes = FALSE, cex.lab = 0.75)

#Here we add the axis labels. cex.axis sets the font size and the xpd parameter
#allows the tick labels to exceed the drawing area
axis(1, at = seq(0,6,by=2), labels = seq(0,6,by=2), cex.axis=0.75, xpd=TRUE)
axis(2, at = seq(0,1200,by=200), labels = seq(0,1200,by=200), cex.axis=0.75)

dev.off()  #Close the device so the file is written