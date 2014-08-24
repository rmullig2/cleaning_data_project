# run_analysis.R
# Course Project for Getting and Cleaning Data
# Created by Ray Mulligan

# Step One
# Merges the training and the test sets to create one data set
# Load the text files into tables
# Use rbind() and cbind() commands to create the data set
# Data set created is named final_set
X_train <- read.table("train/X_train.txt")
X_test <- read.table("test/X_test.txt")
subject_train <- read.table("train/subject_train.txt")
subject_test <- read.table("test/subject_test.txt")
y_train <- read.table("train/y_train.txt")
y_test <- read.table("test/y_test.txt")
train_bind <- cbind(X_train, subject_train, y_train)
test_bind <- cbind(X_test, subject_test, y_test)
final_set <- rbind(train_bind, test_bind)

# Step Two
# Extracts only the measurements on the mean and standard
# deviation for each measurement
# By examining features.txt the columns needed 
# to be extracted can be determined
# Extracted data is placed into extract set
features <- read.table("features.txt", stringsAsFactors=FALSE)
feat_cols <- features[union(grep("mean", features$V2), grep("std", features$V2)),]
cols <- sort(feat_cols[,1])
extract_set <- final_set[,cols]
extract_set <- cbind(final_set$Subject, final_set$Activity, extract_set)
colnames(extract_set)[1:2] <- c("Subject", "Activity")

# Step Three
# Uses descriptive activity names 
# to name the activities in the data set
# Start with the data set created in step one
# The activities are in the last column
# They are labeled as specified in activity_labels.txt
# 1 WALKING
# 2 WALKING_UPSTAIRS
# 3 WALKING_DOWNSTAIRS
# 4 SITTING
# 5 STANDING
# 6 LAYING
activity_labels <- read.table("activity_labels.txt", stringsAsFactors=FALSE)
colnames(final_set)[563] <- "Activity"
final_set$Activity[final_set$Activity == 1] <- "WALKING"
final_set$Activity[final_set$Activity == 2] <- "WALKING_UPSTAIRS"
final_set$Activity[final_set$Activity == 3] <- "WALKING_DOWNSTAIRS"
final_set$Activity[final_set$Activity == 4] <- "SITTING"
final_set$Activity[final_set$Activity == 5] <- "STANDING"
final_set$Activity[final_set$Activity == 6] <- "LAYING"

# Step Four
# Appropriately labels the data set with descriptive
# variable names
# Use features.txt for the measurements
# Use "subject" for the subject column
cols <- unlist(features[2], use.names = FALSE)
colnames(final_set) <- c(cols, "Subject", "Activity")

# Step Five
# Creates a second, independent tidy data set with the
# average of each variable for each activity and
# each subject
aggdata <-aggregate(extract_set, list(extract_set$Subject,extract_set$Activity),mean)
col_select <- c(1,2,5:83)
aggdata <- aggdata[,col_select]
write.table(aggdata,file = "tiny_data.txt", row.names = FALSE)
