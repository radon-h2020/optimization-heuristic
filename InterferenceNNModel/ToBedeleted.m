clc
clear

%Toget all the folders names of datasets
%Training data
FolderInputDatasets_Training = dir('DataSetsS1+0+0-noht*')
% remove all files (isdir property is 0)
dfolders_Training = FolderInputDatasets_Training([FolderInputDatasets_Training(:).isdir]) 
% remove '.' and '..' 
dfolders_Training = dfolders_Training(~ismember({dfolders_Training(:).name},{'.','..'}))

for i = 1:length(dfolders_Training)
    x={dfolders_Training.name}
    PathToData(i,1)=char(x{1,i})+"/mondata.mat"
end


%Toget all the folders names of datasets
%Training data
FolderInputDatasets_Testing = dir('Da*+*+*+*')
% remove all files (isdir property is 0)
dfolders_Test = FolderInputDatasets_Testing([FolderInputDatasets_Testing(:).isdir]) 
% remove '.' and '..' 
dfolders_Test = dfolders_Test(~ismember({dfolders_Test(:).name},{'.','..'}))
