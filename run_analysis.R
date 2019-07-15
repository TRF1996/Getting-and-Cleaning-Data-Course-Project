setwd("E:/R/course3week4")

##download file 
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="projectdata.zip")

##unzip data
dataZip<-unzip("projectdata.zip")
##_____________________________________

##1load data into R
train.x<-read.table("./UCI HAR Dataset/train/X_train.txt")
train.y<-read.table("./UCI HAR Dataset/train/Y_train.txt")
trainsubject<-read.table("./UCI HAR Dataset/train/subject_train.txt")
test.x<-read.table("./UCI HAR Dataset/test/X_test.txt")
test.y<-read.table("./UCI HAR Dataset/test/Y_test.txt")
testsubject<-read.table("./UCI HAR Dataset/test/subject_test.txt")

##2 merge data
traindata<-cbind(trainsubject,train.y,train.x)
testdata<-cbind(testsubject,test.y,test.x)
df<-rbind(traindata,testdata)


##extract measurements on the mean and standard deviation
##load features
featurename<-read.table("./UCI HAR Dataset/features.txt",stringsAsFactors=FALSE)

##extract mean and standard deviation of each measurements 
featureindex<-grep("mean\\(\\)|std\\(\\)",featurename$V2)
variablelable<-featurename[featureindex,2]
dfex<-df[,c(1,2,featureindex+2)]
colnames(dfex)<-c("Subject","Activity",variablelable)

##Uses descriptive activity names to name the activities in the data set
##load activities name
activitylabel<-read.table("./UCI HAR Dataset/activity_labels.txt" )
##sub activityName for 1-6
dfex$Activity<-factor(dfex$Activity,levels=activitylabel$V1,labels=activitylabel$V2)

##Appropriately labels the data set with descriptive variable names
names(dfex)<-gsub("-mean","Mean",names(dfex))
names(dfex)<-gsub("-std","Std",names(dfex))
names(dfex)<-gsub("\\()","",names(dfex))


## creates a second, independent tidy data set with the average of each variable for each activity and each subject
library("dplyr")
groupdata<-dfex%>%
group_by(Activity,Subject)%>%
  summarise_all(mean)

write.table(groupdata,file="tidydata.txt")