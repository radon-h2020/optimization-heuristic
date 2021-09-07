# Radon-Decomposition-Interference

| Items | Contents | 
| --------------- | --------------- | 
| Description | The goal of the Radon-Decomposition-interferance is to predicit the interferance between microservices and establish the completion time prediction error. The tool use profiling data for single and two jobs, then predicts the completion times when two or four jobs run simultaneously in the system. Thus, the prediction method works without any need for measurement from executions with four jobs; everything is predicted using only the profiling data and the neural networks model. | 
| Licence | Apache License, Version 2.0: https://opensource.org/licenses/Apache-2.0  |
| Maintainers | Ahmad Alnafessah [@Aalnafessah](https://github.com/Aalnafessah) , Lefteris Anastasiadis [@lefteran](https://github.com/lefteran) , and  Giuliano Casale [@gcasale](https://github.com/gcasale)   |
| Demo | Link: https://www.youtube.com/watch?v=vmnjp_nDqXU&ab_channel=RADONH2020 |


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

The optimization feature first loads a tosca model and by this calculates the number of microservices and the number of hosts. Then a genetic algorithm is used as an optimization method to find an (approximately) optimal allocation of microservices to hosts, having as an objective the minimization of the total interference. The optimization problem can also be solved exactly optimally using a linear programming formulation. Hower, the solution time can be exponentially large with regards to the given input to the problem (i.e. number of hosts and number of microservices), while the genetic alforithm is very efficient. Once the optimization problem is solved, the tosca model is updated with the new relationships between the hosts and the microservices.

In order to solve the above problems the user needs to run the generalised_optimization_feature.m file in matlab.


### To load the tosca model:
The user needs to provide a valid .tosca model and run the command
```
read_tosca_model(filename)
```

### To load the network object:
The user can load the network object with the following command
```
load mynet.mat
```

### To run the genetic algorithm:
The user can run the genetiv algorithm with the following command
```
run_ga(hosts_no, microservices_no, net)
```

After that a binary vector is output e.g. x=[1,0,0,1,0,1,1,0].


### To update the tosca model:
The user can update the tosca model with the new relationships with the following command
```
modify_tosca_model(filename, hosts_no, microservices_no, x)
```


