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

# Output four plots as 480x480 PNG.
png("plot4.png")
par(mfrow=c(2, 2))
# Top left.
plot(power$Date_Time,
     power$Global_active_power,
     type = "l",
     xlab="",
     ylab = "Global Active Power")
# Top right.
plot(power$Date_Time,
     power$Voltage,
     type = "l",
     xlab="datetime",
     ylab="Voltage")
# Bottom left.
plot(power$Date_Time,
     power$Sub_metering_1,
     type="l",
     xlab="",
     ylab="Energy sub metering")
lines(power$Date_Time,
      power$Sub_metering_2,
      col="red")
lines(power$Date_Time,
      power$Sub_metering_3,
      col="blue")
legend("topright",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1, 1, 1),
       col=c("black", "red", "blue"),
       bty = "n")
# Bottom right.
plot(power$Date_Time,
     power$Global_reactive_power,
     type="l",
     xlab="datetime",
     ylab="Global_reactive_power")
dev.off()
