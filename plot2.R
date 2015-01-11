# Date: 9 January, 2015
# R version 3.1.1
 
# Plot2.R. Creates a line graph representing a two day representation of the Global 
# Active Power consumption.

# - - - - - - - - - - - - - - - - - SET UP - - - - - - - - - - - - - - - - - - - - - -#
setwd("~/R working directory/Course Project 1")  # set working directory
library(data.table)  # load data.table package
options(datatable.by = NULL)  
# - - - - - - - - - - - - - READ FILE AND PREPARE DATA  - - - - - - - - - - - - - - - #

dat <- fread("household_power_consumption.txt",sep=";",nrows=-1L,na.strings = "?", 
        colClasses = "character")  # read text file using fread

dat$Date <- as.Date(dat$Date,format="%d/%m/%Y")  # change Date from character to date format

start <- as.Date("1/2/2007", format="%d/%m/%Y")  
end <- as.Date("2/2/2007", format="%d/%m/%Y")  # set the start and end date

dataSet <- dat[dat$Date %in% seq(start, end, by=1) ,]  # subset data by dates

glbActPower<-as.numeric(dataSet$Global_active_power)  # create a numeric subset

midnight <- (format(dataSet$Time) == "00:00:00")  # locate midnight (start of day)  
position <-c(which(midnight),  # store list of midnight positions for x axis labels
             (nrow(dataSet)+1))  # add one for the end of the axis

abbrevLabels<-weekdays(seq(start, as.Date(end+1), by=1), 
                       abbreviate = TRUE) # create a list of abbreviated weekday labels

# - - - - - - - - - - - - -  PLOT DATA AND CLOSE DEVICE - - - - - - - - - - - - - - - #

png( filename="plot2.png",width=480,height=480,bg="transparent")  # set graphics device

par(cex.axis=0.952381,cex.lab=0.952381) # # Adjust label magnification - note #4

plot(glbActPower,type="l",xlab=" ",ylab="Global Active Power (kilowatts)",
      xaxt='n')  # Line plot of global active power verses time
axis( side=1,at=position,labels=abbrevLabels)  # position abbreviated day labels on x axis

dev.off()  # shut the graphics device

# - - - - - - - - - - - - - - - - END OF CODE - - - - - - - - - - - - - - - - - - - -#
# Data source: UC Irvine Machine Learning Repository. Dataset: Electric power 
# consumption (20MB). 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Global Active Power = household global minute-averaged active power (in kilowatts)

# Notes: 
# 1. As an alternative the x axis labelling could have been generated with the datetime,
#    strptime method.
# 2. Background set to transparent to match the reference plots in "figure" folder above.
# 3. Size of plot set to 480 x 480 pixels as outlined in course project instructions.
# 4. Labels were adjusted due to the difference in size of this plot (480px) and the 
#    reference plot (504px). [480/504=0.952381] 

# Completed as part of the online course in "Exploratory Data Analysis", John Hopkins
# University - Coursera.