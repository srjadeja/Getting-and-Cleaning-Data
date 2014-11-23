Background

Data Contains Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The RAW dataset includes the following files:
=========================================
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

Codebook 
=========================================
Created a file folder wearables to download the data
Downloaded the file from the url:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
Unzipped the file in wearable folder

-List of files were stored in "files"

-Read the files from the "test", "train" folders
1. Merge the training and the test sets to create one data set.

-Combined the test and train files for subject, activity and features in the following
"combinedSubjectdata", dimensions  [1] 10299     1
"combinedactivitydata" dimensions  [1] 10299     1
"combinedfeaturesdata" dimensions  [1] 10299   561

Merge Subject and Activity columns to get data in "total data" frame for all data
totaldata dimensions  [1] 10299   563

2. Extract only the measurements on the mean and standard deviation for each measurement. 
by Subseting the data by selecting featured names containing mean or std dev. in "totaldata1"
"totaldata1" dimensions [1] 10299    68

3.Use descriptive activity names to name the activities in the data set
activity == 1 <- c("WALKING")
activity == 2 <- c("WALKING_UPSTAIRS")
activity == 3 <- c("WALKING_DOWNSTAIRS")
activity == 4 <- c("SITTING")
activity == 5 <- c("STANDING")
activity == 6 <- c("LAYING")

t= time,  f= frequency, Acc =Accelerometer, Gyro =Gyroscope, Mag=Magnitude, BodyBody= Body,()",""




4.Appropriately labels the data set with descriptive variable names. 
t= time,  f= frequency, Acc =Accelerometer, Gyro =Gyroscope, Mag=Magnitude, BodyBody= Body,()",""

5. Creates a  data set called "totalData2" with the average of each variable for each activity and each subject using aggregate and order commands
"totaldata2"  dimensions[1] 180  68

creates a second, independent tidy data called "tidydata.txt" with average of each variable for each activity and each subject




