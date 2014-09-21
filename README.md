The script begins by creating 2 new files y_train_DESCRIPTIVE.txt and
y_test_DESCRIPTIVE.txt that are like the respective files, y_train.txt
and y_test.txt, except each feature is replaced by its text meaning.
That is, each occurrence of 1 in y_train.txt is replaced in
y_train_DESCRIPTIVE.txt by "WALKING", and so on, using the
equivalences given in the activity_labels.txt file.  makeDescriptive()
writes these files to the directories /UCI HAR dataset/train/ and
.../test., and finishes.

Next buildTidyData() uses read.table to open as data.frames three
files:

 o X_test.txt
 o subject_test.txt
 o y_test_DESCRIPTIVE.txt

--and then uses cbind.data.frame to combine the three frames into a
single frame, with the contents of subject_test.txt as the first
column, the contents of y_test_DESCRIPTIVE.txt as the second column,
and the contents of X_test.txt as the rest of the table.
buildTidyData() then does the same with the corresponding _train_
files; and then the function uses rbind_data.frame to combine the two
tables into a single table, mergedTable, with the train data on top
and the test data on bottom.

Next buildTidyData() opens the features.txt file, forms a character
vector of its contents, adds "Subject" and "Activity" as the first and
second elements of the vector, and assigns this vector as the column
names of the mergedTable already built.  Note that the Subject column
is a numeric vector, while Activity is the descriptive character
vector whose construction was described previously.

Next buildTidyData() "subsets" out just that part of the table that
relates to means and standard deviations (also keeping the first two
columns, Subject and Activity).  It does this by building a numeric
vector of column numbers whose names match either "mean" or "std", and
using mergedTable[<the column-number vector just described>] to get
just the columns of interest.

Finally, buildTidyData() calls ddply to split the subsetted table on
the pair of columns, (Subject, Activity), and applies mean to the
remaining columns, to build the tidy data set.  Last of all the
function uses write.table to write the resulting table to a file
called "myTidyDataFile.txt".
