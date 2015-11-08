# load libraries
library(readr)
library(dplyr)

# get data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
unzip("household_power_consumption.zip")

# parse data
house.power.consump <- read_delim("household_power_consumption.txt", delim = ";",
                                  col_types = list(
                                    Date = col_date("%d/%m/%Y"),
                                    Time = col_character()
                                  ),
                                  na = "?")

# subset to dates in focus
power.cons.filter <- house.power.consump %>%
  filter(Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02")) %>%
  mutate(date.time = as.POSIXct(paste(as.character(Date), as.character(Time), sep = " ")))

# save to png
png("plot3.png", width = 480, height = 480)

# create plot
plot(x = power.cons.filter$date.time, y = power.cons.filter$Sub_metering_1,
     type = "l",
     ylab = "Energy Sub Metering",
     xlab = "")
lines(x = power.cons.filter$date.time, y = power.cons.filter$Sub_metering_2,
      col = "red")
lines(x = power.cons.filter$date.time, y = power.cons.filter$Sub_metering_3,
      col = "blue")
legend("topright", lwd = 1, 
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# close device
dev.off()