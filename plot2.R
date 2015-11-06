library(dplyr)
library(lubridate)
library(readr)


# Read in the "individual household electric power consumption" dataset from the
# UC Irvine Machine Learning Repository.
power <- read_delim("household_power_consumption.txt", ";",
                    col_types = cols(
                      col_date("%d/%m/%Y"),
                      col_character(),
                      col_double(),
                      col_double(),
                      col_double(),
                      col_double(),
                      col_double(),
                      col_double(),
                      col_double()),
                    na="?") %>%
  # We're only using data between 2007-02-01 and 2007-02-02 so everything else
  # can be removed.
  filter(Date >= as.Date("2007-02-01"),
         Date <= as.Date("2007-02-02")) %>%
  # Add a Date_Time column that's a combination of theDate and Time columns.
  mutate(Date_Time=ymd_hms(paste(Date, Time)))

# Output line chart as 480x480 PNG.
png("plot2.png")
plot(power$Date_Time,
     power$Global_active_power,
     type = "l",
     xlab="",
     ylab = "Global Active Power (kilowatts)")
dev.off()
