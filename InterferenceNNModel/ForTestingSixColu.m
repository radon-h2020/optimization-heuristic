clc
clear
close all

%BestNet=Reg4Jobs_RepresentB_V4_ThroughputRADON_V2FunctionPicards(pwd);
BestNet=FitInterferenceNeuralNetwork(pwd);
input_Test = load('input_Test.csv');

net=BestNet{1,1};


x=net(input_Test(1,:)')'