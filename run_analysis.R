
# Coursera - Getting and Cleaning Data
# Course Project
#
# -- 1) Merge the training and the test sets to create one data set. --
# -- 2) Extract only the measurements on the mean and standard deviation for each measurement. 
# -- 3) Use descriptive activity names to name the activities in the data set
# -- 4) Appropriately label the data set with descriptive variable names. 
# -- 5) Create a second, independent tidy data set with the average of each variable 
# for each activity and each subject. 

library(plyr)

# Column Names for recorded data
colNamesDf = read.delim("CourseraData/features.txt", header = FALSE, sep = "")
colNames = c(t(colNamesDf[2]))

# Test Data
d <- read.delim("CourseraData/test/subject_test.txt", header = FALSE, sep = "")
colnames(d)[1] <- "Subject"

e <- read.delim("CourseraData/test/X_test.txt", header = FALSE, sep = "", col.names=colNames)

f <- read.delim("CourseraData/test/Y_test.txt", header = FALSE, sep = "")
colnames(f)[1] <- "Label"

m <- cbind(d, f)
m$Activity <- "Test"
mergedTestData <- cbind(m, e)

# Training Data
x <- read.delim("CourseraData/train/subject_train.txt", header = FALSE, sep = "")
colnames(x)[1] <- "Subject"

y <- read.delim("CourseraData/train/X_train.txt", header = FALSE, sep = "", col.names=colNames)

z <- read.delim("CourseraData/train/Y_train.txt", header = FALSE, sep = "")
colnames(z)[1] <- "Label"

q <- cbind(x, z)
q$Activity <- "Training"
mergedTrainData <- cbind(q, y)

# Merge Test and Train
mergedData <- rbind(mergedTestData, mergedTrainData)

# Find Mean and Standard Deviation column names
j <- colNames[grep("mean", colNames)]
k <- colNames[grep("std", colNames)]
n <- c("Subject","Label", "Activity")
colsToKeep <- c(n, j, k)

# Remove illegal characters from column names
colsToKeep <- gsub("-", ".", colsToKeep)
colsToKeep <- gsub("\\(", ".", colsToKeep)
colsToKeep <- gsub("\\)", ".", colsToKeep)

# Subset measurement data with mean and STD columns
subsetData <- mergedData[colsToKeep]

# Rename header to use more descriptive names
names(subsetData) <- gsub("\\.mean\\.\\.\\.X", "XAxisMean", names(subsetData))
names(subsetData) <- gsub("\\.mean\\.\\.\\.Y", "YAxisMean", names(subsetData))
names(subsetData) <- gsub("\\.mean\\.\\.\\.Z", "ZAxisMean", names(subsetData))
names(subsetData) <- gsub("\\.std\\.\\.\\.X", "XAxisStandardDeviation", names(subsetData))
names(subsetData) <- gsub("\\.std\\.\\.\\.Y", "YAxisStandardDeviation", names(subsetData))
names(subsetData) <- gsub("\\.std\\.\\.\\.Z", "ZAxisStandardDeviation", names(subsetData))
names(subsetData) <- gsub("\\.std\\.\\.", "StandardDeviation", names(subsetData))
names(subsetData) <- gsub("\\.meanFreq\\.\\.\\.X", "XAxisMeanFrequency", names(subsetData))
names(subsetData) <- gsub("\\.meanFreq\\.\\.\\.Y", "YAxisMeanFrequency", names(subsetData))
names(subsetData) <- gsub("\\.meanFreq\\.\\.\\.Z", "ZAxisMeanFrequency", names(subsetData))
names(subsetData) <- gsub("\\.mean\\.\\.", "Mean", names(subsetData))
names(subsetData) <- gsub("tBodyAcc", "BodyAccelerationTime", names(subsetData))
names(subsetData) <- gsub("tGravityAcc", "GravityAccelerationTime", names(subsetData))
names(subsetData) <- gsub("tBodyGyro", "BodyAngularVelocityTime", names(subsetData))
names(subsetData) <- gsub("fBodyAcc", "BodyAccelerationFrequency", names(subsetData))
names(subsetData) <- gsub("fGravityAcc", "GravityAccelerationFrequency", names(subsetData))
names(subsetData) <- gsub("fBodyGyro", "BodyAngularVelocityFrequency", names(subsetData))
names(subsetData) <- gsub("fBodyBody", "BodyFrequencyBody", names(subsetData))
names(subsetData) <- gsub("\\.meanFreq\\.\\.", "MeanFrequency", names(subsetData))

# Create a second, independent tidy data set with the average of each variable 
# for each activity and each subject.

groupBy <- c("Subject", "Label")
columnCount <- ncol(subsetData)
finalSet <- ddply(subsetData, groupBy, function(x) colMeans(x[c(colnames(subsetData)[4:columnCount])]))

write.csv(finalSet, file = "outputData.csv")


