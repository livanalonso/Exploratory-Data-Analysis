# Download the data
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="dataset.zip",method="curl")
        
# Unzip data
unzip("dataset.zip")

# Remove zip file
file.remove("dataset.zip")

# Reading file
data<-read.table("household_power_consumption.txt",header = TRUE,sep=";",na.strings="?")

## Combine Date and Time column and create new column
data$Date.Time<-strptime(paste(data$Date,data$Time, sep=" "),"%d/%m/%Y %H:%M:%S")

# Subset data 
data$Date<-as.Date(as.Date(data$Date,"%d/%m/%Y"))
subset.data<-subset(data,as.POSIXct(Date)==as.POSIXct(as.Date("01/02/2007","%d/%m/%Y")) | as.POSIXct(Date)==as.POSIXct(as.Date("02/02/2007","%d/%m/%Y")))

# Plot data
png(file="plot3.png",width = 480, height = 480)
with(subset.data,plot(Date.Time,Sub_metering_1,xlab="\n",ylab="Energy sub metering",type="l",col="black"))
with(subset.data,lines(Date.Time,Sub_metering_2,xlab="\n",type="l",col="red"))
with(subset.data,lines(Date.Time,Sub_metering_3,xlab="\n",type="l",col="blue"))
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

file.remove("household_power_consumption.txt")

