---
title: "CodeBook.md"
author: "Maiia Vasileva"
date: "2024-06-14"
output: html_document
---
# Description
This is the project for Coursera 'Data Science Specialisation' course.

# Source Data
[UCI Machine Learning Repository](https://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones)  

# Data Set Information  
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.  

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.  

# Steps of transfoming Data
1 Merging the training and the test sets to create one data set.  
2 Extracting only the measurements on the mean and standard deviation for each measurement.  
3 Using descriptive activity names to name the activities in the data set.  
4 Appropriately labeling the data set with descriptive activity names.  
5 Creating a second, independent tidy data set with the average of each variable for each activity and each subject.  

## Load Packages and get the Data
```{r}
packages <- c("data.table", "reshape2", "dplyr")  
sapply(packages, require, character.only=TRUE, quietly=TRUE)  
path <- getwd()  
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"  
f <- "Dataset.zip"  
if (!file.exists(path)) {
  dir.create(path)
}  
download.file(url, file.path(path, f))  

unzip(zipfile = "Dataset.zip")

fileIn <- file.path(path, "UCI HAR Dataset")  
list.files(fileIn, recursive = TRUE)

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))  
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("id", "activity"))  
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")  
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")  
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)  
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)  
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "id")  
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "id")  

X <- rbind(x_train, x_test)  
Y <- rbind(y_train, y_test)  
subjectDS <- rbind(subject_train, subject_test)  
mergedDS <- cbind(subjectDS, Y, X)  

colNames <- colnames(mergedDS)  

meanStd <- (grepl("id" , colNames) | 
                     grepl("subject" , colNames) | 
                     grepl("mean.." , colNames) | 
                     grepl("std.." , colNames) 
)

tidyDataSet <- mergedDS[ , meanStd == TRUE]  

tidyDataSet$id <- activities[tidyDataSet$id, 2]  

tidyDataSet

names(tidyDataSet)[2] = "activity"  
names(tidyDataSet)<-gsub("Acc", "Accelerometer", names(tidyDataSet))  
names(tidyDataSet)<-gsub("Gyro", "Gyroscope", names(tidyDataSet))  
names(tidyDataSet)<-gsub("BodyBody", "Body", names(tidyDataSet))  
names(tidyDataSet)<-gsub("Mag", "Magnitude", names(tidyDataSet))  
names(tidyDataSet)<-gsub("^t", "Time", names(tidyDataSet))  
names(tidyDataSet)<-gsub("^f", "Frequency", names(tidyDataSet))  
names(tidyDataSet)<-gsub("tBody", "TimeBody", names(tidyDataSet))  
names(tidyDataSet)<-gsub("-mean()", "Mean", names(tidyDataSet), ignore.case = TRUE)  
names(tidyDataSet)<-gsub("-std()", "STD", names(tidyDataSet), ignore.case = TRUE)  
names(tidyDataSet)<-gsub("-freq()", "Frequency", names(tidyDataSet), ignore.case = TRUE)  
names(tidyDataSet)<-gsub("angle", "Angle", names(tidyDataSet))  
names(tidyDataSet)<-gsub("gravity", "Gravity", names(tidyDataSet))

tidyDataSet2 <- tidyDataSet %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))  
write.table(tidyDataSet2, "tidyDataSet2.txt", row.name=FALSE)
```