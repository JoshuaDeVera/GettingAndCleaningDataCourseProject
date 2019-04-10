# CodeBook for Getting and Cleaning Data Course Project
### Data Source
Data was collected from accelerometers of Samsung Galaxy S smartphone  
Click [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) to see full data description.  

### Variables  

* Data from the Downloaded File (Raw Data)   
      + activity_labels  
      + features 
      + x_test  
      + y_test  
      + x_train  
      + y_train  
      + subject_train  
      + subject_test

* Merging the training set and test set  
      + x_dataset
      + y_dataset 
      + subject_dataset  
      + fullDataset
      
* Extracting the mean and standard deviation for each measurement  
      + cleanDataset
      
###Transformations Done on the Data  
  + Merge **x_test** and **x_train** using rBind() to create **x_dataset**
  + Merge **y_test** and **y_train** using rBind() to create **y_dataset**
  + Merge **subject_train** and **subject_test** using rBind() to create **subject_dataset**
  + Merge Subset **fullDataset** to have the columns **subject**, **class**, and those that contains **mean** and **std** then store it in a variable named **cleanDataset**
  + Rename the following columns in **cleanDataset** to make the names more descriptive
    + Rename columns with **Acc** in its name to **Accelerometer**
    + Rename columns with **Gyro** in its name to **Gyroscope**
    + Rename columns with **Mag** in its name to **Magnitude**
    + Rename columns with **BodyBody** in its name to **Body**
    + Rename columns that starts with **t** in its name to **Time**
    + Rename columns that starts with **f** in its name to **Frequency**
    + Rename columns with **-std()** in its name to **STD**
    + Rename columns with **-mean()** in its name to **Mean**
    + Rename columns with **-freq()** in its name to **Frequency**
    + Rename columns with **tBody** in its name to **TimeBody**
  + Use **group_by** function to group observations in **cleanDataset** based on **subject** and **activity** then store it in a variable named **Dataset**
  + Use **write.table** function to write **Dataset** to a **Dataset.txt** file
      