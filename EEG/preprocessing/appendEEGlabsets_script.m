% merge sets for a subject/ condition
clear all;

% where is the data
subs = {'S01','S02','S03','S04','S05','S06','S07','S08','S09','S10'};
subs = {'S03'};
for si = 1:length(subs)
    % no vis
    path = ['D:\AMICAtest\prePropData\' subs{si} '\noVis\'];
   % path = ['D:\AMICAtest\noInterpolation\preProcessed\' subs{si} '\noVis\'];
     saveName = [subs{si} '_NV.set'];
%   visual
     %path = ['D:\AMICAtest\prePropData\' subs{si} '\vis\'];
%     path = ['D:\AMICAtest\noInterpolation\preProcessed\' subs{si} '\vis\'];
     %saveName = [subs{si} '_vis.set'];

%   right hand
%      path = ['D:\AMICAtest\prePropData\' subs{si} '\RH\'];
%     path = ['D:\AMICAtest\noInterpolation\preProcessed\' subs{si} '\RH\']
%     saveName = [subs{si} '_RH.set'];
    cd(path)
    
    % look for files with the '.set' format 
    set2use = '*.set';
    fileList = dir(set2use);

    % load sets as a group to  eeglab
    names  = {fileList.name};

    EEG= pop_loadset('filename',names,'filepath', path);

    % merge the datasets together
    numSets = length(EEG);
    EEG = pop_mergeset( EEG, [1:length(EEG)], 0);

    % save the merged dataset
    
    EEG = pop_saveset( EEG, 'filename',saveName ,'filepath',path);

end



%% segment data
% this achieves the situation by usint the second prior to the cue as
% baseline, but it must be done that we 
% EEG = pop_epoch( EEG, {  '2'  '40'  '60'  }, [-1  2], 'newname', [saveName(1:end-5) ' epochs'], 'epochinfo', 'yes');

