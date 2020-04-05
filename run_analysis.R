loadDataSet <- function(type) {
        ## This function load and transform the data set of type "type"
        # build up the file names
        subjectFile=paste("./UCI HAR Dataset",type,sub("type",type,"subject_type.txt"),sep="/")
        actFile=paste("./UCI HAR Dataset",type, sub("type",type,"y_type.txt"),sep="/")
        featFile=paste("./UCI HAR Dataset",type,sub("type",type,"X_type.txt") ,sep="/")
        
        ## load the data sets
        featMeasure=read.table(featFile,col.names = featureList$V2)
        subjMeasure=read.table(subjectFile, col.names = c("subject"))
        actMeasure=read.table(actFile, col.names = c("activity"))
        
        ## label the activities        
        actMeasure$activity=activityList[actMeasure$activity,2]
        
        ## Bind subject, activities and measurements
        Measure=cbind(subjMeasure,actMeasure,featMeasure)
        Measure
}


run_analysis <- function() {
        ## load the activity label list and the feature label list
        featureList<<-read.table("./UCI HAR Dataset/features.txt")
        activityList<<-read.table("./UCI HAR Dataset/activity_labels.txt")
        ## make the activity label more tidy
        activityList$V2<<-sub("stairs","",sub("_"," ",tolower(activityList$V2)))
        
        # load the test dataset
        MeasureTest=loadDataSet("test")
        print("Test data set loaded")
        # load the training dataset
        MeasureTrain=loadDataSet("train")
        print("Training data set loaded")
        #bind the two datset
        MeasureUCI=rbind(MeasureTrain,MeasureTest)
        print("Data set merged with dimensions:")
        print(dim(MeasureUCI))
        
        # extract feature for mean and standade deviation
        MeasureUCIrestr=MeasureUCI[,grep("subject|activity|[Mm]ean|std",names(MeasureUCI), value=T)]

        # labels the data set with descriptive variable names
        names(MeasureUCIrestr)[3:88]=paste("avg",names(MeasureUCIrestr)[3:88],sep=".")
        
        print("Creating tidy data set")
        tidyDS=melt(MeasureUCIrestr, id=c("subject","activity")) %>% dcast(subject+activity ~ variable, mean)
        # write tidy data set
        write.table(tidyDS, file="./tidyDS")
}