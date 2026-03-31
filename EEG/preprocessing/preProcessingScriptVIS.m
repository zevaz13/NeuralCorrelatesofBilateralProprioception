% this script is to do general data pre-processing, it uses the function
% general preProcessing and this version does interpolation and appends the
% sets. it receives a set of multiple .dat files for each subject and
% returns a set of all the .set and the set with the appended trials.

clear all

subs = {'S01','S02','S03','S04','S05','S06','S07','S09','S10'...
'S11', 'S12','S13','S14','S15', 'S17','S18','S19','S21','S23','S24'};
subs = {'S24'};

cond = 'VIS'; % can be 'VIS' and 'RH'
debug = 0; % defines if we want to see the hardware triggers
for si = 1:length(subs)
%     % novis
    path = ['C:\Users\rued7682\OneDrive - University of Idaho\proprioception\data\' subs{si} '\' subs{si} '_Vi001\'];
    targetFolder = ['D:\AMICAtest\prePropData\' subs{si} '\vis\'];
    mkdir(targetFolder);
    % imports sets 
    generalPreprocessing(path,targetFolder,cond,debug);
    % appends sets
    saveName = [subs{si} '_vis.set'];
    genneralAppend(targetFolder, saveName)
end
