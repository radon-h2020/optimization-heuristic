 function []=test2(InputPath11, Output_Path11)
% Solve an Input-Output Fitting problem with a Neural Network
% 
% Created 15-Sep-2020 15:43:59
%
% This script assumes these variables are defined:
% Ahmad: Here we consider adding all the names of jobs wintin input
% features using representation B
%clc
%clear
%close all

%function []=test2(InputPath11, Output_Path11)

%set(0,'DefaultFigureWindowStyle','docked')

uuuuuu= InputPath11
uuuu= Output_Path11


Number_of_Jobs_Types = 6 % This is for number of jobs , ex:  'xalan','tradesoap','tradebeans','lusearch','sunflow', 'jython', 'h2', 'avrora', 'batik'


AllMonodata1=load('./p08+0+0-noht1/mondata.mat');
ht= ones(length(AllMonodata1.Tput) , 1);
noth= zeros(length(AllMonodata1.Tput) , 1);
nice= zeros(length(AllMonodata1.Tput) , 2); 
data1= [ noth, nice , AllMonodata1.RunQ, AllMonodata1.Tput(:,1)];



AllMonodata2=load('./p08+0+0-noht2/mondata.mat');
ht= ones(length(AllMonodata2.Tput) , 1);
noth= zeros(length(AllMonodata2.Tput) , 1);
nice= zeros(length(AllMonodata2.Tput) , 2); 
data2= [ noth, nice , AllMonodata2.RunQ(:,1:4), AllMonodata2.Tput(:,1)];


AllMonodata3=load('./p08+0+0-noht3/mondata.mat');
ht= ones(length(AllMonodata3.Tput) , 1);
noth= zeros(length(AllMonodata3.Tput) , 1);
nice= zeros(length(AllMonodata3.Tput) , 2); 
%nice(:,1)=10;
data3= [ noth, nice, AllMonodata3.RunQ, AllMonodata3.Tput(:,1)];


AllMonodata4=load('./p08+0+0-noht4/mondata.mat');
ht= ones(length(AllMonodata4.Tput) , 1);
noth= zeros(length(AllMonodata4.Tput) , 1);
nice= zeros(length(AllMonodata4.Tput) , 2); 
data4= [ noth, nice, AllMonodata4.RunQ, AllMonodata4.Tput(:,1)];

% 
% %%%%%%%%%% Data from all other Picards %%%%%%%%%%%%%%%
% AllMonodata5=load('p07+0+0-noht5.mat');
% ht= ones(length(AllMonodata5.Tput) , 1);
% noth= zeros(length(AllMonodata5.Tput) , 1);
% nice= zeros(length(AllMonodata5.Tput) , 2); 
% %nice(:,1)=15; nice(:,2)=0;
% data5= [ noth, nice, AllMonodata5.RunQ, AllMonodata5.Tput(:,1)];
% % 
% AllMonodata6=load('p07+0+0-noht6.mat');
% ht= ones(length(AllMonodata6.Tput) , 1);
% noth= zeros(length(AllMonodata6.Tput) , 1);
% nice= zeros(length(AllMonodata6.Tput) , 2); 
% %nice(:,1)=10; nice(:,2)=0;
% data6= [ noth, nice, AllMonodata6.RunQ, AllMonodata6.Tput(:,1)];
% 
% AllMonodata7=load('p07+0+0-noht7.mat');
% ht= ones(length(AllMonodata7.Tput) , 1);
% noth= zeros(length(AllMonodata7.Tput) , 1);
% nice= zeros(length(AllMonodata7.Tput) , 2); 
% %nice(:,1)=5; nice(:,2)=0;
% data7= [ noth, nice, AllMonodata7.RunQ, AllMonodata7.Tput(:,1)];
% 
% AllMonodata8=load('p07+0+0-noht8.mat');
% ht= ones(length(AllMonodata8.Tput) , 1);
% noth= zeros(length(AllMonodata8.Tput) , 1);
% nice= zeros(length(AllMonodata8.Tput) , 2); 
% %nice(:,1)=1; nice(:,2)=0;
% data8= [ noth, nice, AllMonodata8.RunQ, AllMonodata8.Tput(:,1)];
% 
% AllMonodata9=load('p07+0+0-noht9.mat');
% ht= ones(length(AllMonodata9.Tput) , 1);
% noth= zeros(length(AllMonodata9.Tput) , 1);
% nice= zeros(length(AllMonodata9.Tput) , 2); 
% %nice(:,1)=0; nice(:,2)=0;
% data9= [ noth, nice, AllMonodata9.RunQ, AllMonodata9.Tput(:,1)];
% 
% 
% %%%%%%%%%%% Picard01 %%%%%%%%%%
% AllMonodata10=load('p07+0+0-noht10.mat');
% ht= ones(length(AllMonodata10.Tput) , 1);
% noth= zeros(length(AllMonodata10.Tput) , 1);
% nice= zeros(length(AllMonodata10.Tput) , 2); 
% %nice(:,1)=0; nice(:,2)=0;
% data10= [ noth, nice, AllMonodata10.RunQ, AllMonodata10.Tput(:,1)];
% 
% 

















% AllMonodata2=load('mondata_p07+0+0-noht.mat');
% ht= ones(length(AllMonodata2.Tput) , 1);
% noth= zeros(length(AllMonodata2.Tput) , 1);
% nice= zeros(length(AllMonodata2.Tput) , 2); 
% data2= [ noth, nice , AllMonodata2.RunQ(:,1:4), AllMonodata2.Tput(:,1)];
% 
% 
% AllMonodata3=load('mondata_p07+10+0-noht.mat');
% ht= ones(length(AllMonodata3.Tput) , 1);
% noth= zeros(length(AllMonodata3.Tput) , 1);
% nice= zeros(length(AllMonodata3.Tput) , 2); 
% nice(:,1)=10;
% data3= [ noth, nice, AllMonodata3.RunQ, AllMonodata3.Tput(:,1)];
% 
% 
% AllMonodata4=load('mondata_p07+0+0-noht-batch.mat');
% ht= ones(length(AllMonodata4.Tput) , 1);
% noth= zeros(length(AllMonodata4.Tput) , 1);
% nice= zeros(length(AllMonodata4.Tput) , 2); 
% data4= [ noth, nice, AllMonodata4.RunQ, AllMonodata4.Tput(:,1)];


%%%%%%%%%%% Data from all other Picards %%%%%%%%%%%%%%%
% AllMonodata5=load('mondata_p02+15+0-noht.mat');
% ht= ones(length(AllMonodata5.Tput) , 1);
% noth= zeros(length(AllMonodata5.Tput) , 1);
% nice= zeros(length(AllMonodata5.Tput) , 2); 
% nice(:,1)=15; nice(:,2)=0;
% data5= [ noth, nice, AllMonodata5.RunQ, AllMonodata5.Tput(:,1)];
% 
% AllMonodata6=load('mondata_p02+10+0-noht.mat');
% ht= ones(length(AllMonodata6.Tput) , 1);
% noth= zeros(length(AllMonodata6.Tput) , 1);
% nice= zeros(length(AllMonodata6.Tput) , 2); 
% nice(:,1)=10; nice(:,2)=0;
% data6= [ noth, nice, AllMonodata6.RunQ, AllMonodata6.Tput(:,1)];
% 
% AllMonodata7=load('mondata_p02+5+0-noht.mat');
% ht= ones(length(AllMonodata7.Tput) , 1);
% noth= zeros(length(AllMonodata7.Tput) , 1);
% nice= zeros(length(AllMonodata7.Tput) , 2); 
% nice(:,1)=5; nice(:,2)=0;
% data7= [ noth, nice, AllMonodata7.RunQ, AllMonodata7.Tput(:,1)];
% 
% AllMonodata8=load('mondata_p02+1+0-noht.mat');
% ht= ones(length(AllMonodata8.Tput) , 1);
% noth= zeros(length(AllMonodata8.Tput) , 1);
% nice= zeros(length(AllMonodata8.Tput) , 2); 
% nice(:,1)=1; nice(:,2)=0;
% data8= [ noth, nice, AllMonodata8.RunQ, AllMonodata8.Tput(:,1)];
% 
% AllMonodata9=load('mondata_p02+0+0-noht.mat');
% ht= ones(length(AllMonodata9.Tput) , 1);
% noth= zeros(length(AllMonodata9.Tput) , 1);
% nice= zeros(length(AllMonodata9.Tput) , 2); 
% nice(:,1)=0; nice(:,2)=0;
% data9= [ noth, nice, AllMonodata9.RunQ, AllMonodata9.Tput(:,1)];
% 
% 
% %%%%%%%%%%% Picard01 %%%%%%%%%%
% AllMonodata10=load('mondata_p01+0+0-noht.mat');
% ht= ones(length(AllMonodata10.Tput) , 1);
% noth= zeros(length(AllMonodata10.Tput) , 1);
% nice= zeros(length(AllMonodata10.Tput) , 2); 
% nice(:,1)=0; nice(:,2)=0;
% data10= [ noth, nice, AllMonodata10.RunQ, AllMonodata10.Tput(:,1)];
% 
% AllMonodata11=load('mondata_p01+15+0-noht.mat');
% ht= ones(length(AllMonodata11.Tput) , 1);
% noth= zeros(length(AllMonodata11.Tput) , 1);
% nice= zeros(length(AllMonodata11.Tput) , 2); 
% nice(:,1)=15; nice(:,2)=0;
% data11= [ noth, nice, AllMonodata11.RunQ, AllMonodata11.Tput(:,1)];
% 
% AllMonodata12=load('mondata_p01+10+0-noht.mat');
% ht= ones(length(AllMonodata12.Tput) , 1);
% noth= zeros(length(AllMonodata12.Tput) , 1);
% nice= zeros(length(AllMonodata12.Tput) , 2); 
% nice(:,1)=10; nice(:,2)=0;
% data12= [ noth, nice, AllMonodata12.RunQ, AllMonodata12.Tput(:,1)];
% 
% AllMonodata13=load('mondata_p01+5+0-noht.mat');
% ht= ones(length(AllMonodata13.Tput) , 1);
% noth= zeros(length(AllMonodata13.Tput) , 1);
% nice= zeros(length(AllMonodata13.Tput) , 2); 
% nice(:,1)=5; nice(:,2)=0;
% data13= [ noth, nice, AllMonodata13.RunQ, AllMonodata13.Tput(:,1)];
% 
% AllMonodata14=load('mondata_p01+1+0-noht.mat');
% ht= ones(length(AllMonodata14.Tput) , 1);
% noth= zeros(length(AllMonodata14.Tput) , 1);
% nice= zeros(length(AllMonodata14.Tput) , 2); 
% nice(:,1)=1; nice(:,2)=0;
% data14= [ noth, nice, AllMonodata14.RunQ, AllMonodata14.Tput(:,1)];
% 
% 
% %%%%%%%%%%%%%%% 4 jops from all Picards %%%%%%%%%%%%%%%%%%
% 
% AllMonodata15=load('mondata_p01+0+0+0+0-noht.mat');
% ht= ones(length(AllMonodata15.Tput) , 1);
% noth= zeros(length(AllMonodata15.Tput) , 1);
% nice= zeros(length(AllMonodata15.Tput) , 2); 
% nice(:,1)=1; nice(:,2)=0;
% data15= [ noth, nice, AllMonodata15.RunQ, AllMonodata15.Tput(:,1)];
% 
% 
% AllMonodata16=load('mondata_p07+0+0+0+0-noht.mat');
% ht= ones(length(AllMonodata16.Tput) , 1);
% noth= zeros(length(AllMonodata16.Tput) , 1);
% nice= zeros(length(AllMonodata16.Tput) , 2); 
% nice(:,1)=1; nice(:,2)=0;
% data16= [ noth, nice, AllMonodata16.RunQ, AllMonodata16.Tput(:,1)];
% 
% AllMonodata17=load('mondata_p07+15+10+5+0-noht.mat');
% ht= ones(length(AllMonodata17.Tput) , 1);
% noth= zeros(length(AllMonodata17.Tput) , 1);
% nice= zeros(length(AllMonodata17.Tput) , 2); 
% nice(:,1)=1; nice(:,2)=0;
% data17= [ noth, nice, AllMonodata17.RunQ, AllMonodata17.Tput(:,1)];
% 
% 
% AllMonodata18=load('mondata_p07+15+10+5+15-noht.mat');
% ht= ones(length(AllMonodata18.Tput) , 1);
% noth= zeros(length(AllMonodata18.Tput) , 1);
% nice= zeros(length(AllMonodata18.Tput) , 2); 
% nice(:,1)=1; nice(:,2)=0;
% data18= [ noth, nice, AllMonodata18.RunQ, AllMonodata18.Tput(:,1)];
% 
% 
% 
% AllMonodata19=load('mondata_p07+15+10+10+15-noht.mat');
% ht= ones(length(AllMonodata19.Tput) , 1);
% noth= zeros(length(AllMonodata19.Tput) , 1);
% nice= zeros(length(AllMonodata19.Tput) , 2); 
% nice(:,1)=1; nice(:,2)=0;
% data19= [ noth, nice, AllMonodata19.RunQ, AllMonodata19.Tput(:,1)];
% 
% AllMonodata20=load('mondata_p07+15+10+15+15-noht.mat');
% ht= ones(length(AllMonodata20.Tput) , 1);
% noth= zeros(length(AllMonodata20.Tput) , 1);
% nice= zeros(length(AllMonodata20.Tput) , 2); 
% nice(:,1)=1; nice(:,2)=0;
% data20= [ noth, nice, AllMonodata20.RunQ, AllMonodata20.Tput(:,1)];
% %%%%%%%%%%%%%%   4 Jops All Picards (1, 2, and 3)%%%%%%%%%%%%%%%%%%%%%
% 


%All
%%%data=[data1 ; data2 ; data3; data4 ; data5 ; data6 ; data7; data8; data9; data10];
data=[data1 ; data2 ; data3; data4 ];% data5 ; data6 ; data7; data8; data9; data10];

%ToAdd2ColumnZeros= zeros(length(data) , 2); 
%data=[data, ToAdd2ColumnZeros];

%data=[data1 ; data2 ; data3; data4 ; data10; data11 ; data12 ; data13; data14]; % Pi07 and Pi01
%data=[data1 ; data2 ; data3; data4 ; data5 ; data6 ; data7; data8; data9 ]; % Pi07 and Pi02
%data=[data1 ; data2 ; data3; data4 ; data5 ; data6 ; data7; data8; data9; data10; data11 ; data12 ; data13; data14];

%data=[ data1];% ; data2 ; data3 ; data4 ];

%AllMonodata_Traces=[AllMonodata1.traces(1,:) , AllMonodata2.traces(1,:) , AllMonodata3.traces(1,:) , AllMonodata4.traces(1,:) , AllMonodata10.traces(1,:), AllMonodata11.traces(1,:) , AllMonodata12.traces(1,:) , AllMonodata13.traces(1,:) , AllMonodata14.traces(1,:)]';     % Pi07 and Pi01

%AllMonodata_Traces= [AllMonodata1.traces(1,:) , AllMonodata2.traces(1,:) , AllMonodata3.traces(1,:) , AllMonodata4.traces(1,:) , AllMonodata5.traces(1,:) , AllMonodata6.traces(1,:) , AllMonodata7.traces(1,:) , AllMonodata8.traces(1,:) ,AllMonodata9.traces(1,:)]'; % Pi07 and Pi02
%AllMonodata_Traces= [AllMonodata1.traces(1,:) , AllMonodata2.traces(1,:) , AllMonodata3.traces(1,:) , AllMonodata4.traces(1,:) , AllMonodata5.traces(1,:) , AllMonodata6.traces(1,:) , AllMonodata7.traces(1,:) , AllMonodata8.traces(1,:) ,AllMonodata9.traces(1,:), AllMonodata10.traces(1,:), AllMonodata11.traces(1,:) , AllMonodata12.traces(1,:) , AllMonodata13.traces(1,:) , AllMonodata14.traces(1,:)]';

%AllMonodata_Traces= [AllMonodata3.traces(1,:) , AllMonodata5.traces(1,:) , AllMonodata6.traces(1,:) , AllMonodata7.traces(1,:) ]';
%AllMonodata_Traces= [AllMonodata1.traces(1,:)]';% , AllMonodata2.traces(1,:) , AllMonodata3.traces(1,:) , AllMonodata4.traces(1,:) ]';
%%%%AllMonodata_Traces= [AllMonodata1.traces(1,:) , AllMonodata2.traces(1,:) , AllMonodata3.traces(1,:) , AllMonodata4.traces(1,:) , AllMonodata5.traces(1,:) , AllMonodata6.traces(1,:) , AllMonodata7.traces(1,:) , AllMonodata8.traces(1,:) ,AllMonodata9.traces(1,:), AllMonodata10.traces(1,:)]';
AllMonodata_Traces= [AllMonodata1.traces(1,:) , AllMonodata2.traces(1,:) , AllMonodata3.traces(1,:) , AllMonodata4.traces(1,:) ]';%, AllMonodata5.traces(1,:) , AllMonodata6.traces(1,:) , AllMonodata7.traces(1,:) , AllMonodata8.traces(1,:) ,AllMonodata9.traces(1,:), AllMonodata10.traces(1,:)]';




% The following code is to add the name of jobs as a number(0 to Number_of_Jobs_Types). 0=no
% job
NumberOfJobs=2;
size_Traces= length(AllMonodata_Traces);
Traces= string(AllMonodata_Traces);
%OnlyTracesLetters= regexprep(Traces,'\d+',''); % to remove numbers from string
OnlyTracesLetters= regexprep(Traces,'^\d+','') % to remove the number in the firest left side from string, which is the date

 for i = 1:size_Traces   % to add "-" for singl job
       i
     if NumberOfJobs == 2    
        if 0 == contains(OnlyTracesLetters(i,1),'-')
            OnlyTracesLetters(i,1)= strcat(OnlyTracesLetters(i,1),"-");
        end
     end
     
     if NumberOfJobs == 4    
        if 0 == contains(OnlyTracesLetters(i,1),'-')
            OnlyTracesLetters(i,1)= strcat(OnlyTracesLetters(i,1),"---"); %thre dash for more thre jobs +single job
        end
     end 

  end

newStr = split(OnlyTracesLetters,"-");  % Split strings at delimiters

%To convert any string with "" empty to be a zero
for j=1:NumberOfJobs
    for i=1:size_Traces
        if (newStr(i,j) == "")
            disp 'str has zero characters: Training'
            newStr(i,j) = "0";
        end
    end
end

newStr=strrep(newStr,"batik","1");
newStr=strrep(newStr,"jython","2");
newStr=strrep(newStr,"luindex","3");
newStr=strrep(newStr,"lusearch","4");
newStr=strrep(newStr,"sunflow","5");
newStr=strrep(newStr,"xalan","6");
%%%%%newStr=strrep(newStr,"h2","7");
%%%%%newStr=strrep(newStr,"tradesoap","8");
%%%%%newStr=strrep(newStr,"tradebeans","9");




%data=[str2double(newStr) , data]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Here we need to add the number of each jobs in a rows format. Eg:
% -------------------------
% |1  |2  |3  |4  |5  | 6  |  < -- Name of jobs
% -------------------------
% |1  |0  |0  |1  |0  |0   |  < -- This row represent one exp
% -------------------------
% |0  |2  |0  |0  |0  |0   |
% -------------------------

TracesDouble = str2double(newStr)
[SizeR, SizeC]= size(TracesDouble);
RowNumbersOfJobsName= zeros(SizeR, Number_of_Jobs_Types)  ; % 6 is the number of jobs types

for i=1:SizeR
    i
    RowNumbersOfJobsName(i,TracesDouble(i,1))= RowNumbersOfJobsName(i,TracesDouble(i,1)) +1
    if (TracesDouble(i,2) ~= 0)
        RowNumbersOfJobsName(i,TracesDouble(i,2))= RowNumbersOfJobsName(i,TracesDouble(i,2)) +1
    end
end
data=[RowNumbersOfJobsName, data]

RowNumbersOfJobsName_Train =RowNumbersOfJobsName;

input=data(:,1:end-1);
input(isnan(input))=0; %To set all NaN in Q to zero:

target=data(:,end);


%---------------------------------------------
%Testing data
%Test_File_mondata= "mondata_p07+0+0+0+0-noht.mat"
%Test_File_mondata= "mondata_p07+0+0+0+0-noht-z2.mat"
%Test_File_mondata= "mondata_p07+15+10+5+0-noht.mat"
%Test_File_mondata= "mondata_p07+15+10+5+15-noht.mat"
%Test_File_mondata= "mondata_p07+15+10+10+15-noht.mat"
%Test_File_mondata= "mondata_p07+15+10+15+15-noht.mat"
Test_File_mondata= "p07+0+0+0+0-noht6-V2.mat"
Test_File_mondata= "p08+0+0+0+0-noht_V3.mat"
Test_File_mondata="./p08+0+0+0+0-noht/mondata.mat"

AllMonodata_Test=load(Test_File_mondata);

ht= ones(length(AllMonodata_Test.Tput) , 1);
noth= zeros(length(AllMonodata_Test.Tput) , 1);
nice= zeros(length(AllMonodata_Test.Tput) , 2); 
%nice(:,1)=15;   nice(:,2)=5;   nice(:,3)=5;   nice(:,4)=15;  %%%%%%%%% You have to change this acording to the inputs test

data_Test= [ noth, nice , AllMonodata_Test.RunQ(:,1:4), AllMonodata_Test.Tput(:,1)];



AllMonodata_Traces= [AllMonodata_Test.traces(1,:)]';




% The following code is to add the name of jpbs as a number(0 to Number_of_Jobs_Types). 0=no
% job
NumberOfJobs=4;
size_Traces= length(AllMonodata_Traces);
Traces= string(AllMonodata_Traces);
%OnlyTracesLetters= regexprep(Traces,'\d+',''); % to remove numbers from string
OnlyTracesLetters= regexprep(Traces,'^\d+','') % to remove the number in the firest left side from string, which is the date

 for i = 1:size_Traces   % to add "-" for singl job
       i;
     if NumberOfJobs == 2    
        if 0 == contains(OnlyTracesLetters(i,1),'-')
            OnlyTracesLetters(i,1)= strcat(OnlyTracesLetters(i,1),"-");
        end
     end
     
     if NumberOfJobs == 4    
        if 0 == contains(OnlyTracesLetters(i,1),'-')
            OnlyTracesLetters(i,1)= strcat(OnlyTracesLetters(i,1),"---"); %thre dash for more thre jobs +single job
        end
     end 

  end

newStr = split(OnlyTracesLetters,"-");  % Split strings at delimiters

%To convert any string with "" empty to be a zero
for j=1:NumberOfJobs
    for i=1:size_Traces
        if (newStr(i,j) == "")
            disp 'str has zero characters: Testing'
            newStr(i,j) = "0";
        end
    end
end

newStr=strrep(newStr,"batik","1");
newStr=strrep(newStr,"jython","2");
newStr=strrep(newStr,"luindex","3");
newStr=strrep(newStr,"lusearch","4");
newStr=strrep(newStr,"sunflow","5");
newStr=strrep(newStr,"xalan","6");
%%%%%newStr=strrep(newStr,"h2","7");
%%%%%newStr=strrep(newStr,"tradesoap","8");
%%%%%newStr=strrep(newStr,"tradebeans","9");


%data_Test=[str2double(newStr) , data_Test]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Here we need to add the number of each jobs in a rows format. Eg:
% -------------------------
% |1  |2  |3  |4  |5  | 6  |  < -- Name of jobs
% -------------------------
% |1  |0  |0  |1  |0  |0   |  < -- This row represent one exp
% -------------------------
% |0  |2  |0  |0  |0  |0   |  < -- This row represent one exp
% -------------------------

TracesDouble = str2double(newStr);
[SizeR, SizeC]= size(TracesDouble);
RowNumbersOfJobsName= zeros(SizeR, Number_of_Jobs_Types);   % Number_of_Jobs_Types is the number of jobs types

for i=1:SizeR
    RowNumbersOfJobsName(i,TracesDouble(i,1))= RowNumbersOfJobsName(i,TracesDouble(i,1)) +1;
    if (TracesDouble(i,2) ~= 0)  % More than one job
        RowNumbersOfJobsName(i,TracesDouble(i,2))= RowNumbersOfJobsName(i,TracesDouble(i,2)) +1;
        RowNumbersOfJobsName(i,TracesDouble(i,3))= RowNumbersOfJobsName(i,TracesDouble(i,3)) +1;
        RowNumbersOfJobsName(i,TracesDouble(i,4))= RowNumbersOfJobsName(i,TracesDouble(i,4)) +1;
    end
end
data_Test=[RowNumbersOfJobsName, data_Test];

RowNumbersOfJobsName_Test = RowNumbersOfJobsName;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


input_Test=data_Test(:,1:end-1);
input_Test(isnan(input_Test))=0 %To set all NaN in Q to zero:

target_Test=data_Test(:,end);



%%%%%%%%%%%%%%data3(isnan(data3))=0;
%inputTest=data3(:,1:end-1);
%targetTest=data3(:,end);

NumberofIterations= 1000                               % This is the number of iterations to run the neural networks function 
NumberofIterations_Char=num2str(NumberofIterations);      % to convert it to string  in order to use it for the figure title 
Best_TargetValue_MAPE=15
% For chosing the all result of neural network results that are equal or less than Best_TargetValue_MAPE  
Best_TargetValue_MAPE_Char=num2str(Best_TargetValue_MAPE) % to convert it to string  in order to use it for the figure title 
j=0;
NumberOfBestValue = 4;
TheBestNeuralNetworks=cell(NumberOfBestValue,1)
 for i = 1:NumberofIterations   % to add "-" for singl job

     [MAPE(:,i) , R(1,i), NeuralNetworks] = myNeuralNetworkFunction_MAPE(input,target,input_Test, target_Test,Best_TargetValue_MAPE );
     MEAN_MAPE(i,1) = mean( MAPE(:,i))
     if mean( MAPE(:,i)) <= Best_TargetValue_MAPE && j < NumberOfBestValue
         i
         j=j+1
         MAPE_Best(:,j)= MAPE(:,i);
         
         %This to save NN that acchived < 'Best_TargetValue_MAPE'
         TheBestNeuralNetworks{j,1}= NeuralNetworks;
         save TheBestNeuralNetworks
         %clear net;
     end
     
     Average_Row= mean(MAPE, 2); %% mean for rows
     
 end
 
figure(1)
boxplot(MAPE,'symbol','')
hold on
mx = nanmean(MAPE);
plot(mx,'.')
plot(nanmedian(MAPE),'x')
set(gca,'xticklabel',{'NN_MAPE'})
title('Completion Time - Percentage Error')
legend('mean','median')
%ylim([0, max(100,1.1*max(MAPE(:)))])
ylim([0, 100])%max(100,1.1*max(MAPE(:)))])
hold off

figure(2)
boxplot(MAPE_Best,'symbol','')
hold on
mx = nanmean(MAPE_Best);
plot(mx,'.')
plot(nanmedian(MAPE_Best),'x')
set(gca,'xticklabel',{'NN'})
title_Temp= 'CompletionT MAPE - Best:' + convertCharsToStrings(Best_TargetValue_MAPE_Char) + '- Data:'+Test_File_mondata;
%title_Temp_String= num2str(title_Temp);
title(title_Temp)
legend('mean','median')
%ylim([0,max(150,1.1*max(R(:)))])
ylim([0, 100])%max(100,1.1*max(MAPE(:)))])
hold off

datasets="Best4NN"
saveas(gcf,char(datasets),'epsc')


figure(3)
boxplot(Average_Row,'symbol','')
hold on
mx = nanmean(Average_Row);
plot(mx,'.')
plot(nanmedian(Average_Row),'x')
set(gca,'xticklabel',{'NN'})
title_Temp= 'CompletionT MAPE - '+ convertCharsToStrings(NumberofIterations_Char) +' Iterations - Best:' + convertCharsToStrings(Best_TargetValue_MAPE_Char)+ ' - Data:' + Test_File_mondata;
%%%%%%title_Temp_String= num2str(title_Temp);
title(title_Temp)
legend('mean','median')
%ylim([0,max(250,1.1*max(R(:)))])
ylim([0, 100])%max(100,1.1*max(MAPE(:)))])
hold off


Test_File_mondata




csvwrite('input_Train.csv', input) 
csvwrite('target_Train.csv',target) 
csvwrite('input_Test.csv', input_Test) 
csvwrite('target_Test.csv', target_Test) 

% BestMAPE= [ MAPE(:,5) , MAPE(:,15), MAPE(:,21), MAPE(:,29)];
% figure(2)
% boxplot(BestMAPE,'symbol','')
% hold on
% mx = nanmean(BestMAPE);
% plot(mx,'.')
% plot(nanmedian(BestMAPE),'x')
% set(gca,'xticklabel',{'NN'})
% title('Completion Time - Percentage Error')
% legend('mean','median')
% ylim([0,max(70,1.1*max(R(:)))])


% boxplot(x,'symbol','')
% hold on
% mx = nanmean(x);
% plot(mx,'.')
% plot(nanmedian(x),'x')
% set(gca,'xticklabel',{'No model','OA','QN'})
% title('Completion Time - Percentage Error')
% legend('mean','median')
% ylim([0,max(70,1.1*max(x(:)))])
% fontset



% meanOutput(:,1)=target;
% meanOutput(:,2)=myNeuralNetworkFunction(input);
% meanOutput(:,3)=abs(meanOutput(:,1)-meanOutput(:,2));%/length(output)
% meanOutput(:,4)=  (abs(meanOutput(:,1)- meanOutput(:,2)) ./ meanOutput(:,1) ) * 100 ;
% Percent_Error = mean(meanOutput(:,4))
% 
% meanAll=mean(meanOutput(:,3))
% maeALL=mae(meanOutput(:,1),meanOutput(:,2))
% mseALLMe=mean((meanOutput(:,1) - meanOutput(:,2)).^2)
% mseALL=mse(meanOutput(:,1),meanOutput(:,2))
% 
% 
% meanOutput_Test(:,1)=target_Test;
% meanOutput_Test(:,2)=myNeuralNetworkFunction(input_Test);
% meanOutput_Test(:,4)=  (abs(meanOutput_Test(:,1)- meanOutput_Test(:,2)) ./ meanOutput_Test(:,1) ) * 100 ;
% Percent_Error_Test = mean(meanOutput_Test(:,4))
% 
% meanOutput_Test(:,3)=abs(meanOutput_Test(:,1)- meanOutput_Test(:,2));%/length(output)
% 
% meanAll_Test=mean(meanOutput_Test(:,3))
% maeALL_Test=mae(meanOutput_Test(:,1) , meanOutput_Test(:,2))
% meanALLMe_Test=mean((meanOutput_Test(:,1) - meanOutput_Test(:,2)).^2)  %mean(meanOutput_Test(:,3))
% mseALL_Test=mse(meanOutput_Test(:,1) , meanOutput_Test(:,2))





