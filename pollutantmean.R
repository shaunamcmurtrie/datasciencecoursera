pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
     
  dFrame <- data.frame()
    
  for( i in id ){
      
    filename <- paste( paste(directory, sprintf("%03d", i) , sep="/"), ".csv", sep="")
    file <- read.csv( filename, header = TRUE );    
      
    dFrame <- rbind(dFrame, file)
      
  }
  
  m <- mean(dFrame[[pollutant]], na.rm=TRUE)

  print(m)
  
}