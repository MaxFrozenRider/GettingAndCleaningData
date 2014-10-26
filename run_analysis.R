run_analysis<- function(){
  ## Read subjects for both test and train data
  subjectTest<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
  subjectTrain<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
  
  ## Read activity labels code book
  activity<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
  
  ## Read features
  features<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")
  
  ## Read training set
  Xtrain<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
  
  ## Read test set
  Xtest<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
  
  ## Read numeric activity labels for both test and train
  labelsTest<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
  labelsTrain<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
  ## Merge test ans train datasets
  ## Join train and test sets together
  FullData<-rbind(Xtrain,Xtest)
  ## Join subject IDs together
  subjectFull<-rbind(subjectTrain,subjectTest)
  ## Add subject column to the full set
  FullData<-cbind(subjectFull,FullData)
  colnames(FullData)[1] <- "Subject"
  ##Name the activities
  labelsFull<-rbind(labelsTrain,labelsTest)
  ## Add activity column to the full set, changing numbers with names
  for (i in 1:10299) { if (labelsFull[i,1] ==1) labelsFull[i,1] <- "Walking"
                       if (labelsFull[i,1] ==2) labelsFull[i,1] <- "WalkingUp"
                       if (labelsFull[i,1] ==3) labelsFull[i,1] <- "WalkingDown"
                       if (labelsFull[i,1] ==4) labelsFull[i,1] <- "Sitting"
                       if (labelsFull[i,1] ==5) labelsFull[i,1] <- "Standing"
                       if (labelsFull[i,1] ==6) labelsFull[i,1] <- "Laying"
  }
  
  FullData<-cbind(labelsFull,FullData)
  colnames(FullData)[1] <- "Activity"
  columns<-as.character(features[,2])
  columns<-columns[1:548]
  means<-grep("mean",columns, fixed=TRUE)
  stds<-grep("std",columns, fixed=TRUE)
  for (i in 3:561) colnames(FullData)[i] <- make.names(features[i,2], unique=TRUE)
  ## Get corresponding columns from full set
  SmallSetMeans <- subset(FullData, select=means)
  SmallSetStd <- subset(FullData, select=stds)
  Selected <- cbind(FullData$Subject, FullData$Activity, SmallSetMeans, SmallSetStd)
  colnames(Selected)[1] <- "Subject"
  colnames(Selected)[2] <- "Activity"
  Selected
  ## Create tidy set with means of measurements for every subject and activity
  TidySet<- ddply(Selected, c("Subject", "Activity","Activity","Subject"), function (x) apply(x[5:80], 2, mean))
  TidySet
}