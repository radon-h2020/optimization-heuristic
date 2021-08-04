 clc
 clear
 close all

%BestNet=Reg4Jobs_RepresentB_V4_ThroughputRADON_V2FunctionPicards(pwd);
BestNet=Reg4Jobs_RepresentB_V4_ThroughputRADON_V2FunctionPicardsSixColu(pwd);

net=BestNet{1,1};


input_Test = load('input_Test.csv'); 
input_Train= load ('input_Train.csv');
target_Train = load('target_Train.csv');
target_Test = load('target_Test.csv');

x=net(input_Test(1,:)')'