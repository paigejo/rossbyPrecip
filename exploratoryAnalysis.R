# Will Klieber's USHCN precip dataset:

#set up
setwd("/Users/paigejo/Desktop/rossby")
library(fields)

# read in data, remove dummy column when necessary
prcp = read.csv("PRCP.csv", header = TRUE)
prcp = prcp[,-1]
lonlat = read.csv("lon-lat.csv", header=TRUE)
day = read.csv("days.csv", header = TRUE)
day = day[,2]
elev = read.csv("elev.csv", header=TRUE)
ns = read.csv("ns.csv", header=TRUE)
n = ns[2]
stn = read.csv("stn-name.csv", header=TRUE)
stn = stn[,2]
yr = read.csv("years.csv", header=TRUE)
yr = yr[,2]
uniqueYrs = unique(yr)

# plot spatial averages of precip
lon = lonlat[,2]
lat = lonlat[,3]
means = apply(prcp, 2, mean, na.rm=TRUE)
quilt.plot(cbind(lon, lat), means, main="Mean Precipitation")
US(add=TRUE)

# plot temporal averages of precip
# aggByYr = function(vec) {
#   tapply(vec, as.factor(yr), FUN=mean, na.rm=TRUE)
# }
# test = apply(prcp, 2, aggByYr)
spatAvgs = apply(prcp, 1, mean, na.rm=TRUE)
prcpOverTime = tapply(spatAvgs, as.factor(yr), FUN=mean, na.rm=TRUE)
plot(uniqueYrs, prcpOverTime, type="l", main="Average Precipitation Through Time", 
     ylab="Precipitation", xlab="Year")

# plot amount of data through time
ns = apply(is.finite(as.matrix(prcp)), 1, sum)
plot(yr, ns, type="l", main="Stations Through Time", xlab="Year", ylab="Number of Stations")

# plot number of stations through space for each decade
