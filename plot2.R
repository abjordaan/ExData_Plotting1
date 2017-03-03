# Create data frame of the household_power_consumption.txt data

pc <- read.table(file="household_power_consumption.txt",
                 #colClasses=c(,, "numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
                 na.strings = "?",
                 sep = ";", 
                 header = TRUE, 
                 col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)

# Filter data based on the dates below
hpc <- pc[(pc$Date == "1/2/2007" | pc$Date == "2/2/2007"),]

#Convert date column into propper date format
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y") #Format is the current format in the 

#Add datetime column in the correct format.
hpc$DateTime <- paste(as.Date(hpc$Date), hpc$Time)
hpc$DateTime = as.POSIXct(hpc$DateTime )

# Change the Global_active_power to a numeric format
# TODO: Should be done with import
hpc$Global_active_power <- as.numeric(hpc$Global_active_power)

# Create and export historgram plot2.png

plot(   hpc$DateTime,
        hpc$Global_active_power,
        type="l",
        xlab="",
        ylab="Global Active Power (kiliowats)"
)

dev.copy(png,"plot2.png", width=480, height=480)
dev.off()