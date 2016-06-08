fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" ## URL address of file source
download.file(fileurl, destfile = "GDA.zip", method = "curl") ## Download of dataset file
unzip(zipfile="GDA.zip") ## Unzipping file
fpath <- file.path("UCI HAR Dataset") ## Identifying path for dataset local directory
files <- list.files(fpath, recursive = TRUE) ## Command for listing files in dataset directory
files ## List files in dataset
ActivityTest <- read.table(file.path(fpath, "test", "Y_test.txt"), header = FALSE) ## Reading activity information from test directory
ActivityTrain <- read.table(file.path(fpath, "train", "Y_train.txt"), header = FALSE) ## Reading activity information from train directory
SubjectTest <- read.table(file.path(fpath, "test", "subject_test.txt"), header = FALSE) ## Reading subject information from test directory
SubjectTrain <- read.table(file.path(fpath, "train", "subject_train.txt"), header = FALSE) ## Reading subject information from train directory
FeaturesTest <- read.table(file.path(fpath, "test", "X_test.txt"), header = FALSE) ## Reading features data from test directory
FeaturesTrain <- read.table(file.path(fpath, "train", "X_train.txt"), header = FALSE)  ## Reading features data from train directory
MergeSubject <- rbind(SubjectTest, SubjectTrain) ## Merge train and test subject files
MergeActivity <- rbind(ActivityTest, ActivityTrain) ## Merge train and test activity files
MergeFeatures <- rbind(FeaturesTest, FeaturesTrain) ## Merge train and test features files
names(MergeSubject) <- c("subject") ## Change column name to "subject"
names(MergeActivity) <- c("activity") ## Change column name to "activity"
FeatureNames <- read.table(file.path(fpath, "features.txt"), header = FALSE) ## Read file with Features variable names
names(MergeFeatures) <- FeatureNames$V2 ## Set feature variable names as columns for feature data
SubjectActivity <- cbind(MergeSubject, MergeActivity) ## Combine Subject and Activity columns
FullData <- cbind(MergeFeatures, SubjectActivity) ## Join together Features, Subject and Activity data
columns <- colnames(FullData) ## Extract all columns names from full dataset
stdd <- grep("std", columns, value = TRUE) ## Look for columns that contain "std" text
meand <- grep("mean", columns, value = TRUE) ## Look for columns that contain "mean" text
TidyData <- FullData[,c(stdd, meand, "subject", "activity")] ## Subset columns that contain the text "std" and "mean" plus the columns "activity" and "subject"
ActivityLabel <- read.table(file.path(fpath, "activity_labels.txt"), header = FALSE) ## Read file with activity labels
names(ActivityLabel) <- c("activity", "activity des") ## Set columns names in activity labels as "activity" and "activity des"
TidyData <- merge(TidyData, ActivityLabel, by = "activity") ## Merge activity label file with activity descriptions and data set
TidyData$activity = NULL ## Deleting column with activity numbers
names(TidyData)[names(TidyData)=="activity des"] <- "activity" ## Renaming column with activity descriptions from "activity des" to "activity"
names(TidyData) <- gsub("^t", "time", names(TidyData)) ## Substitute "t" for "time" in columns names
names(TidyData) <- gsub("^f", "frequency", names(TidyData)) ## Substitute "f" for "frequency" in columns names
names(TidyData) <- gsub("Acc", "accelerometer", names(TidyData)) ## Substitute "Acc" for "accelerometer" in columns names
names(TidyData) <- gsub("Gyro", "gyroscope", names(TidyData)) ## Substitute "Gyro" for "gyroscope" in columns names
names(TidyData) <- gsub("Mag", "magnitude", names(TidyData)) ## Substitute "Mag" for "magnitude" in columns names
names(TidyData) <- gsub("BodyBody", "body", names(TidyData)) ## Substitute "BodyBody" for "body" in columns names
names(TidyData) <- tolower(names(TidyData)) ## Make all column names be in lower case
library(reshape2) ## Call 'reshape2' package
TD <- melt(TidyData, id = c("subject", "activity")) ## Melt dataset in order to make summary by activity and subject
TDmean <- dcast(TD, subject + activity ~ variable, mean) ## Calculate summary with mean of every variable per subject and activity
write.table(TDmean, "extract.txt", row.names = FALSE, quote = FALSE) ## Create file with summary with mean of every variable per subject and activity