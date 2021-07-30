# How to use interference NN model:

This part is to preprocess the input dataset of general microservices (not only for Dacapo). The oath and list of the microservices names have to be pass as arguments to the preprocessing functions. 

### To pre-process training data sets of two jobs:
The names of folder must be (This is an example):
```
p08+0+0-noht1
p08+0+0-noht2
p08+0+0-noht3
p08+0+0-noht4
```

Then call function PreprocessInputDatasets_2Jobs and provide the path to datasets."
```
/vol/matlab/R2018a/bin/matlab -nodisplay -r "PreprocessInputDatasets_2Jobs(pwd, {'batik','jython','luindex','lusearch','sunflow','xalan'})"
```


### To pre-process testing data sets of four jobs:
The names of oflder must be (This is an example):
```
p08+0+0+0+0-noht
```

Then call function PreprocessInputDatasets_4Jobs and provid path to datasets."
```
/vol/matlab/R2018a/bin/matlab -nodisplay -r "PreprocessInputDatasets_4Jobs(pwd, {'batik','jython','luindex','lusearch','sunflow','xalan'})" 
```

### Run NN model
Provid path do datasets (training and testing) The neural network will return trained NN model. To run the NN model:
``` 
/vol/matlab/R2018a/bin/matlab -nodisplay -r "Reg4Jobs_RepresentB_V4_ThroughputRADON_V2FunctionPicards(pwd)" 
```
