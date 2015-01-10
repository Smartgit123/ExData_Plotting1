# Date: 8 January, 2015

# Plot1.R. Creates a histogram representing a two day representation of the Global 
# Active Power consumption.

# - - - - - - - - - - - - -  Set up   - - - - - - - - - - - - - - - - - - - - -

setwd("~/R working directory/Course Project 1")  # set working directory
library(data.table)  #  load package
options(datatable.by = NULL) # set by to NULL to avoid warning on 2nd run

# - - - - -  - - - -  Read file and prepare data   - - - - - - - - - - - - - - -

dat <- fread("household_power_consumption.txt",sep = ";",nrows = -1L,na.strings = "?", 
              colClasses = "character")  # read text file

dates<-c("1/2/2007","2/2/2007")  # set dates
subSet <- dat[dat$Date %in% dates ,]  #  subset data by dates

globalActivePower<-as.numeric(subSet$Global_active_power)  # create a numeric subset

# - - - - -  - - - -  Plot data and close device - - - - - - - - - - - - - - - -

png(filename="plot1.png",width=480,height=480,bg="transparent")  # set graphics device

par(cex.axis=0.95,cex.lab=0.95)  # plot labels at 0.95 of default size

hist(globalActivePower,col="red",main="Global Active Power",
     xlab="Global Active Power (kilowatts)",breaks=12)   # plot histogram 

dev.off()  # shut the graphics device

# - - - - - - - - - - - - -  End of code   - - - - - - - - - - - - - - - - - -
# Data source: UC Irvine Machine Learning Repository. Dataset: Electric power 
# consumption (20MB). 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Global Active Power = household global minute-averaged active power (in kilowatts)

# Notes: 
# 1. As an alternative the x axis labelling could have been generated with the datetime/
# strptime-type ="s" method.
# 2. Background set to transparent to match the reference plots on github.
# 3. Size of plot set to 480 x 480 pixels as outlined in course project instructions.

# Completed as part of the online course in "Exploratory Data Analysis", John Hopkins
# University.