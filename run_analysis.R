setwd("E:/R/course3week4")

##download file 
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="projectdata.zip")

##unzip data
dataZip<-unzip("projectdata.zip")

##load data into R
train.x<-read.table("./UCI HAR Dataset/train/X_train.txt")
train.y<-read.table("./UCI HAR Dataset/train/Y_train.txt")
train