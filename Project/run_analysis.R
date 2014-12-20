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
  remove('x_test','y_test','subject_test', 'x_train', 'y_train', 'subject_train')
  
  message("==== END == Merge training and test datasets ====\n")
  
  # Return a list with the 3 elements (x, y and s)
  list(x, y, s)
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
  # Replace all matches of a string features 
  names(result) <- gsub("\\(|\\)", "", (features[index_features, 2]))
  names(result)
  message("==== END == Extract Mean and Standard Deviation ====")
  return(result)
}


## Function to run the script ##
#clean_data = function() {
  
  # 1 - Merges the training and the test sets to create one data set.
  dataset <- merge_datasets()
  x <- dataset[[1]]
  y <- dataset[[2]]
  s <- dataset[[3]]
 # remove(dataset)
  
  # 2 - Extracts only the measurements on the mean and standard deviation for each measurement
  ext <- extract_mean_and_std(x)
  
#}