Code Book
Assignment: Getting and Cleaning Data Course Project

Table of Contents

1. Assignment Goals
2. Study Design
3. Code Book
4. Instruction List

_____

1. Assignment Goals

Create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

_____

2. Study Design


Human Activity Recognition Using Smartphones Dataset
Version 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit‡ degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws


The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

_____

3. Code Book

File and directory mentioned in script:

GDA.zip 	: Getting Data Assignment dataset, downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
UCI HAR Dataset : Directory unzipped from original dataset (GDA.zip)

Variables:

Note: The files contained in the folder “Inertial Signals” will not be considered in this analysis.

There are three main variables: Features, Subject, and Activity.

Within the file “features.txt”, one can find all (538) feature variable names. 

In the files “subject_train.txt” and “subject_test.txt”, each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

The files “X_train.txt” and “X_test.txt” contain feature data measurements.

And the files “Y_train.txt” and “Y_test.txt” contain activity data. The activity codes are as following:

1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

_____

4. Instruction List

The following modifications were made in order to fulfill the project goals (each code line has a corresponding description below):

1)	fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 

Code description:

1) URL address to file source
2) Download of dataset file
3) Unzipping file
4) Identifying path for dataset local directory
5) Command for listing files in dataset directory
6) List files in dataset
7) Reading activity information from test directory
8) Reading activity information from train directory
9) Reading subject information from test directory
1)	Reading subject information from test directory