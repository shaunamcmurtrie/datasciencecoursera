complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  dFrame <- data.frame(id= numeric(), nobs=numeric())
  
  for( i in id ){
    
    oId <- sprintf("%03d", i)
    filename <- paste( paste(directory, oId , sep="/"), ".csv", sep="")
    file <- read.csv( filename, header = TRUE );    

    row <- nrow(file[complete.cases(file),])
    
    dFrame <- rbind( dFrame, data.frame(id=oId, nobs=row))
  }
  
  print(dFrame)

}