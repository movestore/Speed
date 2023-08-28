library('move2')
library("ggplot2")
library("sf")
library("units")


rFunction <-  function(data, units=units) {

    data$speed <- mt_speed(data, units=units)
    
    if(mt_n_tracks(data)==1){
      speedHist <- ggplot(data[!is.na(data$speed),], aes(speed))+geom_histogram(bins=100)+facet_grid(~.data[[mt_track_id_column(data)]])+ xlab("Speed")+theme_bw()
      pdf(paste0(Sys.getenv(x = "APP_ARTIFACTS_DIR", "/tmp/"), "speed_histogram.pdf"))
      print(speedHist)
      dev.off()
    } else {
      pdf(paste0(Sys.getenv(x = "APP_ARTIFACTS_DIR", "/tmp/"), "speed_histogram.pdf"))
      speedHistAll <- ggplot(data[!is.na(data$speed),], aes(speed))+geom_histogram(bins=100)+ xlab("Speed")+ggtitle("All Individuals")+ theme_bw()
      print(speedHistAll)
      lapply(split(data, mt_track_id(data)), function(dataI){
        speedHist <- ggplot(dataI[!is.na(dataI$speed),], aes(speed))+geom_histogram(bins=100)+facet_grid(~.data[[mt_track_id_column(dataI)]])+ xlab("Speed")+theme_bw()
        print(speedHist)
      })
      dev.off() 
    
  }
  return(data)
}