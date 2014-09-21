buildTidyData <- function() {

    ## build the DESCRIPTIVE files
    for(directory in c("train", "test")) {
        activityFileName <- paste0("./data/UCI HAR Dataset/", directory, "/y_", directory, ".txt")
        activityData <- read.table(activityFileName)
        activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
        activityLabelsVector <- activityLabels[,1]

        ## activityNumber <- ## not sure if i need to initialize a literal number variable
        activityDescVector <- character()
        ## build the activityDescVector
        for(activityNumber in activityData[,1]) {
            if(activityNumber == 1) {
                activityDescVector <- c(activityDescVector, "WALKING")
            } else if (activityNumber == 2) {
                activityDescVector <- c(activityDescVector, "WALKING_UPSTAIRS")
            } else if (activityNumber == 3) {
                activityDescVector <- c(activityDescVector, "WALKING_DOWNSTAIRS")
            } else if (activityNumber == 4) {
                activityDescVector <- c(activityDescVector, "SITTING")
            } else if (activityNumber == 5) {
                activityDescVector <- c(activityDescVector, "STANDING")
            } else if (activityNumber == 6) {
                activityDescVector <- c(activityDescVector, "LAYING")
            }
        }

        activityDescDF <- data.frame(activity = activityDescVector)
        activityDescriptiveFileName <- activityFileName <- paste0("./data/UCI HAR Dataset/", directory, "/y_", directory, "_DESCRIPTIVE.txt")
        write.table(activityDescDF, activityDescriptiveFileName, quote = FALSE, row.names = FALSE, col.names = FALSE)
    }

    ## build the merged table 1:  train part
    xTrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
    trainSubject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
    trainActivity <- read.table("./data/UCI HAR Dataset/train/y_train_DESCRIPTIVE.txt")
    trainFull <- cbind.data.frame(trainSubject, trainActivity, xTrain)

    ## build the merged table 2:  test part
    xTest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
    testSubject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
    testActivity <- read.table("./data/UCI HAR Dataset/test/y_test_DESCRIPTIVE.txt")
    testFull <- cbind.data.frame(testSubject, testActivity, xTest)

    ## build the merged table 3:  main part
    mergedTable <- rbind.data.frame(trainFull, testFull)

    ## assign descriptive column names to table
    featuretable <- read.table("./data/UCI HAR Dataset/features.txt")
    featurevector <- as.character(featuretable[,2])
    xFullName <- c("Subject", "Activity", featurevector)
    names(mergedTable) <- xFullName

    ## "subset" out the table that has just the mean ("mean") and standard-deviation ("std") columns
    meanMatches <- grep("mean", names(mergedTable))
    stdMatches <- grep("std", names(mergedTable))
    meanOrStdMatchesRaw <- c(meanMatches, stdMatches)
    meanOrStdMatches <- sort(meanOrStdMatchesRaw)
    labeledMeanOrStdMatches <- c(1, 2, meanOrStdMatches)
    mergedMeanStd <- mergedTable[labeledMeanOrStdMatches]

    ## generate the tidy data set off the merged table
    myTidyDataSet <- ddply(mergedMeanStd, .(Subject, Activity), colwise(mean))

    ## write the tidy data set to a file using write.table
    write.table(myTidyDataSet, "./myTidyDataFile.txt", row.names = FALSE, col.names = FALSE)
}
