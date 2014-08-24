rankall <- function(outcome, num = "best") {
  
  rank <- function(stateDF, col){
    
    stateDF[,col] <- suppressWarnings(sapply(stateDF[,col], as.numeric))
    sortedDF <- stateDF[order(stateDF[,col], stateDF[,2], na.last = NA), ]
    
    return(sortedDF)
  }
  
  getN <- function(iN, sDF){
    n <- 0
    if(iN == "best"){
      n <- 1
    }else if(iN == "worst"){
      n <- nrow(sDF)
    }else{
      n <- iN
    }
    return(n)
  }
  
  ## Read outcome data
  filename <- "outcome-of-care-measures.csv"
  ocm <- read.csv( filename, header = TRUE, stringsAsFactors=FALSE)
  
  ## Check that state and outcome are valid
  states <- sort(unique(ocm[,7]))
  outcomes <- c("heart attack", "heart failure", "pneumonia")
  if( !(outcome %in% outcomes) ){
    stop("invalid outcome")
  }
  
  #Create return data frame
  dFrame <- data.frame( hospital= character(), state=character() )
  
  ## For each state, find the hospital of the given rank
  for( s in states ){
    
    
    #Get current state dataframe
    statesubset <- data.frame()
    subset <- split(ocm, ocm[,7])
    statesubset <- rbind(statesubset, subset[[s]])
    
    if(outcome == "heart attack"){

      rankedDF<- rank(statesubset, 11)
      n <- getN(num, rankedDF)

      dFrame <- rbind( dFrame, data.frame(hospital=rankedDF[n,2], state=s))
         
    }else if(outcome == "heart failure"){
      
      rankedDF<- rank(statesubset, 17)
      n <- getN(num, rankedDF)
      
      dFrame <- rbind( dFrame, data.frame(hospital=rankedDF[n,2], state=s))
    }else if(outcome == "pneumonia"){
      
      rankedDF<- rank(statesubset, 23)
      n <- getN(num, rankedDF)
      
      dFrame <- rbind( dFrame, data.frame(hospital=rankedDF[n,2], state=s))
      
    }
    
  }
  
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  return(dFrame)
}
