#Setting the working directory and opening useful libraries
setwd("/Users/yahiachaoui/Desktop/datasciencecoursera/UCI HAR Dataset")
library(reshape)
library(dplyr)

#Reading the input data
testSet <- read.table("./test/X_test.txt")
who <- read.table("./test/subject_test.txt")
what <- read.table("./test/y_test.txt")
trainSet <- read.table("./train/X_train.txt")
who2 <- read.table("./train/subject_train.txt")
what2 <- read.table("./train/y_train.txt")
featureNames <- read.table("./features.txt")

#Setting column names as named in the "features.txt" file, selecting only relevant data 
#i.e. means and standard deviations and merging each set into full tables.
colnames(testSet) <- featureNames[,2]
colnames(trainSet) <- featureNames[,2]
indexes <- grep('(mean|std)\\(', featureNames[,2])
testData <- cbind(who, what, testSet[,indexes])
trainData <- cbind(who2, what2, trainSet[,indexes])
colnames(testData)[1:2] <- c("Subject","Activity")
colnames(trainData)[1:2] <- c("Subject","Activity")

#Function that replaces activity indexes by their labels
replace_test <- function(x){
  dic <- read.table("./activity_labels.txt")
  result <- dic[x, 2]
  result
}

#Applying the function to both tables
testData[,2] <- sapply(testData$Activity, replace_test)
trainData[,2] <- sapply(trainData$Activity, replace_test)

#Merging both tables into on data set
data <- merge(trainData, testData, all = TRUE)

#Function that replaces column names into more readable/descriptive names
replace_name <- function(ab){
  
  if(grepl("^t", ab)) name <- "Time domain"
  else if(grepl("^f", ab)) name <- "Frequency domain"
  else name <- ""
  
  if(grepl("Body", ab)) name <- paste(name, "body")
  else if(grepl("Gravity", ab)) name <- paste(name, "gravity")
  
  if(grepl("Acc", ab)) name <- paste(name, "linear acceleration")
  else if(grepl("Gyro", ab)) name <- paste(name, "angular velocity")
  
  if(grepl("Jerk", ab)) name <- paste(name, "jerk")
  
  if(grepl("Mag", ab)) name <- paste(name, "magnitude")
  
  if(grepl("mean", ab)) name <- paste(name, "mean")
  else if(grepl("std", ab)) name <- paste(name, "standard deviation")
  
  if(grepl("X", ab)) name <- paste(name, "along X")
  else if(grepl("Y", ab)) name <- paste(name, "along Y")
  else if(grepl("Z", ab)) name <- paste(name, "along Z")
  
  name
}

#Applying the function to the data set
colnames(data)[3:68] <- sapply(names(data[3:68]), replace_name)

#Cleaning the data environment
rm("featureNames","testSet","trainSet","what","what2","who","who2", "replace_test","indexes", "trainData", "testData", "replace_name")

#Creating a second data set ordered by subject and by activity with mean values to summarize the data
dataMean <- data %>% group_by(Subject, Activity) %>% summarize_at(names(data)[3:68], mean)

#Outputs are hence the "data" and "dataMean" tables.




