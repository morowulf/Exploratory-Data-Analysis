# David Goble
# 10/11/2014
# Exploratory Data Analysis

library(lubridate);

file_name = "household_power_consumption.txt";
if ( ! file.exists(file_name) )
{
    # Download the file
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip";
    download.file(fileUrl, destfile="./consumption.zip", method="curl");
    
    # Unzip the file
    unzip("./consumption.zip");
    
    # Read in the file and filter out the days of interest
    file_list <- unzip("./consumption.zip", list = TRUE);
    
    file_name = file_list[1];
}

# Read in the file and filter out the days of interest
acs <- read.csv(as.character(file_name), header=TRUE, sep=";");
acs <- acs[as.Date(acs$Date, "%d/%m/%Y")=="2007-02-01" | as.Date(acs$Date, "%d/%m/%Y")=="2007-02-02",];
temp = wday(as.Date(acs$Date,"%d/%m/%Y"), label=TRUE);

# Generate the plot
png(file = "plot3.png", width = 480, height = 480);
plot(as.double(as.character(acs$Sub_metering_1)), type = "l", xlab = "", ylab = "Energy sub metering", xaxt = "n");
lines(as.double(as.character(acs$Sub_metering_2)), type = "l", col = "red");
lines(as.double(as.character(acs$Sub_metering_3)), type = "l", col = "blue");
axis(1,at=grep("^00:00:00", acs$Time), labels=unique(temp));
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"));
dev.off();
