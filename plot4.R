# plot4.R

if (file.exists("dat.RData")) 
    {
        # if data has been previously prepared, no need to download and process again
        # just load from saved data file
        load("dat.RData")
    } else {
    # do the following only if needed
    # print("now download file")
    # downloading file
    fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileurl,"exdata-data-household_power_consumption.zip")
    unzip("exdata-data-household_power_consumption.zip")
    ## huge file after unzip (126MB)
    
    # load data
    fn <- "household_power_consumption.txt"  
    dat<- read.table(fn,header = TRUE, sep = ";", na.strings = "?")
    unlink(fn)
    
    # subset data
    dat$Date<-as.Date(dat$Date,"%d/%m/%Y")
    dat <- subset(dat,Date %in% as.Date(c("2007-02-1","2007-02-02")))
    dat$DateTime<-strptime(paste(dat$Date,dat$Time),"%Y-%m-%d %H:%M:%S")
    save(dat,file="dat.RData")
}

# plot to png file
png("plot4.png",width=480,height=480,pointsize=16)

par(mfrow=c(2,2))
par(cex = 0.6)
par(mar = c(4, 4, 1, 1), oma = c(2, 2, 0.5, 0.5))

# panel 1
plot(dat$DateTime,dat$Global_active_power,
     ylab="Global Active Power",
     xlab = "",
     type="l")
# panel 2
plot(dat$DateTime,dat$Voltage,
     ylab ="Voltage",
     xlab = "datetime",
     type="l")
# panel 3
plot(dat$DateTime,dat$Sub_metering_1,
     ylab="Energy sub metering",
     xlab = "",
     col = "black",
     type="l")
lines(dat$DateTime,dat$Sub_metering_2,
      col = "red")
lines(dat$DateTime,dat$Sub_metering_3,
      col = "blue")
legend("topright",# inset= c(-0.4,-0.1),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),
       bty="n",
       lwd=1)
# panel 4
plot(dat$DateTime,dat$Global_reactive_power,
     ylab ="Global_reactive_power",
     xlab = "datetime",
     type="h")

dev.off()
