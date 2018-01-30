library(reshape2)

filename <- "getdata_dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
        download.file(fileURL, filename, method="curl")
}  

if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}

# Load data for the activity labels + features

activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
activityLabels[,1] <- as.character(activityLabels[,1])
colnames(activityLabels)<- c("activity","activityName")

features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Getting the data of interest index from the features data

dataofintrstidx<- grep("mean\\(\\)|std\\(\\)",features[,2])

featuresdoi <- features[dataofintrstidx,]

# Labeling and substituting for the better expantory names


featureslables<-featuresdoi[,2]

featureslables <- gsub("-mean","Mean",featureslables)

featureslables <- gsub("-std","SD",featureslables)

featureslables <- gsub("^t","time",featureslables)

featureslables <- gsub("^f","frequency",featureslables)

featureslables <-gsub("BodyBody", "Body",featureslables)

featureslables <- gsub ("Mag", "Magnitude",featureslables)

featureslables <- gsub("Gyro", "Gyroscope",featureslables)

featureslables <- gsub("Acc", "Accelerometer", featureslables)

featureslables <- gsub("[()]","",featureslables)

# load data + labels

# For training data

trainset <- read.table("UCI HAR Dataset/train/X_train.txt")[dataofintrstidx]

trainsetlabel <- read.table("UCI HAR Dataset/train/Y_train.txt")

trainsubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")

traindata<- cbind(trainsubjects,trainsetlabel,trainset)

colnames(traindata)<-c("subject","activity",featureslables)

# For Test data

testset <- read.table("UCI HAR Dataset/test/X_test.txt")[dataofintrstidx]

testsetlabel <- read.table("UCI HAR Dataset/test/Y_test.txt")

testsubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

testdata <- cbind(testsubjects,testsetlabel,testset)

colnames(testdata)<-c("subject","activity",featureslables)

# Merge data

totaldata<- rbind(traindata,testdata)

# Creating a tidy file and writing it to the file tidy.txt

totaldata$activity <- factor(totaldata$activity, levels = activityLabels[,1], labels = activityLabels[,2])

totaldata$subject <- as.factor(totaldata$subject)

totaldata.melted <- melt(totaldata, id = c("subject", "activity"))

totaldata.mean <- dcast(totaldata.melted, subject + activity ~ variable, fun.aggregate = mean, na.rm = TRUE)

write.table(totaldata.mean, "tidy.txt", row.names = FALSE, quote = FALSE)