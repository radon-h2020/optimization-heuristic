# How to use interference NN model:

### To pre-process training data sets of two jobs:
The names of folder must be (This is an example):
```
DataSetsS1+0+0-noht1
DataSetsS1+0+0-noht2
DataSetsS1+0+0-noht3
DataSetsS1+0+0-noht4
```

Then call function PreprocessInputDatasets_2Jobs and provide the path to datasets."
```
matlab -nodisplay -r "PreprocessInputDatasets_2Jobs(pwd)"
```


### To pre-process testing data sets of four jobs:
The names of oflder must be (This is an example):
```
DataSetsS1+0+0+0+0-noht
```

Then call function PreprocessInputDatasets_4Jobs and provid path to datasets."
```
matlab -nodisplay -r "PreprocessInputDatasets_4Jobs(pwd)" 
```

### Run NN model
Provid path do datasets (training and testing) The neural network will return trained NN model. To run the NN model:
``` 
matlab -nodisplay -r "FitInterferenceNeuralNetwork(pwd)" 
```


### To Test the NN function:
The following is a simple application of using the NN model:
```
 clc
 clear
 close all

% Calling the NN model
BestNet=FitInterferenceNeuralNetwork(pwd)

% Loading the testing data
input_Test = load('input_Test.csv'); 
input_Train= load ('input_Train.csv');

%Predicting the Thput

net=BestNet{1,1}
x=net(input_Test')'
```


# Optimization Feature:


The set_cover.m file contains the implementations for the optimization problem. The user can decide by the function run_algorithm() to either run the exact algorithm which solves the integer linear programming formulation of the set cover problem optimally, or run the heuristic that runs the greedy algorithm to solve the problem approximately but in a more efficient way. 

The interference is computed by the compute_interference_table() method that translates the throughput of a selection.

The method modify_tosca_model() adds the relationships to the corresponding graph of the tosca model.
