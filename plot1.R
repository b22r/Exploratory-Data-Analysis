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
  filter(Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# save to png
png("plot1.png", width = 480, height = 480)

# create plot
hist(power.cons.filter$Global_active_power,
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     main = "Global Active Power",
     col = "red")

# close device
dev.off()