To merge the training and test sets, the following steps were taken:
  1. Create variables for the subject ID, set of data, and training label for both the test and training sets.
  2. Extract the 2 columns from activity labels and the 2nd column from features and assign them into 
  3. Assign the features variable to the columes of the data set file, assign the subject ID variable to the column of the subject ID file, assign activity ID to the test label file for both the traning and test sets
  4. Column bind the set, subject, and label dataframes together for both the test and training sets and then row bind the completed test and train set together to create the variable "allMerge"

To exract the mean and std of the merged dataframe, the following steps were taken:
  1. Find the column names that had "mean", "std", "subjectID" and "activityID" in them using the method grepl()
 
 To use descriptive names to name each activity in the dataset, the following steps were taken:
  1. Make a for loop to loop through each row of activityID, and then assign it the appropriate activity label

To give variables descriptive names, the following steps were taken:
  1. Use the method gsub() on the column names

To create a second tidy data set with the average of each variable for each activity and subject, the following steps were taken:
  1. Use the aggregate function() to compute the mean for the subset of data
  2. Use write.table() to turn the new data set into a new file 
