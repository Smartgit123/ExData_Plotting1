# Date: 9 January, 2015
# R version 3.1.1

# Plot1.R. Creates a histogram representing a two day representation of the Global 
# Active Power consumption.

# - - - - - - - - - - - - -  Set up   - - - - - - - - - - - - - - - - - - - - -

setwd("~/R working directory/Course Project 1")  # set working directory
library(data.table)  #  load package
options(datatable.by = NULL) # set by to NULL to avoid warning

# - - - - -  - - - -  Read file and prepare data   - - - - - - - - - - - - - - -

dat <- fread("household_power_consumption.txt",sep = ";",nrows = -1L,na.strings = "?", 
              colClasses = "character")  # read text file

dates<-c("1/2/2007","2/2/2007")  # set dates
subSet <- dat[dat$Date %in% dates ,]  #  subset data by dates

globalActivePower<-as.numeric(subSet$Global_active_power)  # create a numeric subset

# - - - - -  - - - -  Plot data and close device - - - - - - - - - - - - - - - -

png(filename="plot1.png",width=480,height=480,bg="transparent")  # set graphics device

par(cex.axis=0.952381,cex.lab=0.952381,cex.main=1.05)  # Adjust label magnification - note #4

hist(globalActivePower,col="red",main="Global Active Power",
     xlab="Global Active Power (kilowatts)",breaks=12)   # plot histogram 

dev.off()  # shut the graphics device

# - - - - - - - - - - - - -  End of code   - - - - - - - - - - - - - - - - - -
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