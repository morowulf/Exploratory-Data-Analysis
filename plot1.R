# David Goble
# 10/11/2014
# Exploratory Data Analysis

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

# Generate the plot
png(file = "plot1.png", width = 480, height = 480);
hist(as.double(as.character(acs$Global_active_power)), col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)");
dev.off();
