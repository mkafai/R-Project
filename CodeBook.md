R-Project
=========

# How does the run_analysis.R script work
1. read the data from the har_data folder for X and y train and test data (X_train, X_test, y_train, y_test). 
Also read the subject data(subject_train, subject_test). Use rbind() to combine the data for train and test data for X and y. 
Use cbind() to combine X, y, and subject data. Read column names into column_names.

2. Using the grep() function, we get the column names that contain mean and std. Two columns are added: subject and activity.
Using subset() we choose a subset of the data from the selected columns and store it in "data".

3. Use read.table to read the activity names into the "activities" variable.
Use match function to perform lookup between activity names in "activities" and the activity column in data.
The result is named activities in the second column of the "data" data frame.

4. Add column names to the data.

5. Using melt and dcast from the "reshape2" library to reshape the data. 
dataMelt has two columns subject and activity as ids and the other columns as values. 
tidy_data is the final result. It contains 180 rows and 688 columns. 
The first two columns are ids. The next 66 columns are the mean values of the measurements. 