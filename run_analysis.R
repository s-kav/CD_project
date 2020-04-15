## Here's my course project

library(data.table)

X_train <- data.table::fread("./UCI HAR Dataset/train/X_train.txt", sep = "auto", header = FALSE)
## reading of X_train data set by local path
X_test <- data.table::fread("./UCI HAR Dataset/test/X_test.txt", sep = "auto", header = FALSE)
## reading of X_test data set by local path
X_train <- as.data.frame(X_train)
X_test <- as.data.frame(X_test)
## transformation to data frames
mSET <- rbind.data.frame(X_train, X_test)
## merging the training and the test sets to one data set (Task 1)
ColName <- read.delim("./UCI HAR Dataset/features.txt", header = FALSE, sep = " ")
## reading names of variables from separated external file
mCols <- grep("mean", ColName$V2)
stdCols <- grep("std", ColName$V2)
## searching numbers of columns, which contains the mean and standard deviation
msCols <- sort(c(mCols, stdCols))
## unification obtained numbers to one vector and sort it
mstdFrame <- mSET[, msCols]
## Extracting only the measurements on the mean and standard deviation for each measurement (Task 2)
actLabels <- read.delim("./UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = " ", col.names = c("activ_id", "value"))
## reading kind of activities from separated external file and renaming columns
actVect_tr <- read.delim("./UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = " ", col.names = c("activ_id"))
actVect_tst <- read.delim("./UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = " ", col.names = c("activ_id"))
## reading IDs (codes) of activities kinds from separated external files in accordance to kind of datasets (train & test) and renaming column for the next binding
actVect <- rbind(actVect_tr, actVect_tst)
## merging the training and the test sets of activities kinds to one data set (vector) with one variable
actVect2 <- full_join(actVect, actLabels, by = intersect(names(actVect), names(actLabels)))
## transformation actVect to a vector with two variables (actVect2) in accordance to values of labels AND their order, in this case we didn't change order of records in our data set
mstdFrame <- data.frame(DescActiv = actVect2$value, mstdFrame)
## addition one column (as the first column) to our resulting dataset with a description of activities (Task 3), because point 3 didn't has any restrictions about place of this adding, so I maked this decision independently; at the same time, our new names of columns don't unique, so we cannot to add them as names of columns (it's a restriction)
ColName$V1 <- NULL
## deleting an excess column in ColName
ColName <- as.data.frame(ColName[msCols, ])
## trnsforming this dataset in accordance with used columns (which include only means and standard deviations) by vector msCols
setnames(mstdFrame[, 2:80], names(mstdFrame[, 2:80]), as.character(ColName[1:79,]))
## renaming columns in our selected dataset mstdFrame in accordance with its decription (Task 4)
subVect_tr <- read.delim("./UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = " ", col.names = c("sub_id"))
subVect_tst <- read.delim("./UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = " ", col.names = c("sub_id"))
## reading IDs (codes) of subjects from appropriated external files in accordance to kind of datasets (train & test) and renaming column for the next binding
subVect <- rbind(subVect_tr, subVect_tst)
## merging the training and the test sets of subjects to one data set (vector) with one variable
indTD <- data.frame(subject = subVect$sub_id, mstdFrame)
## making a copy of data set obtained by previous stages
melt_TD <- melt(indTD, id = c("subject","DescActiv"))
## reformatting new data set in accordance with kinds of subjects and activities, it means we're changing the dimensions of data set or to unwrap of data set
indTD <- dcast(melt_TD, subject+DescActiv ~ variable, mean)
## calculating of the average of each variable for each activity and each subject, because we have 6 kinds of activity and 30 subjects, so number of rows is equal 6 * 30 = 180 (Task 5)
write.csv(indTD, "FInalDS.txt", row.names = FALSE)
## creating a file based on existed conditions
