# Preprocessed Argo Data

Preprocessed Argo T/S profile data for the SAMSI Statistical Oceanography Working Group

The script `processDACdata.m` loops through all Argo profiles and selects "good" profiles that occured between January 2007 and December 2016. The data source is the May 8, 2017 snapshop of the Argo GDAC (http://doi.org/10.17882/42182#50059). The aggregated quality-controlled 2007-2016 dataset is in the archive ./Data/Argo_data_aggr.tar.gz. There were 1,417,813 raw profiles in 2007-2016 out of which 998,708 pass the selections.

The scripts `divideDataToMonths.m` and `divideDataToMonthsExtended.m` divide the full dataset into 1 month and 3 month subsets, respectively. These scripts also filter out profiles that are not within the land mask used in the Roemmich-Gilson climatology (available at: http://sio-argo.ucsd.edu/RG_Climatology.html). The monthly datasets are in ./Data/Monthly/ and 3 month datasets in ./Data/Extended/.
