# STAT107_Final_Project
A predictive model of USA presidential election by states.

**How to recreate our process**
Firstly, you can simply clone the repository into your local machine. You must then run the 21_DataProcessing.Rmd file in order to load the data into your environment. You can then run 22_DataCleaning.Rmd to clean the data. Afterwards, you can run the FinalReport.Rmd file to observe our vizualizations and our future plan for this project.


**FIlE STRUCTURE**

*Datasets*
This is the directory that includes all of our data sets.

*processed_data*
Our final clean datasets are in this directory.

*00_requirements.R*
This file includes all libraries necessary for the project.

*01_funct_DataCleaning.R*
Here we include all functions necessary for the data cleaning.

*02_func_Plots.r*
Here we can find all functions necessary for data plotting.

*21_DataProcessing.Rmd*
Here we can find our data processing file. In this, we read all the data sets from the dataset directory, read them into our R environment, transform them as necessary, and join them all together into a single dataset.

*22_DataCleaning.Rmd*
In this file, we take the merged dataset from 21_DataProcessing.Rmd and clean it even further. Then we upload the clean data set into processed_data.

*FinalReport.Rmd*
Here, we include an overall description of the project, including vizualizations, future models and data reading and cleaning process. A knitted version of this file is available as *FinalReport.pdf*
