# Download the data of project
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="dataset.zip",method="curl")
        
# unzip data
unzip("dataset.zip")

# Remove zip file
file.remove("dataset.zip")

# Reading file
data<-read.table("household_power_consumption.txt",header = TRUE,sep=";",na.strings="?")

## Combine Date and Time column and create new column
data$Date.Time<-strptime(paste(data$Date,data$Time, sep=" "),"%d/%m/%Y %H:%M:%S")

data$Date<-as.Date(as.Date(data$Date,"%d/%m/%Y"))
subset.data<-subset(data,as.POSIXct(Date)==as.POSIXct(as.Date("01/02/2007","%d/%m/%Y")) | as.POSIXct(Date)==as.POSIXct(as.Date("02/02/2007","%d/%m/%Y")))

png(file="plot2.png",width = 480, height = 480)
with(subset.data,plot(Date.Time,Global_active_power,xlab="\n",ylab="Global Active Power (kilowatts)",type="l"))
dev.off()

file.remove("household_power_consumption.txt")

