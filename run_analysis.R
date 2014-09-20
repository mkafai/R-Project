library(reshape2)
# Step 1: Merges the training and the test sets to create one data set.
X_train <- read.table('./X_train.txt', header = FALSE)
X_test <- read.table('./X_test.txt', header = FALSE)
y_train = read.table('./y_train.txt', header = FALSE)
y_test = read.table('./y_test.txt', header = FALSE)
subject_train <- read.table('./subject_train.txt', header = FALSE)
subject_test <- read.table('./subject_test.txt', header = FALSE)
X <- rbind(X_train,X_test)
y <- rbind(y_train,y_test)
subject <- rbind(subject_train,subject_test)
data <- cbind(subject,y,X)
column_names <- read.table('./features.txt', header = FALSE, stringsAsFactors=FALSE)
column_names <- c('subject','activity',column_names[,2])

# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
column_subset <- c(1:2,grep('mean()',column_names, fixed=TRUE),grep('std()',column_names, fixed=TRUE))
data <- subset(data, select=column_subset)


# Step 3: Uses descriptive activity names to name the activities in the data set
activities <- read.table('./activity_labels.txt', header = FALSE)
data[,2] <- activities$V2[match(data[,2],activities$V1)] 


# Step 4: Appropriately labels the data set with descriptive variable names. 
colnames(data) <- column_names[column_subset]

# Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
dataMelt <- melt(data,id=c("subject","activity"))
tidy_data <- dcast(dataMelt,subject+activity~variable,mean)
# write.table(tidy_data,file="tidy_data.txt",sep=",",row.names=FALSE)
