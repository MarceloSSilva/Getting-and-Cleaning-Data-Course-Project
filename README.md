# Getting-and-Cleaning-Data-Course-Project
#Project Information

A) There are 30 volunteers (subject)

B) Each volunteer performs 6 different activities (activity labels)

C) Sensors are generating data (features)

D) People is divided into two groups: training (70%) and testing (30%)

E) Training group is generating "x" and "y" data sets

F) Testing group is generating "x" and "y" data sets 

G) Merge the training and testing in only one data set

H) Merge the training and the testing subject in one data set

I) merge all files

J) rename columns

H) create a independent tidy data with the average of each volunteer and each activity

Main Algorithm

1) Load library(dplyr) library(plyr)
2) Read common files for test and train
3) Read Test "x" files 
4) Prepare "x" files to merge 
5) include column names

6) keep only the columns with mean() and std() names
7) Found 66 columns

8) The same for Train, "y" files
9) Read all Train, "y" files

10) Prepare y files to merge
11) include column names

12) keep only the columns with mean() and std() names
13) Found 66 columns

14) Merge X_test with X_train files, resulting 10299 rows by 66 columns
15) change all variable names to lower case as best pratice and
16) make syntactically valid names out of character vectors.

17) Prepare y_test and y_train to be added to the final dataset.
As there isn't a difference between training and test group, there is 
not the need to identify each group after the dataset join, so I did not 
include any additional column in the final dataset

18) join y_test and y_train
19) include the label name "activity" as column name
20) include the activity labels in the y_files, using lowercase characters as
best practice, for: walking, walking-upstaires, walking-downstairs, siting, standing and lying

21) Prepare subject_test and subject_train files to be added to the final dataset
22) join subject_test and subject_train and include the label name "subject" as 
column name for the 30 volunteers

23) combine all objects and arrange by activity and subject

24) Generate the average by grouping activity and subject and summarise each group
25) Write a final dataset and generate a text file with this dataset
write.table(dataset5, file = "dataset-average.txt", row.names = FALSE)

to run and View

source("run_analysis.R"`)
run_analysis()
It takes only 34 seconds to run on a Macbook Pro 2.4 GHz Intel Core i5
