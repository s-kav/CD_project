# CD_project
Cleaning Data Course Project

There's an answer to the question "How this script works?"

All work of this script is deviding on a few stages in accordance with a sequance of tasks.

Stage 1. Script downloads needed two files (train and test) and converts them to the dataframes. Next it mergs them to one dataframe.  So, it was a solution of the first task.

Stage 2. Script reads names of variables from separated external file (features.txt) to separate dataframe. Next, it searches numbers of columns, which contains the mean and standard deviation and to union obtained numbers to one vector and sort it. Finally, it extracts only the measurements on the mean and standard deviation for each measurement by obtained numbers from the original dataframe. So, it was a solution of the second task.

Stage 3. Script reads additional needed dataframes: a) kinds of activities from separated external file (activity_labels.txt) and renames the columns; b) IDs (codes) of activities kinds from separated external files (y_train.txt & y_test.txt) in accordance to kind of datasets (train & test) and renams the column for the next binding. Next, it mergs the training and the test sets of activities kinds to one data set (vector) with one variable. And it transforms actVect to a vector with two variables (actVect2) in accordance to values of labels AND their order, in this case it didn't change order of records in our dataframe. Finally, it adds one column (as the first column) to our resulting dataset with a description of activities (it's a solution of the third task), because point 3 didn't has any restrictions about place of this adding, at the same time, our new names of columns don't unique, so we cannot to add them as names of columns (it's a restriction).

Stage 4. Script cleans of dataframe: a) deletes an excess column; b) rnsforms current dataset in accordance with used columns (which include only means and standard deviations) by formed appropriate vector; c) renams columns in our selected dataset in accordance with its decription. So, it's a solution of the fourth task.

Stage 5. Script reads additional needed IDs (codes) of subjects from appropriated external files (subject_train.txt & subject_test.txt) in accordance to kind of datasets (train & test) and renams a column for the next binding as dataframes. Next, it mergs the training and the test sets of subjects to one data set (vector) with one variable. Next, it makes a copy of data set obtained by previous stages. Further, it reformats new data set in accordance with kinds of subjects and activities, it means we're changing the dimensions of data set or to unwrap of data set. Finally, script calculats of the average of each variable for each activity and each subject, because we have 6 kinds of activity and 30 subjects, so number of rows is equal 6 * 30 = 180. So, it's a solution of the fifth task.

Finally, script writes a file based on existed conditions. 
