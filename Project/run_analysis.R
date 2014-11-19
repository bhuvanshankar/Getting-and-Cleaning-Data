library(plyr)
setwd("~/Documents/git/CleaningGettingData/Project")

# Download the dataset 
download_data <- function() {
file <- download.file(url="http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "dataset.zip")
unzipped <-unzip("dataset.zip")
}

# Change working directory
setwd("~/Documents/git/CleaningGettingData/Project/UCI HAR Dataset")

# Importing Tables (Train)
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

# Importing Tables (Test)
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# Create X, Y, Subject Dataset
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)

# Get Mean and StDev for each measurement
features <- read.table("features.txt")
m_stdev_features <- grep("-(mean|std)\\(\\)", features[,2])

# Subseting required columns and correcting the names
x_data <- x_data[, m_stdev_features]
names(x_data) <- features[m_stdev_features, 2]

# Apply descriptive names
activity <- read.table("activity_labels.txt")
y_data[,1] <- activity[y_data[,1],2]
names(y_data) <-"Activity"
names(subject) <- "Subject"

# Combining X, Y, Subject Tables
all_data <- cbind(x_data,y_data,subject)

# Create tidy dataset
averages_data <- ddply(all_data, .(Subject, Activity), function(x) colMeans(x[, 1:66]))
write.table(averages_data, "averages_data.txt", row.names=FALSE)

