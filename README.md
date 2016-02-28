# Project-Assignment-DS-Course3

run_analysis.R is an R script that does the following to the dataset

Download the dataset if it does not already exist in the working directory and unzip the compressed files
Load activity_labels.txt and features.txt
Load the trianing datasets: X_train.txt, Y_train.txt and subject_train.txt as well as the test datasets: X_test.txt, Y_test.txt, subject_text.txt and extract columns which reflect a mean or standard deviation
Load the activity and subject data for each dataset and merge those columns with the dataset (Install/load "reshape2" library in the process)
Merge the two datasets
Convert the `activity` and `subject` columns into factors
Create a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.

The end result is displayed in the directory in "tidyData.txt"
