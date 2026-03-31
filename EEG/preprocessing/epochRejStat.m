function [OUTEEG, badTrials] = epochRejStat(EEG,type,numStd2plot)
%UNTITLED18 Summary of this function goes here
%   Detailed explanation goes here
    numChan = EEG.nbchan;
    numTrials = EEG.trials;
    % type of analysis 
    switch type
        case 'avg'
            statsTrials = squeeze(mean(EEG.data,2));
            disp(1)
        case 'kurtosis'
            statsTrials = squeeze(kurtosis(EEG.data,1,2));
            disp(2)
        case 'skewness'
            statsTrials = squeeze(skewness(EEG.data,1,2));
            disp(3)
        case 'variance'
            statsTrials = squeeze(var(EEG.data,0,2));
            disp(4)
        case 'all'
            statsTrials = squeeze(mean(EEG.data,3))
    end

    % get descriptors of the channel trial distribution
    meanStats = mean(statsTrials,2);
    stdStats = std(statsTrials,0,2);
    
    %% remove trials 
    % flag bad Trials based on statistics and number of standadr deviation
    % away from center of distribution 
    rightAllchann = meanStats+numStd2plot*stdStats;
    leftAllchann = meanStats-numStd2plot*stdStats;
    XX = statsTrials > rightAllchann;
    YY = statsTrials < leftAllchann;
    ZZ = XX|YY; % this is a mask of chan_trial to remove
    sum(ZZ,2) % number of removed trials for each channel 
    trials = {};

    [channel,trial] = find(ZZ); % coordinate channel trial

    % if the bad trial spans on multiple channels, remove it. 

    badTrialsTmp = unique(trial); % unique numbers of trials tro reject
    numChans2Check = 3;
    badTrials = [];
    cntBad = 1;
    for bi = 1:length(badTrialsTmp)
        if length(find(trial == badTrialsTmp(bi)))  > numChans2Check
            badTrials(cntBad) = badTrialsTmp(bi);
            cntBad = cntBad+1;
        end
    end
    % actually remove trials using the eeglab function for it
    EEG = pop_rejepoch( EEG, badTrials ,0);
    % keep track of the rejected trials (number or vector),maybe even the
    
    
    % check for the badTrials structure
    
    if ~isfield(EEG, 'badTrials')
        EEG.badTrials = [];
    end
    % type of trials rejected
    if isfield(EEG.badTrials, (type))
        EEG.badTrials.(type) = [EEG.badTrials.(type) length(badTrials)];
        EEG.badTrials.([type 'thr'])  = [EEG.badTrials.([type 'thr']) numStd2plot];
    else
        EEG.badTrials.(type) = length(badTrials);
        EEG.badTrials.([type 'thr']) = numStd2plot;
    end
  
    
    OUTEEG = EEG;
end

% 
% % try eeglab methods 
% pop_eegthresh(EEG,1:32,-100,100)
% badTrials
% %     EEG = pop_rejkurt(EEG,1,1:EEG.nbchan,7,7,0,0,0,[],0); 
% %     EEG = pop_jointprob(EEG,1,1:EEG.nbchan,5 , 5,0,0,0,[],0);
% %     EEG.reject.rejmanual = EEG.reject.rejjp | EEG.reject.rejkurt 
% 
% pop_jointprob(EEG)