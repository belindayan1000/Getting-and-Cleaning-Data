

trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainSet <- read.table("UCI Har Dataset/train/X_train.txt")
trainLabel <- read.table("UCI Har Dataset/train/y_train.txt")



testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
testSet <- read.table("UCI Har Dataset/test/X_test.txt")
testLabel <- read.table("UCI Har Dataset/test/y_test.txt")

activityLabel <- read.table("UCI Har Dataset/activity_labels.txt")
features <- read.table("UCI Har Dataset/features.txt")

colnames(trainSet) <- features[,2]
colnames(trainLabel) <- "activityID"
colnames(trainSubject) <- "subjectID"

colnames(testSet) <- features[,2]
colnames(testLabel) <- "activityID"
colnames(testSubject) <- "subjectID"


colnames(activityLabel) <- c("activityID", "activityType")

trainMerge<- cbind(trainSet, trainLabel, trainSubject)
testMerge <- cbind(testSet, testLabel, testSubject)
allMerge <- rbind(trainMerge, testMerge)
                 


columnNames <- colnames(allMerge)
selectedValues <- (grepl("activityId" , columnNames) | 
                   grepl("subjectId" , columnNames) | 
                   grepl("mean" , columnNames) | 
                   grepl("std" , columnNames) 
)

selectedDataFrame <- allMerge[ ,selectedValues == TRUE]

colVector <- c()
  for (x in 1:10299) {
    value <- allMerge$activityID[x]
    item <- activityLabel[value,2]
    colVector <- c(item, colVector)

  }
allMerge$activityID <- colVector
print(allMerge$activityID)

names(allMerge) <- gsub("Acc", "Accelerometer", names(allMerge))
names(allMerge) <- gsub("Gyro", "Gyroscope", names(allMerge))
names(allMerge) <- gsub("Mag", "Magnitude", names(allMerge))
names(allMerge)<-gsub("^t", "Time", names(allMerge))
names(allMerge)<-gsub("^f", "Frequency", names(allMerge))
names(allMerge)<-gsub("tBody", "TimeBody", names(allMerge))
names(allMerge) <- gsub("BodyBody", "Body", names(allMerge))

tidySet <- aggregate(. ~subjectID + activityID, allMerge, mean)
tidySet <- tidySet[order(tidySet$subjectID, tidySet$activityID), ]

write.table(tidySet, "tidySet.txt", row.names = FALSE)