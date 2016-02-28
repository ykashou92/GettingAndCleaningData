## load reshape2 library in order to utilize the melt and dcast functions
library(reshape2)

## Download the dataset if it does not already exist in the working directory and unzip the compressed files
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
f <- file.path(getwd(), "harus_dataset.zip")
download.file(url, f)

if(!file.exists("UCI HAR Dataset")) {
	unzip(f)
}

## Load activity_labels.txt and features.txt

activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

## extract columns which reflect a mean or standard deviation

ftWanted <- grep(".*mean.*|.*std.*", features[,2])
ftWanted.names <- features[ftWanted,2]
ftWanted.names = gsub('-mean', 'Mean', ftWanted.names)
ftWanted.names = gsub('-std', 'Std', ftWanted.names)
ftWanted.names <- gsub('[-()]', '', ftWanted.names)

## Load datasets

train <- read.table("UCI HAR Dataset/train/X_train.txt")[ftWanted]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)
test <- read.table("UCI HAR Dataset/test/X_test.txt")[ftWanted]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

## merge datasets, and turn "activities" and "subjects" into factors
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", ftWanted.names)
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)
allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)
write.table(allData.mean, "tidyData.txt", row.names = FALSE, quote = FALSE)
