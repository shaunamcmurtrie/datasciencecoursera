best <- function(state, outcome) {
  
  values <- vector(mode="character", length=0)
  
  ## Read outcome data 
  filename <- "outcome-of-care-measures.csv"
  ocm <- read.csv( filename, header = TRUE )
  
  ## Check that state and outcome are valid
  states <- unique(ocm[,7])
  outcomes <- c("heart attack", "heart failure", "pneumonia")
  if( !(state %in% states) ){
    stop("invalid state")
  }
  if( !(outcome %in% outcomes) ){
    stop("invalid outcome")
  }

  ## Return hospital name in that state with lowest 30-day death
  statesubset <- data.frame()
  subset <- split(ocm, ocm[,7])
  statesubset <- rbind(subset[[state]])
  
  as.numeric.factor <- function(x) {suppressWarnings(as.numeric(levels(x))[x])}
  
  if(outcome == "heart attack"){
    minval <- min( as.numeric.factor(statesubset[,13]), na.rm=TRUE)
    finalrow <- subset(statesubset, statesubset[,13]==minval)
    values <- as.character(finalrow[,2])
  }
  else if(outcome == "heart failure"){
    minval <- min(  as.numeric.factor(statesubset[,19]), na.rm=TRUE)
    finalrow <- subset(statesubset, statesubset[,19]==minval)
    values <- as.character(finalrow[,2])
  }
  else if(outcome == "pneumonia"){
    minval <- min( as.numeric.factor( statesubset[,25] ), na.rm=TRUE)
    finalrow <- subset(statesubset, statesubset[,25]==minval)
    values <- as.character(finalrow[,2])
  }
  ## rate
  if(length(values) > 1){
    svalues <- sort(values)
    return(svalues[1])
  }
  else{
    return(values)
  }
  
}
