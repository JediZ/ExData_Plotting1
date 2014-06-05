# plot3.R

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
png("plot3.png",width=480,height=480)
plot(dat$DateTime,dat$Sub_metering_1,
     ylab="Energy sub metering",
     xlab = "",
     col = "black",
     type="l")
lines(dat$DateTime,dat$Sub_metering_2,
      col = "red")
lines(dat$DateTime,dat$Sub_metering_3,
      col = "blue")
legend("topright",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),
       lwd=2)
dev.off()
