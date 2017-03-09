#Code Book

This code book summarizes the resulting data fields in tidy.txt file in this project.


#The Data

The data that is used in this dataset is from the experiments that have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. The source to this data set can be found at the [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

As a part of this project this data has been worked on, cleaned to get inly the means and the standard deviations of the measured variables. The variables in the dataset are explained below.


# Variables

The variables of the final data set are 


*subject                                 
*activity                                   
*timeBodyAccelerometerMean-X     
*timeBodyAccelerometerMean-Y                
*timeBodyAccelerometerMean-Z                 
*timeBodyAccelerometerSD-X                  
*timeBodyAccelerometerSD-Y                   
*timeBodyAccelerometerSD-Z                  
*timeGravityAccelerometerMean-X              
*timeGravityAccelerometerMean-Y             
*timeGravityAccelerometerMean-Z              
*timeGravityAccelerometerSD-X               
*timeGravityAccelerometerSD-Y                
*timeGravityAccelerometerSD-Z               
*timeBodyAccelerometerJerkMean-X             
*timeBodyAccelerometerJerkMean-Y            
*timeBodyAccelerometerJerkMean-Z             
*timeBodyAccelerometerJerkSD-X              
*timeBodyAccelerometerJerkSD-Y               
*timeBodyAccelerometerJerkSD-Z              
*timeBodyGyroscopeMean-X                     
*timeBodyGyroscopeMean-Y                    
*timeBodyGyroscopeMean-Z                     
*timeBodyGyroscopeSD-X                      
*timeBodyGyroscopeSD-Y                       
*timeBodyGyroscopeSD-Z                      
*timeBodyGyroscopeJerkMean-X                 
*timeBodyGyroscopeJerkMean-Y                
*timeBodyGyroscopeJerkMean-Z                 
*timeBodyGyroscopeJerkSD-X                  
*timeBodyGyroscopeJerkSD-Y                   
*timeBodyGyroscopeJerkSD-Z                  
*timeBodyAccelerometerMagnitudeMean          
*timeBodyAccelerometerMagnitudeSD           
*timeGravityAccelerometerMagnitudeMean       
*timeGravityAccelerometerMagnitudeSD        
*timeBodyAccelerometerJerkMagnitudeMean      
*timeBodyAccelerometerJerkMagnitudeSD       
*timeBodyGyroscopeMagnitudeMean              
*timeBodyGyroscopeMagnitudeSD               
*timeBodyGyroscopeJerkMagnitudeMean          
*timeBodyGyroscopeJerkMagnitudeSD           
*frequencyBodyAccelerometerMean-X            
*frequencyBodyAccelerometerMean-Y           
*frequencyBodyAccelerometerMean-Z            
*frequencyBodyAccelerometerSD-X             
*frequencyBodyAccelerometerSD-Y              
*frequencyBodyAccelerometerSD-Z             
*frequencyBodyAccelerometerJerkMean-X        
*frequencyBodyAccelerometerJerkMean-Y       
*frequencyBodyAccelerometerJerkMean-Z        
*frequencyBodyAccelerometerJerkSD-X         
*frequencyBodyAccelerometerJerkSD-Y          
*frequencyBodyAccelerometerJerkSD-Z         
*frequencyBodyGyroscopeMean-X                
*frequencyBodyGyroscopeMean-Y               
*frequencyBodyGyroscopeMean-Z                
*frequencyBodyGyroscopeSD-X                 
*frequencyBodyAccelerometerMagnitudeMean     
*frequencyBodyAccelerometerMagnitudeSD      
*frequencyBodyAccelerometerJerkMagnitudeMean 
*frequencyBodyAccelerometerJerkMagnitudeSD  
*frequencyBodyGyroscopeMagnitudeMean         
*frequencyBodyGyroscopeMagnitudeSD          
*frequencyBodyGyroscopeJerkMagnitudeMean     
*frequencyBodyGyroscopeJerkMagnitudeSD 

##Variable Explanation

-The variables starting with the  text *time* are the measurements of the activity that are measured across time.
-The variables starting with the text *frequency* are Fourier Transform of the variables in the time series. 
-The variables with the mean are mentioned with the *Mean* at the end and the similarly with the Standard Deviation it is mentiond with *SD*



### Code

Pakcages Used: [reshape2](https://cran.r-project.org/web/packages/reshape2/index.html)

_-___-____-______-________-_____-________-____________-__________--__________-________-_______________

*Code Starts*

library(reshape2)

filename <- “getdata_dataset.zip”

###Download and unzip the dataset:

if (!file.exists(filename)){ fileURL <- “https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ” download.file(fileURL, filename, method=“curl”) }

if (!file.exists(“UCI HAR Dataset”)) { unzip(filename) }

###Load data for the activity labels + features

activityLabels <- read.table(“UCI HAR Dataset/activity_labels.txt”) activityLabels[,2] <- as.character(activityLabels[,2]) activityLabels[,1] <- as.character(activityLabels[,1]) colnames(activityLabels)<- c(“activity”,“activityName”)

features <- read.table(“UCI HAR Dataset/features.txt”) features[,2] <- as.character(features[,2])

###Getting the data of interest index from the features data

dataofintrstidx<- grep(“mean|std”,features[,2])

###features doi is the features daa of interest
featuresdoi <- features[dataofintrstidx,]

###Labeling and substituting for the better expantory names

featureslables<-featuresdoi[,2]

featureslables <- gsub(“-mean”,“Mean”,featureslables)

featureslables <- gsub(“-std”,“SD”,featureslables)

featureslables <- gsub(“t”,“time”,featureslables)

featureslables <- gsub(“f”,“frequency”,featureslables)

featureslables <-gsub(“BodyBody”, “Body”,featureslables)

featureslables <- gsub (“Mag”, “Magnitude”,featureslables)

featureslables <- gsub(“Gyro”, “Gyroscope”,featureslables)

featureslables <- gsub(“Acc”, “Accelerometer”, featureslables)

featureslables <- gsub(“[()]”,“”,featureslables)

###load data + labels

###For training data

trainset <- read.table(“UCI HAR Dataset/train/X_train.txt”)[dataofintrstidx]

trainsetlabel <- read.table(“UCI HAR Dataset/train/Y_train.txt”)

trainsubjects <- read.table(“UCI HAR Dataset/train/subject_train.txt”)

traindata<- cbind(trainsubjects,trainsetlabel,trainset)

colnames(traindata)<-c(“subject”,“activity”,featureslables)

###For Test data

testset <- read.table(“UCI HAR Dataset/test/X_test.txt”)[dataofintrstidx]

testsetlabel <- read.table(“UCI HAR Dataset/test/Y_test.txt”)

testsubjects <- read.table(“UCI HAR Dataset/test/subject_test.txt”)

testdata <- cbind(testsubjects,testsetlabel,testset)

colnames(testdata)<-c(“subject”,“activity”,featureslables)

###Merge data

totaldata<- rbind(traindata,testdata)

###Creating a tidy file and writing it to the file tidy.txt

totaldata$activity <- factor(totaldata$activity, levels = activityLabels[,1], labels = activityLabels[,2])

totaldata$subject <- as.factor(totaldata$subject)

totaldata.melted <- melt(totaldata, id = c(“subject”, “activity”))

totaldata.mean <- dcast(totaldata.melted, subject + activity ~ variable, fun.aggregate = mean, na.rm = TRUE)

write.table(totaldata.mean, “tidy.txt”, row.names = FALSE, quote = FALSE)