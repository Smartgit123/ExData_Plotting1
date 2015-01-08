# Date: 8 January, 2015

# Plot4.R. Creates a plot containing four line graphs representing a two day
# summary of power consumption data including Global Active Power, Voltage,
# Sub-metering data and Global Reactive Power.
# Code written to work from the start date to end date with any number of days in 
# between.
# - - - - - - - - - - - - SET UP - - - - - - - - - - - - - - - - - - - - - #
setwd("~/R working directory/Course Project 1")     # Set working directory
library(data.table)                                 # Load data.table package
options(datatable.by = NULL)  
# - - - - - - - READ FILE AND PREPARE DATA  - - - - - - - - - - - - - - - #
dat <- fread("household_power_consumption.txt",sep=";",nrows=-1L,na.strings="?",
        colClasses = "character")                   # Read the text file               

dat$Date <- as.Date(dat$Date,format="%d/%m/%Y")     # Change Date to date format

start <- as.Date("1/2/2007", format="%d/%m/%Y")     # Set the start and end date
end <- as.Date("2/2/2007", format="%d/%m/%Y")          

dataSet <- dat[dat$Date %in% seq(start,             # dataSet data by dates
                                end, by=1) ,]          
dataSet <- data.frame(dataSet)                      # Change dataSet to data.frame

for(i in c(3:9)) {                                  # Change columns to as.numeric
        dataSet[,i] <- as.numeric(as.character(dataSet[,i]))
}   
midnight <- (format(dataSet$Time) == "00:00:00")    # Locate beginning of day
positions <- c(which(midnight),(nrow(dataSet)+1))   # Store positions in list
                                                    # Include an end position

abbrevLabels<-weekdays(seq(start,as.Date(end+1),by=1),abbreviate=TRUE) 
                                                    # Create list of weekday labels
# - - - - - - - - - -  PLOT GRAPHS  - - - - - - - - - - - - - - - #
png(filename="plot4.png",width=480,height=480,bg="transparent")      
                                                    # Set graphics device

par(mfcol = c(2, 2))                                # Set-up plot array
par(cex.axis=0.95,cex.lab=0.95)                     # Set all headings to be reduced to 0.95

with(dataSet, {                                     # Use with function to plot 
# PLOT 1                                               
plot(Global_active_power,type="l",xlab=" ",ylab="Global Active Power",xaxt='n')
axis(side=1,at=positions,labels=abbrevLabels)

# PLOT 2
plot(Sub_metering_1,type="l",xlab=" ",ylab="Energy sub metering",xaxt='n')
lines(Sub_metering_2, col=2, type='l')              
lines(Sub_metering_3, col=4, type='l')                 
axis(side=1,at=positions,labels=abbrevLabels)
legend("topright",bty="n",legend=c("Sub_metering_1","Sub_metering_2",       
        "Sub_metering_3"),col=c(1,2,4),lty=1,cex=0.95)                                        
# PLOT 3 
plot(Voltage,type="l",xlab="datetime",ylab="Voltage",xaxt='n')
axis(side=1, at=positions, labels=abbrevLabels)                             

# PLOT 4
plot(Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power",
     xaxt='n')                   
axis(side=1, at=positions, labels=abbrevLabels)
}
)
dev.off()                                           # Terminate the device driver 
# - - - - - - - - - - - - - - - - END OF CODE - - - - - - - - - - - - - - - - - - - -#
# Data source: UC Irvine Machine Learning Repository. Dataset: Electric power 
# consumption (20MB). 
# # https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# # https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption

# Global Active Power = household global minute-averaged active power (in kilowatts)
# Sub-metering  
# No.1 = active energy used in the kitchen - dishwasher, oven and microwave 
# No.2 = active energy used in the laundry - washing-machine, tumble-drier,refrigerator
# and light
# No.3 = active energy used in electric water-heater and an air-conditioner
# Voltage = minute-averaged voltage (in volt)
# Global Reactive Power = household global minute-averaged reactive power (in kilowatt)

# Notes: 
# 1. As an alternative the x axis labelling could have been generated with the datetime/
# strptime-type ="s" method.
# 2. Background set to transparent to match the reference plots on github.
# 3. Size of plot set to 480 x 480 pixels as outlined in course project instructions.

# Completed as part of the online course in "Exploratory Data Analysis", John Hopkins
# University.