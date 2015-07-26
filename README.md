# Getting-and-Cleaning-Data

## How to run the script

To run the script, open the file run_analysis.R with R, go to "edit" and then "execute all" - The script does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject

## Process

The following will be process when run.analysis script will be run

1. Checking if "Rgetdata" directory exists - If not it will create it.
2. Installing of the required package - It depends on dplyr package.
3. Defining of "Rgetdata" as working directory.
4. Checking if "getdata-projectfiles-UCI HAR Dataset.zip" file is already downloaded in working directory - If not download it.
5. Loading of the different files from zip file into R objects (feature, activity, subject_test, X_test, Y_test, subject_train, X_train, Y_train).
6. Closing all connections.
7. Merging of the training and the test X_sets to create one data set called X_data.
8. Renaming of column names of X_data with second column of feature data set.
9. Merging of the training and the test Y_sets to create one data set called Y_data.
10. Merging of the training and the test subject_sets to create one data called subject_data.
11. Labelling of the Y_data set with descriptive variable names.
12. Extracting of only measurements on the mean and standard deviation for each measurement.
13. Labelling of the X_data set with descriptive variable names.
14. Using of the descriptive activity names to name the activities in the data set.
15. Appropriately labels the Y_data set with descriptive variable names.
16. Merging of the subject_data, X_data & Y_data to create one data set named Data and remove unused dataset.
17. Creation of a second " DataMean", independent tidy data set with the average of each variable for each activity and each subject.
18. Uploading of the tidy data set created in step 5 of the instructions into a text file called "DataMean.txt".

## Cleaned Data
The second tidy clean dataset is in this repository at: Rgetdata/cleaned.txt.

## Notes
All temp dataset (heavy R object) are removed during script running, only Data and MeanData are kept at the end of the process
