library('move2')
library("ggplot2")
library("sf")
library("units")


rFunction <-  function(data, units=units) {
  
  data$speed <- mt_speed(data, units=units)
  dataPlot <- data
  dataPlot <- dataPlot[!is.na(dataPlot$speed),] # removing NA to ensure that indiv with only one loc ie speed NA get excluded
  
  if(mt_n_tracks(data)==1){
    speedHist <- ggplot(dataPlot, aes(speed))+geom_histogram(bins=100)+facet_grid(~.data[[mt_track_id_column(dataPlot)]])+ xlab("Speed")+theme_bw()
    pdf(appArtifactPath("speed_histogram.pdf"))
    print(speedHist)
    dev.off()
  } else {
    pdf(appArtifactPath("speed_histogram.pdf"))
    speedHistAll <- ggplot(dataPlot, aes(speed))+geom_histogram(bins=100)+ xlab("Speed")+ggtitle("All Individuals")+ theme_bw()
    print(speedHistAll)
    lapply(split(dataPlot, mt_track_id(dataPlot)), function(dataI){
      print(unique(mt_track_id(dataI)))
      speedHist <- ggplot(dataI, aes(speed))+geom_histogram(bins=100)+facet_grid(~.data[[mt_track_id_column(dataI)]])+ xlab("Speed")+theme_bw()
      print(speedHist)
    })
    dev.off() 
  }
  return(data)
}