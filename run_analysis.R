# Checking if directory exists, if not create it

if(!file.exists("Rgetdata")){
        dir.create("Rgetdata")
}

# Check if required packages are installed, if not install them


if (!require("dplyr")) {
        install.packages("dplyr")
}

 require("dplyr")

# set directory as working directory

setwd("/Rgetdata")

# Checking if zip file exists, if not download & create it

if(!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")){
        Url<-"http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(Url,"getdata-projectfiles-UCI HAR Dataset.zip")
}

# Loading txt files into R objects

feature<-read.table(unz("getdata-projectfiles-UCI HAR Dataset.zip","UCI HAR Dataset/features.txt"))
activity<-read.table(unz("getdata-projectfiles-UCI HAR Dataset.zip","UCI HAR Dataset/activity_labels.txt"))
subject_test<-read.table(unz("getdata-projectfiles-UCI HAR Dataset.zip","UCI HAR Dataset/test/subject_test.txt"))
X_test<-read.table(unz("getdata-projectfiles-UCI HAR Dataset.zip","UCI HAR Dataset/test/X_test.txt"))
Y_test<-read.table(unz("getdata-projectfiles-UCI HAR Dataset.zip","UCI HAR Dataset/test/y_test.txt"))
subject_train<-read.table(unz("getdata-projectfiles-UCI HAR Dataset.zip","UCI HAR Dataset/train/subject_train.txt"))
X_train<-read.table(unz("getdata-projectfiles-UCI HAR Dataset.zip","UCI HAR Dataset/train/X_train.txt"))
Y_train<-read.table(unz("getdata-projectfiles-UCI HAR Dataset.zip","UCI HAR Dataset/train/y_train.txt"))
closeAllConnections()

# Merges the training and the test X_sets to create one data set called X_data

dim(X_train)
dim(X_test)

X_data<-bind_rows(X_train,X_test)
colnames(X_data)<-feature[,2]

dim(X_data)

# Merges the training and the test Y_sets to create one data set called Y_data

dim(Y_train)
dim(Y_test)

Y_data<-bind_rows(Y_train,Y_test)

dim(Y_data)

# Merges the training and the test subject_sets to create one data called subject_data

dim(subject_train)
dim(subject_test)

subject_data<-bind_rows(subject_train,subject_test)

dim(subject_data)

# Appropriately labels the Y_data set with descriptive variable names

colnames(subject_data)<-("Subject")


# Extracts only the measurements on the mean and standard deviation for each measurement.

sel_features<-grep("mean()[^Ff]|std()",feature[,2], value=TRUE)
X_data<-X_data[,sel_features]
dim(X_data)

# Appropriately labels the X_data set with descriptive variable names

colnames(X_data)<-gsub("\\()","",colnames(X_data))
colnames(X_data)<-gsub("-","",colnames(X_data))
colnames(X_data)<-gsub("mean","Mean",colnames(X_data))
colnames(X_data)<-gsub("std","Std",colnames(X_data))
NewFeature<-colnames(X_data)

# Uses descriptive activity names to name the activities in the data set

activity<-activity[,2]
Y_data<-activity[as.numeric(Y_data$V1)]
Y_data<-as.data.frame(Y_data)

# Appropriately labels the Y_data set with descriptive variable names

colnames(Y_data)<-("Activity")


# Merges the subject_data, X_data & Y_data to create one data set named Data and remove unused dataset

dim(subject_data)
dim(X_data)
dim(Y_data)

Data<-bind_cols(Y_data,subject_data,X_data)
Data<-tbl_df(Data)

dim(Data)

rm(subject_test, subject_train, subject_data, X_test, X_train, X_data, Y_test, Y_train, Y_data, activity, feature, sel_features)

# From the data set "Data", creates a second " DataMean", independent tidy data set with the average of each variable for each activity and each subject.

DataMean<- Data %>% group_by(Activity, Subject) %>% summarise_each(funs(mean))
dim(DataMean)

# Please upload the tidy data set created in step 5 of the instructions. Please upload your data set as a txt file created with write.table() using row.name=FALSE (do not cut and paste a dataset directly into the text box, as this may cause errors saving your submission).

write.table(DataMean, file="DataMean.txt", row.name=FALSE)