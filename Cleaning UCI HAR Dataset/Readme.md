##Instructions for the usage of the code
#### This project is submitted for the final submission for the *Getting and the Cleaning Data*


###The script in the submission does the following:

1.Download the file if it is not already available in the folder 

2.Load the activity and features info from the files 

3.Loads both the training and test datasets from the directory, keeping only those columns which reflect a mean or standard deviation 

4.Loads the activity and subject data for each dataset, and merges those columns with the training and testing datasets 

5.Merges the two datasets from step 4 

6.Converts the activity and subject columns into factors from the features table specified 

7.Creates a tidy dataset that consists of the mean value of each variable for each subject and activity pair 
 

 The end result is  saved into the ***tidy.txt*** file in the same working directory.