# Date: 9 January, 2015
# R version 3.1.1

# Plot3.R. Creates a line plot representing a two day representation of the Energy 
# sub metering. This plot shows how to set up a line graph with multiple lines and
# colours including a legend.

# - - - - - - - - - - - - - - - - - SET UP - - - - - - - - - - - - - - - - - - - - - -#

setwd("~/R working directory/Course Project 1")        # Set working directory
library(data.table)                                    # Load data.table package
options(datatable.by = NULL)  

# - - - - - - - - - - - - - READ FILE AND PREPARE DATA  - - - - - - - - - - - - - - - #

dat <- fread("household_power_consumption.txt",sep=";",nrows=-1L,na.strings="?", 
             colClasses = "character")                 # Read text file

dat$Date <- as.Date(dat$Date,format="%d/%m/%Y")        # Change Date to date format

start <- as.Date("1/2/2007",format="%d/%m/%Y")  
end <- as.Date("2/2/2007", format="%d/%m/%Y")          # Set the start and end date

subSet <- dat[dat$Date %in% seq(start,end, by=1) ,]    # Subset data by dates

subMeteringOne <-as.numeric(subSet$Sub_metering_1) 
subMeteringTwo <-as.numeric(subSet$Sub_metering_2)
subMeteringThree <-as.numeric(subSet$Sub_metering_3)   # Create three lists of data

midnight <-(format(subSet$Time)=="00:00:00")           # Locate start of day 
position <-c(which(midnight),(nrow(subSet)+1))         # Store positions in list
                                                       # Add end position

abbrevLabels<-weekdays(seq(start,as.Date(end+1),by=1), 
                       abbreviate = TRUE)              # Create list of weekday labels

# - - - - - - - - - - - - -  PLOT DATA AND CLOSE DEVICE - - - - - - - - - - - - - - - #

png(filename = "plot3.png",width=480,height=480,bg="transparent")
                                                       # Set graphics device

par(cex.axis=0.95,cex.lab=0.95)                        # All labels to 0.95 of default

plot(subMeteringOne,type="l",xlab=" ",ylab="Energy sub metering",xaxt='n')
                                                       # Plot axes and headings

lines(subMeteringTwo, col=2, type='l')               
lines(subMeteringThree,col=4,type='l')                 # Draw other lines

axis( side=1,at=position,labels=abbrevLabels)          # Label bottom axis

legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),          
       col=c(1,2,4),lty = 1,cex=0.95)                  # Place legend in top corner

dev.off()                                              # Terminate the device driver 
                                                       
# - - - - - - - - - - - - - - - - END OF CODE - - - - - - - - - - - - - - - - - - - -#
# Data source: UC Irvine Machine Learning Repository. Dataset: Electric power 
# consumption (20MB). 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Sub-metering  
# No.1 = active energy used in the kitchen - dishwasher, oven and microwave 
# No.2 = active energy used in the laundry - washing-machine, tumble-drier,refrigerator
# and light
# No.3 = active energy used in electric water-heater and an air-conditioner

# Notes: 
# 1. As an alternative the x axis labelling could have been generated with the datetime,
# strptime method.
# 2. Background set to transparent to match the reference plots in "figure" folder above.
# 3. Size of plot set to 480 x 480 pixels as outlined in course project instructions.
# 4. Labels were reduced to 95.2381% because of the difference in size of this plot (480px) 
# and the reference plot (504px).The labels have a fixed size regardless of the plot size. 

# Completed as part of the online course in "Exploratory Data Analysis", John Hopkins
# University.