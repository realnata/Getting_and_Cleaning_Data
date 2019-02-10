# The Code Book
## Input files for analysis
1. features.txt - list of all features;
2. X_test.txt - test set;
3. y_test.txt - test labels;
4. subject_test.txt - file with the subject who performed the activity for each window sample. Its range is from 1 to 30. 
5. X_train.txt - training set;
6. y_train.txt - training labels;
7. subject_train.txt - file with the subject who performed the activity for each window sample. Its range is from 1 to 30. 

## Read files
Read all files with read.table into the next variables:
  
  ```R
x_test_column <- read.table("features.txt")
x_test <- read.table("X_test.txt", header = FALSE, col.names = x_test_column_1, colClasses = "numeric", fill = TRUE)
x_test_row_1 <- read.table("y_test.txt", col.names = "Labels")
x_test_row_2 <- read.table("subject_test.txt", col.names = "Subject")
x_train <- read.table("X_train.txt", header = FALSE, col.names = x_test_column_1, colClasses = "numeric", fill = TRUE)
x_train_row1 <- read.table("y_train.txt", col.names = "Labels")
x_train_row2 <- read.table("subject_train.txt", col.names = "Subject")

```

## Prepare data
1. Set column names.

```R
x_test_column_sub <- subset(x_test_column, select = V2)
x_test_column_1 <- unlist(x_test_column_sub, use.names = FALSE)
```
2. Set row names.

```R
x_test$Labels <- x_test_row_1$Labels
x_test$Subject <- x_test_row_2$Subject
x_train$Labels <- x_train_row1$Labels
x_train$Subject <- x_train_row2$Subject
```

3. Merge data sets with subjects and labels.

```R
x_test_train <- rbind(x_test, x_train)
```


## Make analysis
1. Extract only the measurements on the mean and standard deviation for each measurement.
```R
grep_x <- select (x_test_train, grep("mean|std", names(x_test_train)), Labels, Subject)
```

2. Use descriptive activity names to name the activities in the data set.

```R
grep_x$Labels[grep_x$Labels == 1]<- 'WAlKING'
grep_x$Labels[grep_x$Labels == 2]<- 'WALKING_UPSTAIRS'
grep_x$Labels[grep_x$Labels == 3]<- 'WALKING_DOWNSTAIRS'
grep_x$Labels[grep_x$Labels == 4]<- 'SITTING'
grep_x$Labels[grep_x$Labels == 5]<- 'STANDING'
grep_x$Labels[grep_x$Labels == 6]<- 'LAYING'
```

3. Create a new data set with average of each variable for each activity and each subject.

```R
aggr_x <- aggregate(x = grep_x, by=list(grep_x$Labels, grep_x$Subject), FUN = "mean")

```
## Output
The output data.frame contains average of each variable for each activity and each subject.
1. result_x_NY.txt