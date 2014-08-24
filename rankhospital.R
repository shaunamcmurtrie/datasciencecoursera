rankhospital <- function(state, outcome, num = "best") {
  
  values <- vector(mode="character", length=0)
  
  ## Read outcome data 
  filename <- "outcome-of-care-measures.csv"
  ##cls <- c(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia="numeric", 
  ##         Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure = "numeric",
  ##         Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack= "numeric")
  ocm <- read.csv( filename, header = TRUE, stringsAsFactors=FALSE)
  
  ## Check that state and outcome are valid
  states <- unique(ocm[,7])
  outcomes <- c("heart attack", "heart failure", "pneumonia")
  if( !(state %in% states) ){
    stop("invalid state")
  }
  if( !(outcome %in% outcomes) ){
    stop("invalid outcome")
  }
  ## Return hospital name in that state with the given rank
  statesubset <- data.frame()
  subset <- split(ocm, ocm[,7])
  statesubset <- rbind(statesubset, subset[[state]])
 
  n=0
  if(outcome == "heart attack"){
    
    slist <- sort( statesubset[,11], decreasing = FALSE, na.last=NA)
    a <- suppressWarnings(!is.na(sapply(slist, as.numeric)))
    fslist <- slist[a]
    if(num == "best"){
      n=1
    }else if(num == "worst"){
      n=length(fslist)
    }else{
      n=num
    }
    
    finalrow <- subset(statesubset, statesubset[,11]==fslist[n])
    values <- as.character(finalrow[,2])
  }
  else if(outcome == "heart failure"){
    slist <- sort( as.numeric.factor(statesubset[,17]), decreasing = FALSE, na.last=NA)
    
    if(num == "best"){
      n=1
    }else if(num == "worst"){
      n=length(slist)
    }else{
      n=num
    }
    finalrow <- subset(statesubset, statesubset[,17]==slist[n])
    values <- as.character(finalrow[,2])
  
  }
  else if(outcome == "pneumonia"){
    
    slist <- sort( as.numeric.factor(statesubset[,23]), decreasing = FALSE, na.last=NA)
    
    if(num == "best"){
      n=1
    }else if(num == "worst"){
      n=length(slist)
    }else{
      n=num
    }

    finalrow <- subset(statesubset, statesubset[,23]==slist[n])
    values <- as.character(finalrow[,2])
  }
  
  if(length(values) > 1){
    svalues <- sort(values)
    return(svalues[1])
  }else if(length(values) == 0){
    return(NA)
  }
  else{
    return(values)
  }
  ## 30-day death rate
}