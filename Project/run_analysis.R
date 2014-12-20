## Getting and Cleaning Data
## Rui Mendes (ruidamendes@ua.pt)
## Project
## December 2014

# Clean all connections and variables (free memory)
closeAllConnections()
rm(list=ls())

## 1 - Merges the training and the test sets to create one data set.
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

## Run the script ##
dataset = merge_datasets()
x = dataset[[1]]
y = dataset[[2]]
s = dataset[[3]]
remove(dataset)
