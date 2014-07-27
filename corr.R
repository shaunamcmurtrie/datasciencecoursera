corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  vec <- vector('numeric')
  id <- 1:332

  
  for( i in id ){
    
    oId <- sprintf("%03d", i)
    filename <- paste( paste(directory, oId , sep="/"), ".csv", sep="")
    file <- read.csv( filename, header = TRUE );    
    
    file <- (file[complete.cases(file),])
    row <- nrow(file)
    
  if(row > threshold){

      vec <- c(vec, cor(x = file[["sulfate"]], y=file[["nitrate"]], use="everything"))
    }

  }
  
  return(vec)

  ## 'thrveshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
}