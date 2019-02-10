##read feateres.txt
x_test_column <- read.table("features.txt") 

##cut column with nesessary data
x_test_column_sub <- subset(x_test_column, select = V2)

##create vector x_test_column_1
x_test_column_1 <- unlist(x_test_column_sub, use.names = FALSE)

## read table X_test.txt and assign value of vector x_test_column_1 to name of dataset's column
x_test <- read.table("X_test.txt", header = FALSE, col.names = x_test_column_1, colClasses = "numeric", fill = TRUE)

## read Labels from y_test.txt
x_test_row_1 <- read.table("y_test.txt", col.names = "Labels")

## create Labels in dataset x_test and assign a value from x_test_row_1
x_test$Labels <- x_test_row_1$Labels

## read Subject test from subject_test.txt
x_test_row_2 <- read.table("subject_test.txt", col.names = "Subject")

## create column Subject in dataset x_test and assign a value from x_test_row_2
x_test$Subject <- x_test_row_2$Subject

## read table X_train.txt and assign value of vector x_test_column_1 to name of dataset's column
x_train <- read.table("X_train.txt", header = FALSE, col.names = x_test_column_1, colClasses = "numeric", fill = TRUE)

## read Labels from y_train.txt
x_train_row1 <- read.table("y_train.txt", col.names = "Labels")

## read Subject from subject_train.txt
x_train_row2 <- read.table("subject_train.txt", col.names = "Subject")

## create Labels in dataset x_train and assign a value from x_train_row_1
x_train$Labels <- x_train_row1$Labels

## create Subject in dataset x_train and assign a value from x_train_row_2
x_train$Subject <- x_train_row2$Subject

##Merde the datasets x_test and x_train in x_test_train
x_test_train <- rbind(x_test, x_train)

##Extract only the measurements on the mean and standard deviation for each measurement.
grep_x <- select (x_test_train, grep("mean|std", names(x_test_train)), Labels, Subject)

##Use descriptive activity names to name the activities in the data set
grep_x$Labels[grep_x$Labels == 1]<- 'WAlKING'
grep_x$Labels[grep_x$Labels == 2]<- 'WALKING_UPSTAIRS'
grep_x$Labels[grep_x$Labels == 3]<- 'WALKING_DOWNSTAIRS'
grep_x$Labels[grep_x$Labels == 4]<- 'SITTING'
grep_x$Labels[grep_x$Labels == 5]<- 'STANDING'
grep_x$Labels[grep_x$Labels == 6]<- 'LAYING'

##Create a  data set aggr_x with the average of each variable for each activity and each subject.
aggr_x <- aggregate(x = grep_x, by=list(grep_x$Labels, grep_x$Subject), FUN = "mean")
