close all; clear all;
% what this script does is to take all the runs for a subjectand separates
% them into datasets for each respective condition, in this case I have
% decided to name them H2, MH2, H2_V, MH2_V, and RH. The reason for this is
% the creation of a study structure to be able to do some more cool
% exploration of the data. 
% It is important to remember that H2 and MH2 share the same compoments for
% both sets, same thing with H2_V and MH2_V
% Also decided to try a function called epochRejStat that I myself wrote
% some time ago... MUST check. Aso check the one for epoch rejection
% plotting. Those can be good for data expioration in term sof noise and
% possible parameter selection.

% where is the data
% subs = {'S11','S12','S13','S14','S15',};
subs = {'S01','S02','S03','S04','S05','S06','S07','S09','S10','S11','S12','S13','S14','S15','S17','S18','S19','S21','S23','S24'};
subs = {'S01','S02'};

for si = 1:length(subs)
    % move the pointer to the desired path 
    path = ['D:\AMICAtest\results2\' subs{si}];
    targetfolder= ['D:\spcDecomp\' subs{si}];
    mkdir(targetfolder);
    cd(path);
    %% do stuff to RH set 
    EEG = pop_loadset([subs{si} '_RH.set']);
    % flag artifact components
    EEG = pop_iclabel(EEG, 'default');
    EEG = pop_icflag(EEG, [NaN NaN;0.4 1;0.4 1;0.4 1;0.4 1;0.4 1;NaN NaN]);
    
    % remove components 
    EEG = pop_subcomp( EEG, find(EEG.reject.gcompreject), 0);
    % epoch the set, for RH the hardware trigger = 50.
    EEG = pop_epoch( EEG, {  '50'  }, [-1  2],  'epochinfo', 'yes');
    origTr = length(EEG.epoch);

    % modify tags on set 
    EEG.subject  = subs{si};
    EEG.condition= 'RH' ;
    
    % remove epochs 
    EEG = epochRejStat(EEG, 'avg', 3);
    EEG = epochRejStat(EEG, 'kurtosis', 5);
    EEG.badTrials.org = origTr;
    EEG.badTrials.tot = length(EEG.epoch);
    % save set 
            
    EEG = pop_saveset( EEG, 'filename',[subs{si} '_RH.set'],'filepath',targetfolder);

    clear 'EEG'
    %% do stuff to the NV set. shoud create H2 and MH2
    EEG = pop_loadset([subs{si} '_NV.set']);
    % flag artifact components
    EEG = pop_iclabel(EEG, 'default');
    EEG = pop_icflag(EEG, [NaN NaN;0.4 1;0.4 1;0.4 1;0.4 1;0.4 1;NaN NaN]);
    
    % remove components 
    EEG = pop_subcomp( EEG, find(EEG.reject.gcompreject), 0);
    % epoch the set, for H2 the hardware trigger = 40.
    EEG1 = pop_epoch( EEG, {  '40'  }, [-1  2],'epochinfo', 'yes');
    % modify tags on set 
    EEG1.subject  = subs{si};
    EEG1.condition= 'H2' ;
    % remove epochs
    origTr = length(EEG1.epoch);
    EEG1 = epochRejStat(EEG1, 'avg', 3);
    EEG1 = epochRejStat(EEG1, 'kurtosis', 5);
    EEG1.badTrials.org = origTr;
    EEG1.badTrials.tot = length(EEG1.epoch);
    % save set H2
    EEG1 = pop_saveset( EEG1, 'filename',[subs{si} '_H2.set'],'filepath',targetfolder); clear 'EEG1'
    
    % epoch the set, for MH2 the hardware trigger = 60.
    EEG2 = pop_epoch( EEG, {  '60'  }, [-1  2],'epochinfo', 'yes');
    % modify tags on set 
    EEG2.subject  = subs{si};
    EEG2.condition= 'MH2' ;
    
    % remove epochs
    origTr = length(EEG2.epoch);
    EEG2 = epochRejStat(EEG2, 'avg', 3);
    EEG2 = epochRejStat(EEG2, 'kurtosis', 5);
    EEG2.badTrials.org = origTr;
    EEG2.badTrials.tot = length(EEG2.epoch);

    % save set MH2
    EEG2 = pop_saveset( EEG2, 'filename',[subs{si} '_MH2.set'],'filepath',targetfolder); clear 'EEG2'

    %% do stuff to the vis set. should create H2_V and MH2_V
    EEG = pop_loadset([subs{si} '_vis.set']);
    
    % flag artifact components
    EEG = pop_iclabel(EEG, 'default');
    EEG = pop_icflag(EEG, [NaN NaN;0.4 1;0.4 1;0.4 1;0.4 1;0.4 1;NaN NaN]);
    
    % remove components 
    EEG = pop_subcomp( EEG, find(EEG.reject.gcompreject), 0);
    % epoch the set, for H2 the hardware trigger = 40.
    EEG1 = pop_epoch( EEG, {  '20'  }, [-1  2],'epochinfo', 'yes');
    % modify tags on set 
    EEG1.subject  = subs{si};
    EEG1.condition= 'H2_V' ;
    % remove epochs 
    origTr = length(EEG1.epoch);
    EEG1 = epochRejStat(EEG1, 'avg', 3);
    EEG1 = epochRejStat(EEG1, 'kurtosis', 5);
    EEG1.badTrials.org = origTr;
    EEG1.badTrials.tot = length(EEG1.epoch);
    % save set H2
    EEG1 = pop_saveset( EEG1, 'filename',[subs{si} '_H2_V.set'],'filepath',targetfolder); clear 'EEG1'
    
    % epoch the set, for MeH2 the hardware trigger = 60.
    EEG2 = pop_epoch( EEG, {  '30'  }, [-1  2],'epochinfo', 'yes');
    % modify tags on set 
    EEG2.subject  = subs{si};
    EEG2.condition= 'MH2_V' ;
    
    % remove epochs
    origTr = length(EEG2.epoch);
    EEG2 = epochRejStat(EEG2, 'avg', 3);
    EEG2 = epochRejStat(EEG2, 'kurtosis', 5);
    EEG2.badTrials.org = origTr;
    EEG2.badTrials.tot = length(EEG2.epoch);
    % save set MH2
    EEG2 = pop_saveset( EEG2, 'filename',[subs{si} '_MH2_V.set'],'filepath',targetfolder); clear 'EEG2'
end