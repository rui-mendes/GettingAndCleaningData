## Getting and Cleaning Data
## Rui Mendes (ruidamendes@ua.pt)
## Project
## December 2014

# Clean all connections and variables (free memory)
closeAllConnections()
rm(list=ls())

## 1 - Merges the training and the test sets to create one data set
merge_datasets = function() {
  message("==== START == Merge training and test datasets ====")
  
  # Read Train datasets
  x_train <- read.table("data/train/X_train.txt", header = FALSE)
  y_train <- read.table("data/train/y_train.txt", header = FALSE)
  subject_train <- read.table("data/train/subject_train.txt", header = FALSE)
  
  # Read Test datasets
  x_test <- read.table("data/test/X_test.txt", header = FALSE)
  y_test <- read.table("data/test/y_test.txt", header = FALSE)
  subject_test <- read.table("data/test/subject_test.txt", header = FALSE)
  
  # Merge datasets (train vs test) by rows
  x <- rbind(x_train, x_test)
  y <- rbind(y_train, y_test)
  s <- rbind(subject_train, subject_test)
  
  # Clean unnecessary variables (free memory)
  # remove('x_test','y_test','subject_test', 'x_train', 'y_train', 'subject_train')
  
  message("==== END == Merge training and test datasets ====\n")
  
  # Return a list with the 3 elements (x, y and s)
  list(x = x, y = y, s = s)
}

## 2 - Extracts only the measurements on the mean and standard deviation for each measurement
extract_mean_and_std = function(dataset) {
  # Given the dataset (x), the goal is extract only the measurements on the mean
  # and standard deviation for each measurement.
  message("==== START == Extract Mean and Standard Deviation ====")
  
  # Read feature labels from the file
  features <- read.table("data/features.txt")
  
  # Give friendly names to features column
  names(features) <- c('feature_id', 'feature_name')
  
  # Search for matches to argument mean or standard deviation (sd)  within each element of character vector
  index_features <- grep("-mean\\(\\)|-std\\(\\)", features$feature_name) 
  
  # Extract them from the data
  result <- dataset[, index_features] 
  names(result)
  # Replace all matches of the string features 
  names(result) <- gsub("\\(|\\)", "", (features[index_features, 2]))
  names(result)
  message("==== END == Extract Mean and Standard Deviation ====\n")
  return(result)
}

## 3 - Uses descriptive activity names to name the activities in the data set
name_activities = function(dataset) {
  message("==== START == Uses descriptive activity names ====")
  
  # Read activity labels
  activities <- read.table("data/activity_labels.txt")
  
  # Replace activity name by the descriptive name
  dataset[, 1] = activities[dataset[, 1], 2]
    
  message("==== END == Uses descriptive activity names ====\n")
  
  # return dataset
  dataset
}


## 4 - Appropriately labels the data set with descriptive variable names
# Read activity labels
labels_dataset = function(dataset) {
  message("==== START == Label Dataset ====")
  
  names(dataset$y) <- "Activity"
  names(dataset$s) <- "Subject"
  names(dataset$x) <- gsub('Acc',"Acceleration", names(dataset$x))
  names(dataset$x) <- gsub('GyroJerk',"AngularAcceleration", names(dataset$x))
  names(dataset$x) <- gsub('Gyro',"AngularSpeed", names(dataset$x))
  names(dataset$x) <- gsub('Mag',"Magnitude", names(dataset$x))
  names(dataset$x) <- gsub('^t',"TimeDomain.", names(dataset$x))
  names(dataset$x) <- gsub('^f',"FrequencyDomain.", names(dataset$x))
  names(dataset$x) <- gsub('\\-mean',".Mean", names(dataset$x))
  names(dataset$x) <- gsub('\\-std',".StandardDeviation", names(dataset$x))
  names(dataset$x) <- gsub('Freq\\.',"Frequency.", names(dataset$x))
  names(dataset$x) <- gsub('Freq$',"Frequency", names(dataset$x))
  
  message("==== END == Label Dataset ====\n")
  
  # Combines data table by columns
  tidyDataSet <- cbind(dataset$s, dataset$y, dataset$x)
}


## 5 - Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject
avg_tidydata = function(dataset) {
  message("==== START == TidyDataset with Average of each variable ====")
  
  p <- dataset[, 3:dim(dataset)[2]] 
  tidyDataAVGSet <- aggregate(p, list(dataset$Subject, dataset$Activity), mean)
  
  # Rename columns 1 and 2 to Subject and Activity
  names(tidyDataAVGSet)[1] <- "Subject"
  names(tidyDataAVGSet)[2] <- "Activity"
  
  message("==== END == TidyDataset with Average of each variable ====\n")
  
  # return tidyDataAVGSet
  tidyDataAVGSet
}


############################################################################
## Function to run the script ##
#clean_data = function() {
  
  # 1 - Merges the training and the test sets to create one data set.
  dataset <- merge_datasets()
  
  # 2 - Extracts only the measurements on the mean and standard deviation for each measurement
  dataset$x <- extract_mean_and_std(dataset$x)
  
  # 3 - Uses descriptive activity names to name the activities in the data set
  dataset$y <- name_activities(dataset$y)

  # 4 - Appropriately labels the data set with descriptive variable names
  tidyDataSet <- labels_dataset(dataset)

  # 5 - Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject
  tidyDataAVGSet <- avg_tidydata(tidyDataSet)

#}