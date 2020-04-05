---
title: "ReadMe"
author: "Marco"
date: "5/4/2020"
output: pdf_document
indent: true
---

## UCI Data Set Assignment

The script run_analysis.R contains two function :  
* the main function  run_analysis executes some transformations on original UCI data set, create the tidy data set and write it into a file  
* the loadDataSet function that load the test and training data set

### loadDataSet
The original UCI data sets are splitted in two groups: training and test. Because it's necessary to perform the same operations on both data sets (upload, label variable, etc), I decided to write a function that accept one parameter , the type of group data, and execute all the needed operations. The function parameter **type** can get "test" and "train" as values according to the UCI data structure.
I decided to name the activities in the data set in this function, insted of following the sequence indicated in the assignment.

### run_analysis
The function has only one parameter, **verbose**, that I used to do some troubleshooting and that can be used to display to the user what's going on int teh function. The default is 0 , no  logging.
This function begin loading the activities name list and the feature name list in order to use them later. The two list are defined globally (<<-) so they can referenced in the loadDataSet function.  
Then the loadDataSet function is called sequentially for the test and the training data, building up two separate data set that are later bind by row.  
Then I extract the features for mean and standard deviation using the grep function obtaining a new data set that now has 88 column: the subject of the experiment, its activity and the 86 features selected.  
I decided to use the melt function and then the dcast function to:  
* create a melt data set in which the first two id are subject and actitvity type and the variable are the following 86 measurements  
* apply the dcast function to calculate the mean for each activity and each subject 

```  
tidyDS=melt(MeasureUCIrestr, id=c("subject","activity")) %>% dcast(activity+subject ~ variable, mean)
```
Finally I write the data set to file using the write.table function. 

### How to read the data set
The data set can be read from file in this way: 
```  
tidyDS<-read.table("./tidyDS")  
```
### Credits
Thanks to David Hoods for some hints.  
<https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/>


