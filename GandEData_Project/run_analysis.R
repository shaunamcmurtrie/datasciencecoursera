run_analysis <- function() {
  
  ##SECTION: 1##
  ##Load all files
  #Load in test files 
  xtest <- read.table( "UCI HAR Dataset/test/X_test.txt" ); 
  ytest <- read.table( "UCI HAR Dataset/test/Y_test.txt" ); 
  
  #Bind test files
  xtest <- cbind(xtest, ytest)
  
  #Load in training files
  
  xtrain <- read.table( "UCI HAR Dataset/train/X_train.txt" );  
  ytrain <- read.table( "UCI HAR Dataset/train/Y_train.txt" ); 
  
  #Bind training files
  xtrain <- cbind(xtrain, ytrain)
  
  
  ##SECTION: 2##
  ##Clean and Merge Data Set
  #Merge test and training datasets
  dataSet <- rbind(xtrain, xtest)
  
  #Set Column names
  features <- read.table("UCI HAR Dataset/features.txt")
  f <- as.character(features[,2])
  f <- c(f, "labelId")
  colnames(dataSet) <- f
  
  
  ##SECTION: 3##
  ##Create first data set
  #Load required features for mean and std
  n <- c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,
         162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,
         270,271,345,346,347,348,349,350,424,425,426,427,428,429,503,504,516,517,529,
         530,542,543,562)
  
  #Get mean and std columns and label
  dataSet2 <- dataSet[n]
  
  #Add activity Labels and save
  labels <- read.table("UCI HAR Dataset/activity_labels.txt")
  colnames(labels) <- c("id", "labelName")
  meanAndStdDS <- merge(dataSet2, labels, by.x="labelId", by.y="id", all=TRUE)
  
  
  ##SECTION: 4##
  ##Create second data set
  #Load required features for mean
  n <- c(1,2,3,41,42,43,81,82,83,121,122,123,161,162,163,201,214,227,240,253,266,267,
         268,345,346,347,424,425,426,503,516,529,542,562)
  
  #Get mean vairables
  dataSet2 <- dataSet[n]
  
  #Add activity Labels and save
  meanDS <- merge(dataSet2, labels, by.x="labelId", by.y="id", all=TRUE)
  
  ##SECTION: 5##
  #Write out second DataSet
  write.table(meanDS, file = "meanDataSet.txt", row.names=FALSE);
  
}