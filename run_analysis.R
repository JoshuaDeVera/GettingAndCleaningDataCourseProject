folderName <- "UCI HAR Dataset"



if(!file.exists("./dataset.zip"))
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                destfile = "./dataset.zip")

if(!file.exists(folderName))
  unzip("./dataset.zip")

library(dplyr)

activity_labels <- read.table(paste(folderName,"/activity_labels.txt", sep = ""), col.names = c("class","activity"))
features <- read.table(paste(folderName,"/features.txt", sep = ""), col.names = c("n", "function"))
subject_test <- read.table(paste(folderName,"/test/subject_test.txt", sep = ""), col.names = "subject")
x_test <- read.table(paste(folderName,"/test/X_test.txt", sep = ""), col.names = features$function.)
y_test <- read.table(paste(folderName,"/test/y_test.txt", sep = ""), col.names = "class")
subject_train <- read.table(paste(folderName,"/train/subject_train.txt", sep = ""), col.names = "subject")
x_train <- read.table(paste(folderName,"/train/X_train.txt", sep = ""), col.names = features$function.)
y_train <- read.table(paste(folderName,"/train/y_train.txt", sep = ""), col.names = "class")


x_dataset <- rbind(x_test,x_train)
y_dataset <- rbind(y_test,y_train)
subject_dataset <- rbind(subject_test,subject_train)
fullDataset <- cbind(subject_dataset,y_dataset,x_dataset)

cleanDataset <- fullDataset %>%
  select(subject,class,contains("mean"), contains("std"))

cleanDataset$class <- activity_labels[cleanDataset$class,2]


names(cleanDataset)[2] <- "activity"
names(cleanDataset) <- gsub("Acc", "Accelerometer", names(cleanDataset))
names(cleanDataset) <- gsub("Gyro", "Gyroscope", names(cleanDataset))
names(cleanDataset) <- gsub("Mag", "Magnitude", names(cleanDataset))
names(cleanDataset) <- gsub("BodyBody", "Body", names(cleanDataset))
names(cleanDataset) <- gsub("^t", "Time", names(cleanDataset))
names(cleanDataset) <- gsub("^f", "Frequency", names(cleanDataset))
names(cleanDataset) <- gsub("-std()", "STD", names(cleanDataset), ignore.case = T)
names(cleanDataset) <- gsub("-mean()", "Mean", names(cleanDataset), ignore.case = T)
names(cleanDataset) <- gsub("-freq()", "Frequency", names(cleanDataset), ignore.case = T)
names(cleanDataset) <- gsub("tBody", "TimeBody", names(cleanDataset))



Dataset <- group_by(cleanDataset, subject, activity) %>%
  summarise_all(list(mean))
write.table(Dataset, "Dataset.txt")


View(Dataset)
