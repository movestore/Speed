library('move')
library("ggplot2")
library("sf")
library("units")


rFunction = function(data) {
    if(st_crs(crs(data))$IsGeographic){ ## using pkg units so units are kept for the future
      unt <- "m" ## latlong result is in m/s
    }else{
      unt <- st_crs(crs(data))$units ## get units from projection
    }
    if(is.null(unt)){logger.warn("It seems that the projection does not have defined units, please check the projection in the study summary, and use changeProjection if necesary")} ## THIS WARNING HAS TO BE REWRITTEN!!!!! ITS BASICALLY A PLACEHOLDER. I actually do not know if this can happen, but just in case...
    unts <- as_units(paste0(unt,"/s"))
    data$speed <- set_units(unlist(lapply(speed(data), function(x) c(NA, as.vector(x)))),unts,mode = "standard")
    
    if(length(levels(trackId(data)))==1){
      dataDF <- data.frame(speed=data$speed,indv=namesIndiv(data))
      speedHist <- ggplot(dataDF, aes(as.numeric(speed)))+geom_histogram(bins=100)+facet_grid(~indv)+ xlab(paste0("Speed ",paste0("(",unt,"/s)")))+theme_bw()
      pdf(paste0(Sys.getenv(x = "APP_ARTIFACTS_DIR", "/tmp/"), "speeds_histogram.pdf"))
      print(speedHist)
      dev.off()
    } else {
    pdf(paste0(Sys.getenv(x = "APP_ARTIFACTS_DIR", "/tmp/"), "speeds_histogram.pdf"))
    speedHistAll <- ggplot(data@data, aes(as.numeric(speed)))+geom_histogram(bins=100)+ xlab(paste0("Speed ",paste0("(",unt,"/s)")))+ggtitle("All Individuals") +theme_bw()
    print(speedHistAll)
    lapply(split(data), function(x){
      dataDF <- data.frame(speed=x$speed, indv=namesIndiv(x)) 
      speedHist <- ggplot(dataDF, aes(as.numeric(speed)))+geom_histogram(bins=100)+facet_grid(~indv)+ xlab(paste0("Speed ",paste0("(",unt,"/s)")))+theme_bw()
      print(speedHist)
    })
    dev.off() 
    
  }
  return(data)
}