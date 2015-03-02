# to run
# > source("run_analysis.R"`)
# > run_analysis()
# It takes only 34.183 seconds to run on a Macbook Pro 2.4 GHz Intel Core i5
#
run_analysis <- function() { 

library(dplyr)
library(plyr)

# Read common files for test and train
  features <- read.table("./features.txt")
  activity_labels <- read.table("./activity_labels.txt")
  
# Read Test files
  X_test <- read.table("./X_test.txt")
  y_test <- read.table("./y_test.txt")
  subject_test <- read.table("./subject_test.txt")

# Prepare files to merge 
# include column names  
  colnames(X_test) <- features[,2]
  
# keep only the columns with mean() and std()
  ft <- features[,2]
  med_std <- ft[grep("mean\\(\\)|std\\(\\)", ft)]
  df <- data.frame(med_std)

  X_test <- subset(X_test,, select= c(as.character(df[,1])))

# The same for Train files
# Read all Train files
  X_train <- read.table("./X_train.txt")
  y_train <- read.table("./y_train.txt")
  subject_train <- read.table("./subject_train.txt")

# Prepare files to merge
# include column names  
  colnames(X_train) <- features[,2]

# keep only the columns with mean() and std()
# found 66 columns
  ft <- features[,2]
  med_std <- ft[grep("mean\\(\\)|std\\(\\)", ft)]
  df <- data.frame(med_std)

  X_train <- subset(X_train,, select= c(as.character(df[,1])))

# Merge X_test with X_train, resulting 10299 rows by 66 columns
# X_test =  2947 by 66
# X_train = 7352 by 66

  merged_X <- merge(X_test, X_train, sort = FALSE, all=TRUE)

# change all variable names to lower case as best pratice and
# make syntactically valid names out of character vectors.

  colnames(merged_X) <- tolower(names(merged_X))
  colnames(merged_X) <- make.names(colnames(merged_X), unique = TRUE)

# Prepare y_test and y_train to be added to the final dataset
# as there isn't a difference between training and test group, there is 
# not the need to identify each group after the dataset join
# join  y_test and y_train
# include the label name "activity" as column name

  joined_y <- rbind(y_test, y_train)
  colnames(joined_y) <- "activity"

## include the activity labels in the y_files, using lowercase characters as
# best practice
 
  for ( i in 1:nrow(joined_y)) {
      if (joined_y[i,1] == 1 ) {
        joined_y[i,1] = "walking"
        } else
        if (joined_y[i,1] == 2 ) {
          joined_y[i,1] = "walking-upstairs"
        } else
          if (joined_y[i,1] == 3 ) {
            joined_y[i,1] = "walking-downstairs"
          } else
            if (joined_y[i,1] == 4 ) {
              joined_y[i,1] = "sitting"
            } else
              if (joined_y[i,1] == 5 ) {
                joined_y[i,1] = "standing"
              } else
                if (joined_y[i,1] == 6 ) {
                  joined_y[i,1] = "lying"
                } 
  }

# Prepare subject_test and subject_train to be added to the final dataset
# join  subject_test and subject_train
# and include the label name "subject" as colname

  joined_subject <- rbind(subject_test, subject_train)
  colnames(joined_subject) <- "subject"

# combine all objects and arrange by activity and subject

  dataset <- cbind( joined_y, joined_subject, merged_X)
  dataset <- arrange(dataset, activity, subject)

# question-5 mean by activity and subject
# group_by(), and summarise_each()

  dataset5 <- group_by(dataset, activity, subject)
  dataset5 <- summarise_each(dataset5, funs(mean))

  write.table(dataset5, file = "dataset-average.txt", row.names = FALSE)
}
