#Readme file for run_analysis.R
==========
###Firstly I read the data from the files.
###Then I have merged test and train datasets with rbind() function.
###Next step, I have added suvject column to full set. 
###Next step, I have named the activities, using the activity file, and added the activity column to my full set.
###Then, I have found the columns with measurements of means and standart deviations, using grep() function.
###Next step, I have added the column names to full dataset, and subseted the columns with measurements of means and standart deviations to another datasets.
###Finally, I have created dataset Selected using cbind() function over the datasets from previos step.
###To create new tidy dataset, I used ddply() function.
