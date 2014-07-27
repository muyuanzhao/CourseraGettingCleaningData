Coursera - Getting and Cleaning Data
Course Project
July 27, 2014

Assignment:
You should create one R script called run_analysis.R that does the following. 
  Merges the training and the test sets to create one data set.
  Extracts only the measurements on the mean and standard deviation for each measurement. 
  Uses descriptive activity names to name the activities in the data set
  Appropriately labels the data set with descriptive variable names. 
  Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
 
Output:
ReadMe.md: (This file)
run_analysis.R: The R script that creates the output data file for the assignment.
outputData.csv - The resulting dataset that contains the mean for each Mean and STD column for each Subject and Activity in the original datasets.
outputData.txt - The same data as outputData.csv but in a Text file
CodeBook.txt - The code book for the outputData.csv dataset

R script:
Explanations of the steps in the script. 
1) Read in the test data and apply the column labels.
2) Read in the training data and apply the column labels.
3) Add an 'Activity' column to indicate if a row came from the Test or Training data set.
4) Merge the two datasets.
5) Find the dataset columns that are Mean or STD columns
6) Create a subset of the combined dataset with only the Subject, Label (ActivityType), and the Mean and STD columns.
7) Give the columns more descriptive names.
8) Create a 2nd dataset with the Means of each column, grouped by Subject and Label(Activity).
9) Write this 2nd dataset to a CSV file.
