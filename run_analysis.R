rm(list=ls(all=T))


#setwd("C:/Users/jholland/Google Drive/Courserea/DataCleaning/Project/")

unzip("getdata-projectfiles-UCI HAR Dataset.zip")

features <- read.table("./UCI HAR Dataset/features.txt", sep=" ")

subject <- scan("./UCI HAR Dataset/test/subject_test.txt")
activity <- scan("./UCI HAR Dataset/test/y_test.txt")

ids_test <- cbind(subject, activity)

#------------------------------------------------------------------#

test <- read.table("./UCI HAR Dataset//test/x_test.txt", header=F, col.names = features$V2)

test <- cbind(ids_test, test)

#-----------------------------------------------------------------#

subject <- scan("./UCI HAR Dataset/train/subject_train.txt")
activity <- scan("./UCI HAR Dataset/train/y_train.txt")

ids_train <- cbind(subject, activity)

#------------------------------------------------------------------#

train <- read.table("./UCI HAR Dataset//train/x_train.txt", header=F, col.names = features$V2)

train <- cbind(ids_train, train)


#-----------------------------------------------------------------#

mydata <- rbind(test, train)

keeps <- grepl("-[Mm]ean|-std", features$V2)


mydata <- mydata[,c(T,T,keeps)]


#-------------------------------------------------------------------#

activities <- read.table("./UCI HAR Dataset/activity_labels.txt", sep=" ", col.names=c("activity", "activity_description"))

mydata <- merge(mydata,activities, by="activity", all.x=T)
mydata <- mydata[,c(2:1,ncol(mydata),3:(ncol(mydata)-1))]


mydata.agg <- aggregate(.~subject+activity+activity_description, data=mydata, FUN=mean)


