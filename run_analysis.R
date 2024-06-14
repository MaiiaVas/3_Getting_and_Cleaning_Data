# Load Packages and get the Data
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

#File unpacked as 'USI HAR Dataset' dir
#Look what files are in this dir

fileIn <- file.path(path, "UCI HAR Dataset")
list.files(fileIn, recursive = TRUE)

##Merges the training and the test sets to create one data set.

# Load activity labels + features + test + train
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("id", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "id")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "id")


# merge datasets
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
subjectDS <- rbind(subject_train, subject_test)
mergedDS <- cbind(subjectDS, Y, X)

##Extracts only the measurements on the mean and standard deviation for each measurement.

colNames <- colnames(mergedDS)

#Create vector for defining mean and standard deviation:
  
meanStd <- (grepl("id" , colNames) | 
                     grepl("subject" , colNames) | 
                     grepl("mean.." , colNames) | 
                     grepl("std.." , colNames) 
)

tidyDataSet <- mergedDS[ , meanStd == TRUE]

##Uses descriptive activity names to name the activities in the data set

tidyDataSet$id <- activities[tidyDataSet$id, 2]

tidyDataSet

##Appropriately labels the data set with descriptive variable names.

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

##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidyDataSet2 <- tidyDataSet %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(tidyDataSet2, "tidyDataSet2.txt", row.name=FALSE)