

#Create Folder called "wearables"
if(!file.exists("./wearables")){dir.create("./wearables")}

#The data collected from the accelerometers from the Samsung Galaxy S smartphone. 
#Download the file for wearables data
wearableUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(wearableUrl,destfile="./wearables/Dataset.zip",method="curl")

#Unzip the downloaded file. Unzipped files are in UCI HAR Dataset folder

unzip(zipfile="./wearables/Dataset.zip",exdir="./wearables")
setwd("/Users/Satyen/Documents/Rproject/wearables/UCI HAR Dataset/")

# Read the data from the various files. Reference link: https://class.coursera.org/getdata-008/forum/thread?thread_id=24

files<-list.files(recursive="TRUE")

# Read files from test folder

setwd("test")
ytestdata<- read.table("y_test.txt",header= FALSE)
subjecttestdata<-read.table("subject_test.txt",header=FALSE)
Xtestdata<-read.table("X_test.txt",header=FALSE)

# Read files from train folder

setwd("/Users/Satyen/Documents/RProject/wearables/UCI HAR Dataset/train/")
ytraindata<- read.table("y_train.txt",header= FALSE)
subjecttraindata<-read.table("subject_train.txt",header=FALSE)
Xtraindata<-read.table("X_train.txt",header=FALSE)

#Merge the training and test set to create one dataset by appending the rows of train and test set
# Concatenate the data tables by rows

combinedSubjectdata<-rbind(subjecttraindata,subjecttestdata)
combinedactivitydata<- rbind(ytraindata,ytestdata)
combinedfeaturesdata<- rbind(Xtraindata,Xtestdata)

#Assign names to variables for subject column and activity column

names(combinedSubjectdata) <- c("subject")
names(combinedactivitydata) <- c("activity")
setwd("/Users/Satyen/Documents/Rproject/wearables/UCI HAR Dataset/")
featurenames<-read.table("features.txt",head=FALSE)

# Merge Subject and Activity columns to get data frame for all data

names(combinedfeaturesdata) <- featurenames$V2
Combineddata<- cbind(combinedSubjectdata, combinedactivitydata)
totaldata<-cbind(combinedfeaturesdata,Combineddata)


# Select only those columns which have either mean or std dev for each measurement

activitylables<- read.table("activity_labels.txt",header=FALSE)

# Subset the data by selecting featured names containing mean or std dev.

featurenamessubset<- featurenames$V2[grep("mean\\(\\)|std\\(\\)", featurenames$V2)]
selectedNames<-c(as.character(featurenamessubset), "subject", "activity" )

totaldata1<- subset(totaldata,select=selectedNames)

# Appropriately label the data set with descriptive variable names

activitylables<- read.table("activity_labels.txt",header=FALSE)
totaldata1$activity[totaldata1$activity == 1] <- c("WALKING")
totaldata1$activity[totaldata1$activity == 2] <- c("WALKING_UPSTAIRS")
totaldata1$activity[totaldata1$activity == 3] <- c("WALKING_DOWNSTAIRS")
totaldata1$activity[totaldata1$activity == 4] <- c("SITTING")
totaldata1$activity[totaldata1$activity == 5] <- c("STANDING")
totaldata1$activity[totaldata1$activity == 6] <- c("LAYING")


names(totaldata1)<-gsub("^t", "time", names(totaldata1))
names(totaldata1)<-gsub("^f", "frequency", names(totaldata1))
names(totaldata1)<-gsub("Acc", "Accelerometer", names(totaldata1))
names(totaldata1)<-gsub("Gyro", "Gyroscope", names(totaldata1))
names(totaldata1)<-gsub("Mag", "Magnitude", names(totaldata1))
names(totaldata1)<-gsub("BodyBody", "Body", names(totaldata1))
names(totaldata1)<-gsub("()","", names(totaldata1))

# creates a second, independent tidy data set with the average of each variable for each activity and each subject

library(plyr)
totalData2<-aggregate(. ~subject + activity, totaldata1, mean)
totalData2<-totalData2[order(totalData2$subject,totalData2$activity),]

write.table(totalData2, file = "tidydata.txt",row.name=FALSE)
