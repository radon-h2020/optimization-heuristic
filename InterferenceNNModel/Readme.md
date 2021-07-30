### How to use interference NN model:

### To pre-process training data sets of two jobs:
The names of oflder must be (This is an example):
p08+0+0-noht1
p08+0+0-noht2
p08+0+0-noht3
p08+0+0-noht4

Then call function PreprocessInputDatasets_2Jobs and provid path to datasets."
```/vol/matlab/R2018a/bin/matlab -nodisplay -r "PreprocessInputDatasets_2Jobs(pwd)"```


### To pre-process testing data sets of for jobs:
The names of oflder must be (This is an example):
p08+0+0+0+0-noht

Then call function PreprocessInputDatasets_4Jobs and provid path to datasets."
```/vol/matlab/R2018a/bin/matlab -nodisplay -r "PreprocessInputDatasets_4Jobs(pwd)" ```

### Run NN model
Provid path do datasets (training and testing) The neural network will return trained NN model. To run the NN model:
``` /vol/matlab/R2018a/bin/matlab -nodisplay -r "Reg4Jobs_RepresentB_V4_ThroughputRADON_V2FunctionPicards(pwd)" ```
