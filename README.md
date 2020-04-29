# Getting_and_cleaning_data_final_assignement

This repository contains a script that reshapes the data available in the following link : 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Results of the script are : 
- the "data.csv" file that contains the input data as a tidy set
- the 'dataMean.csv" file that contains the same data averaged by subject and activity

The script is named "run_analysis.R"


The script follows the following steps :


1.Setting the working directory and opening useful libraries

2.Reading the input data

3.Setting column names as named in the "features.txt" file, selecting only relevant data 

4.i.e. means and standard deviations and merging each set into full tables.

5.Function that replaces activity indexes by their labels

6.Applying the function to both tables

7.Merging both tables into on data set

8.Function that replaces column names into more readable/descriptive names

9.Applying the function to the data set

10.Cleaning the data environment

11.Creating a second data set ordered by subject and by activity with mean values to summarize the data

