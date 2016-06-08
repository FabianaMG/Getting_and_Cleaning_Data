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

1)	fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 2)	download.file(fileurl, destfile = "GDA.zip", method = "curl") 3)	unzip(zipfile="GDA.zip") ## Unzipping file4)	fpath <- file.path("UCI HAR Dataset") 5)	files <- list.files(fpath, recursive = TRUE) 6)	files  7)	ActivityTest <- read.table(file.path(fpath, "test", "Y_test.txt"), header = FALSE)  8)	ActivityTrain <- read.table(file.path(fpath, "train", "Y_train.txt"), header = FALSE)  9)	SubjectTest <- read.table(file.path(fpath, "test", "subject_test.txt"), header = FALSE)  10)	SubjectTrain <- read.table(file.path(fpath, "train", "subject_train.txt"), header = FALSE)  11)	FeaturesTest <- read.table(file.path(fpath, "test", "X_test.txt"), header = FALSE)  12)	FeaturesTrain <- read.table(file.path(fpath, "train", "X_train.txt"), header = FALSE)   13)	MergeSubject <- rbind(SubjectTest, SubjectTrain)  Merge train and test subject files14)	MergeActivity <- rbind(ActivityTest, ActivityTrain)  15)	MergeFeatures <- rbind(FeaturesTest, FeaturesTrain)  16)	names(MergeSubject) <- c("subject")  17)	names(MergeActivity) <- c("activity")  18)	FeatureNames <- read.table(file.path(fpath, "features.txt"), header = FALSE)  19)	names(MergeFeatures) <- FeatureNames$V2  20)	SubjectActivity <- cbind(MergeSubject, MergeActivity)  21)	FullData <- cbind(MergeFeatures, SubjectActivity)  22)	columns <- colnames(FullData)  23)	stdd <- grep("std", columns, value = TRUE)  24)	meand <- grep("mean", columns, value = TRUE)  25)	TidyData <- FullData[,c(stdd, meand, "subject", "activity")]  26)	ActivityLabel <- read.table(file.path(fpath, "activity_labels.txt"), header = FALSE)  27)	names(ActivityLabel) <- c("activity", "activity des")  28)	TidyData <- merge(TidyData, ActivityLabel, by = "activity")  29)	TidyData$activity = NULL 30)	names(TidyData)[names(TidyData)=="activity des"] <- "activity"  31)	names(TidyData) <- gsub("^t", "time", names(TidyData))  32)	names(TidyData) <- gsub("^f", "frequency", names(TidyData))  33)	names(TidyData) <- gsub("Acc", "accelerometer", names(TidyData))  34)	names(TidyData) <- gsub("Gyro", "gyroscope", names(TidyData))  35)	names(TidyData) <- gsub("Mag", "magnitude", names(TidyData))  36)	names(TidyData) <- gsub("BodyBody", "body", names(TidyData))  37)	names(TidyData) <- tolower(names(TidyData))  38)	library(reshape2)  39)	TD <- melt(TidyData, id = c("subject", "activity"))  40)	TDmean <- dcast(TD, subject + activity ~ variable, mean)  41)	write.table(TDmean, "extract.txt", row.names = FALSE, quote = FALSE)  

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
1)	Reading subject information from test directory2)	Reading subject information from train directory3)	Reading features data from test directory4)	Reading features data from train directory5)	Merge train and test subject files6)	Merge train and test activity files7)	Merge train and test features files8)	Change column name to "subject"9)	Change column name to "activity"10)	Read file with features variable names11)	Set feature variable names as columns for feature data12)	Combine Subject and Activity columns13)	Join together Features, Subject and Activity data14)	Extract all columns names from full dataset15)	Look for columns that contain "std" text16)	Look for columns that contain "mean" text17)	Subset columns that contain the text "std" and "mean" plus the columns "activity" and "subject"18)	Read file with activity labels19)	Set columns names in activity labels as "activity" and "activity des"20)	Merge activity label file with activity descriptions and data set21)	Deleting column with activity numbers22)	Renaming column with activity descriptions from "activity des" to "activity"23)	Substitute "t" for "time" in columns names24)	Substitute "f" for "frequency" in columns names25)	Substitute "Acc" for "accelerometer" in columns names26)	Substitute "Gyro" for "gyroscope" in columns names27)	Substitute "Mag" for "magnitude" in columns names28)	Substitute "BodyBody" for "body" in columns names29)	Make all column names be in lower case30)	Call 'reshape2' package31)	Melt dataset in order to make summary by activity and subject32)	Calculate summary with mean of every variable per subject and activity33)	Create file with summary with mean of every variable per subject and activity
