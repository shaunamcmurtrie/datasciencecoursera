Programming Assignment
===================
Execution:

No parameters on this function. Just call run_analysis()


Description:
I have split the code into 4 sections for ease of reading and explanation.

Section 1:
Imports both the test and training datasets (x and y files). The x and y files for both test and train are binded together
creating the two data frames xtest and xtrain.

Section 2:
Binds the training and test data frames into one single frame dataSet. The column names are then set using the features.txt file.

Section 3:
Creates a numeric vector with the column positions of all the mean and standar deviation variables. This vector is then used to
extract these columns from the "dataSet" frame and create a new data frame with the subset of columns. 
The label names are imported as a data frame into "labels". A new column "labelName" is then created by using the merge function to 
join the existing data frame, "dataSet", to the activity label dataframe, "labels", using the labelId column. This is assigned to a new data 
frame "meanAndStdDS".

Section 4:
Creates a numeric vector with the column positions of all the mean variables. This vector is then used to
extract these columns from the "dataSet" frame and create a new data frame with the subset of columns. 
A new column "labelName" is then created by using the merge function to join the existing data frame, "dataSet", to the activity 
label dataframe, "labels", using the labelId column. This is assigned to a new data frame "meanDS".

Section 5:
The "meanDS" data frame is written to the file "meanDataSet.txt"