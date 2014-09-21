Raw Data
--------
Raw data comes in 2 matching sets, "train" and "test".  Each data set
includes a file of records of motion data gathered for various test
subjects ("X_train/_test.txt"), a file listing the subjects
corresponding to each record of motion data
("subject_train/_test.txt"), and a file listing the activity performed
for each record of motion data ("y_train/_test").  Their motion was
recorded using motion sensors in Samsun smartphones, while they
performed each of 6 types of activities:  WALKING, WALKING_UPSTAIRS,
WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING.  These activities
were recorded in y_train/_test.txt using numeric codes, "1" for
"WALKING" through "6" for "LAYING".  For each of these 561 distinct
statistics were determined, as listed in the feature.txt file and
explained in the features_info.txt file.  A single record of the
motion data file thus has 561 columns, one for each of these distinct
statistics.

To create MyTidyData set:
========================
The tidy data set was created by filtering and then transforming a
table constructed out of the raw data.

Table Constructed From Raw Data
-------------------------------
A new, more complete table was created for each of the train and test
data.  The new tables have the subject_train/_test.txt data added as
column 1, "Subject", as a numeric column.  Before adding the
y_train/_test.txt data as column 2, a new file was created with each
numeric string replaced by its corresponding descriptive string,
"WALKING" for "1", and so on, as described above.  This was then added
as column 2, "Activity".  This resulted in 2 new tables, each with 563
columns.  These tables were then combined by pasting the train table
on top of the test table.  Finally, descriptive column headers were
added in place of the generic variable names "V1", etc., by
transforming the contents of features.txt into a vector of column
names.
     Note that for any given combination of Subject and Activity,
there might be several records matching that combination.  That is,
Subject 1 might have been recorded several times while WALKING,
several times with STANDING, and so on, and likewise any other
Subject.

Filtering The Combined Table
----------------------------
The combined table was filtered to select just those variables
recording mean or standard-devitation data.  These were identified by
whether the column named matched the string "mean" or "std"; if yes to
either of these, it was kept, otherwise it was filtered.  This
resulted in an 81-column table, the first 2 columns being Subject and
Activity, the remaining 79 corresponding to means or standard
deviations of other motion data.

Transforming the Filtered Table Producing MyTidyDataFile
--------------------------------------------------------
Finally, MyTidyDataFile was created by taking the mean of each
remaining variable, for each Subject/Activity pair.  Recalling that
there might be several rows recording Subject 1 while in Activity
WALKING, the tidy data summarizes all such rows by finding their
mean.  Thus, the tidy data has just one record corresponding to
Subject 1 WALKING, one record for Subject 1 WALKING_UPSTAIRS, and so
on, and likewose just one record for each combination of a Subject and
Activity.  Each of these records gives the Subject as column 1, the
Activity as column 2, and has 79 more columns recording various means
or standard-deviations of motion data, as described above.

A Known Bug In MyTidyDataFile
-----------------------------
The column names appear in the file as row one of the table, with the
generic column names of "V1" ... "V81" restored.  I've so far been
unable to eliminate these.  Annoying though this is, the intended
column names are at least present, in the form of row 1, although the
normal R functions for interacting with column names will not react to
the intended column names in the intended way.
