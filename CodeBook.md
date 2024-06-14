---
title: "CodeBook.md"
author: "Maiia Vasileva"
date: "2024-06-14"
output: html_document
---
## Description
This is the project for Coursera 'Data Science Specialisation' course.

## Source Data
[UCI Machine Learning Repository](https://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones)  

## Data Set Information  
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.  

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.  

## Steps of transfoming Data
1 Merging the training and the test sets to create one data set.  
2 Extracting only the measurements on the mean and standard deviation for each measurement.  
3 Using descriptive activity names to name the activities in the data set.  
4 Appropriately labeling the data set with descriptive activity names.  
5 Creating a second, independent tidy data set with the average of each variable for each activity and each subject.  

## The pre-cleaned dataset files:  

"activity_labels.txt"                         
"features.txt"                                
"features_info.txt"                           
"README.txt"                                  
"test/Inertial Signals/body_acc_x_test.txt"   
"test/Inertial Signals/body_acc_y_test.txt"   
"test/Inertial Signals/body_acc_z_test.txt"   
"test/Inertial Signals/body_gyro_x_test.txt"  
"test/Inertial Signals/body_gyro_y_test.txt"  
"test/Inertial Signals/body_gyro_z_test.txt"  
"test/Inertial Signals/total_acc_x_test.txt"  
"test/Inertial Signals/total_acc_y_test.txt"  
"test/Inertial Signals/total_acc_z_test.txt"  
"test/subject_test.txt"                       
"test/X_test.txt"                             
"test/y_test.txt"                             
"train/Inertial Signals/body_acc_x_train.txt"  
"train/Inertial Signals/body_acc_y_train.txt"  
"train/Inertial Signals/body_acc_z_train.txt"  
"train/Inertial Signals/body_gyro_x_train.txt"  
"train/Inertial Signals/body_gyro_y_train.txt"  
"train/Inertial Signals/body_gyro_z_train.txt"  
"train/Inertial Signals/total_acc_x_train.txt"  
"train/Inertial Signals/total_acc_y_train.txt"  
"train/Inertial Signals/total_acc_z_train.txt"  
"train/subject_train.txt"                     
"train/X_train.txt"                           
"train/y_train.txt

