# Getting and Cleaning Data
 * Rui Mendes (ruidamendes@ua.pt)
 * Project - December 2014
 * Coursera - Data Science specialization

Summary
------------
The script 'run_analysis.R' contains several function to load and transform the data from [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/index.html).

Short description of each function:

 * **get_datasets()** - Check if datasets exist; otherwise proceed to the download 
 * **merge_datasets()** - Merges the training and the test sets to create one data set
 * **extract_mean_and_std()** - Extracts only the measurements on the mean and standard deviation for each measurement
 * **name_activities()** - Uses descriptive activity names to name the activities in the data set
 * **labels_dataset()** - Appropriately labels the data set with descriptive variable names
 * **avg_tidydata()** - Creates a tidy data set with the average of each variable for each activity and each subject
 * **create_file()** - Store dataset in the file (txt, csv)
 * **clean_data()** - Function to run the complete script (all functions)
 
 
 Data Set Analysis
------------
"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data". 

"The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details". 

For each record it's provided:
 
 * Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
 * Triaxial Angular velocity from the gyroscope. 
 * A 561-feature vector with time and frequency domain variables. 
 * Its activity label. 
 * An identifier of the subject who carried out the experiment.

The following files that the dataset contains:

 * 'README.txt'
 * 'features_info.txt': Shows information about the variables used on the feature vector.
 * 'features.txt': List of all features.
 * 'activity_labels.txt': Links the class labels with their activity name.
 * 'train/X_train.txt': Training set.
 * 'train/y_train.txt': Training labels.
 * 'test/X_test.txt': Test set.
 * 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are similar. 

 * 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
 * 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
 * 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
 * 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

*Note*:

Features are normalized and bounded within [-1,1].
Each feature vector is a row on the text file.

 Workflow and Cleaning (Transformations)
------------
1. **Clean cache**
 * Clean all variables and connections of the memory
 
2. **Load Dataset**
 * Checks if the file exists, otherwise proceeds to the download;
 * If the file was downloaded, unzips it and renames the folder to "data";
 
3. **Merge Datasets**
 * Load both test and train data;
 * Merge datasets (train and test) by rows
 * Returns a list with the 3 elements (x, y and s)
  * *Note: *
  Two sets are combined, there are 10,299 instances where each instance contains 561 features (560 measurements and subject identifier). After the merge operation the resulting data, the table contains 562 columns (560 measurements, subject identifier and activity label).
 
4. **Extract mean and Standard Deviation**
 * Reads feature labels from the file
 * Gives friendly names to features column
  
  ```
  names(features) <- c('feature_id', 'feature_name')
  ```
  
  * Searchs for matches to argument mean or standard deviation (sd)  within each element of character vector. It uses grep function
  
  ```
  index_features <- grep("-mean\\(\\)|-std\\(\\)", features$feature_name)
  ```
  
  * Extract the mean and standard deviation column names and data;
  
5. Uses descriptive activity names to name the activities in the data set
 
 * Read activity labels
 * Replace activity name by the descriptive name
 
 ```
 dataset[, 1] = activities[dataset[, 1], 2]
 ```
 
 * Returns the transformed dataset
  
6. Appropriately labels the data set with descriptive variable names
 * Using gsub function, proceeds to several substitutions of column labels to get friendly labels
 
  ```
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
  ```
  * Combines data table by columns
  
  ```
  tidyDataSet <- cbind(dataset$s, dataset$y, dataset$x)
  ```
  
7.  New tidy data set with the average of each variable for each activity and each subject

 * Using aggregate function, the tidyDatasetAVG is created
 
 ```
 tidyDataAVGSet <- aggregate(p, list(dataset$Subject, dataset$Activity), mean)
  ```
  * Rename columns 1 and 2 to Subject and Activity
  
8. Create a file (txt, csv, ...)
 * The user can choose what format wants to create a file with the given dataset
 
 ```
 if (format == 'csv') {
    write.csv(dataset, filename, row.names=FALSE)
  } else {
    write.table(dataset, filename, row.names=FALSE)
  }
  ```