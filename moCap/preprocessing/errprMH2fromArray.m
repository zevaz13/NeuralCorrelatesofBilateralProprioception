function [errorMH2] = errorMH2fromArray(path,remove,si)
%plotMH2fromArray plots trials and computes error array all from array 
%   Detailed explanation goes here
currentFolder = pwd;
cd(path);

load('trialMOCAP.mat')
% go to path


% loop for all elements 
numSets = length(H2set);
errorMH2 = 500*ones(1,numSets);
% create a figure
    for i = 1:numSets
        
        if sum(ismember(remove, i)) == 1
           
        else
        numSamples = 10;
        H2 = H2set(i);
        MH2 = MH2set(i);
        %% plot all trials mH2
        errorTrial = mean(H2{1}(1,length(H2{1})-numSamples:end)) - mean(MH2{1}(2,length(MH2{1})-numSamples:end));
        % for S11 NV tr1 errorTrial = mean(H2{1}(1,length(H2{1})-numSamples:end)) - mean(MH2{1}(2,length(MH2{1})-numSamples:end));
        errorMH2(i) = errorTrial;
        clear 'MH2' 'H2'
        end
        
    end
cd(currentFolder);
end

