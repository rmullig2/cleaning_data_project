-------------------------------------------
Getting and Cleaning Dat Course Project
Version 1.0
Author: Ray Mulligan
Date: August 23, 2014
------------------------------------------

The purpose of this project is to demonstrate proficiency in the collection and manipulation of existing data sets. The 
project requires the student to merge data sets, extract columns of data, and clean the data to produce a tiny data set.

The included code will load data sets into R and produce a tiny data set. There are five distinct steps taken in this
project. I will list these steps and describe how the objectives were met.


Step One
--------
Merges the training and the test sets to create one data set.

The first several lines of code load each of the data sets into data frames that can be manipulated in R. The read.table()
statement is used for this purpose. The single data set is created by first creating the training data testing data sets.
The test result columns are combined with the subject and activity data sets using a column bind. These two data sets
are then merged into the final data set using a row bind.


Step Two
--------
Extracts only the measurements on the mean and standard deviation for each measurement.

The data set created in step one is used to extract the measurements for mean and standard deviation. The columns in the
first data set are described in the features.txt file which is loaded into a data frame. This data frame is then queried
with the grep command to find the columns containing mean or std. The column numbers are then extracted from features and
placed into the cols data frame. The cols data frame is used to extract the desired columns from the original data frame
and the result is stored in the extract_set data frame. The first two columns are then labeled "Subject" and "Activity"


Step Three
----------
Uses descriptive activity names to name the activities in the data set.

The purpose of this step is to change the numeric codes for activity to the descriptive names given in activity_labels.txt.
First the activity_labels.txt file is read into the activity_labels data frame. The last column in the original data set is
labeled "Activity". The "Activity" column then has its numeric values replaced with the labels.


Step Four
---------
Appropriately labels the data set with descriptive variable names.

This step requires the student to change the column names of the data set created in step one. The first step is to create
a vector of column names from the features data frame. The unlist command is used to change the list to a vector. The
colnames command is then used to rename the columns.


Step Five
---------
Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The final step creates the tiny data set which is submitted for the assignment. This requires the student to be able to
group the data so that there is only one entry for each combination of activity and subject. The extract set created in
step two is used as the base for this computation. The aggreagate command is used to group the data as desired. The
aggregate command produces two extraneous columns that are then removed. The aggregate data is then written to disk
using the write.table command. The row.names = FALSE flag is included as per the instructions.

