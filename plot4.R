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

# Create and export historgram plot4.png

#png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2))
with(hpc, {
        plot(   DateTime,
                Global_active_power,
                type="l",
                xlab="",
                ylab="Global Active Power"
        )
        plot(   DateTime,
                Voltage,
                type="l",
                xlab="datetime",
                ylab="Voltage"
        )
        plot(   hpc$DateTime,
                hpc$Sub_metering_1,
                type="s",
                xlab="",
                ylab="Energy sub metering"
        )
        lines(  hpc$DateTime,
                hpc$Sub_metering_2,
                type="s",
                col="red"
        )
        lines(  hpc$DateTime,
                hpc$Sub_metering_3,
                type="s",
                col="blue")
        legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               col=c("black","red", "blue"), 
               lty=1, 
               cex=.3,
               y.intersp = 1,
               bty="n")
                
        plot(   DateTime,
                Global_reactive_power,
                type="l",
                xlab="datetime",
                ylab="Global_reactive_power"
        )
        
})

dev.copy(png,"plot4.png", width=480, height=480)
dev.off()



