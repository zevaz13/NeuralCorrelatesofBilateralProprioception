function [errorH2] = errorH2fromArray(path,remove,si)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
currentFolder = pwd;
cd(path);

load('trialMOCAP.mat')
% go to path

% loop for all elements 
numSets = length(H2set);
errorH2 = 500*ones(1,numSets);
    for i = 1:numSets
        
        if sum(ismember(remove, i)) == 1

        else
            
            numSamples = 10;
            H2 = H2set(i);
            MH2 = MH2set(i);
            %% plot all trials mH2
            if si ~= 11
                errorTrial = mean(H2{1}(1,length(H2{1})-numSamples:end)) - mean(H2{1}(2,length(H2{1})-numSamples:end));
            else
                if i < 12
                    errorTrial = mean(H2{1}(1,175:185)) - mean(H2{1}(2,175:185));
                else 
                    errorTrial = mean(H2{1}(1,length(H2{1})-numSamples:end)) - mean(H2{1}(2,length(H2{1})-numSamples:end));
                end
            end
            
            % for the S11 NV run one i = 1: errorTrial = mean(H2{1}(1,length(H2{1})-numSamples:end)) - mean(H2{1}(2,length(H2{1})-numSamples:end));
            
            errorH2(i) = errorTrial;
            
        clear 'MH2' 'H2'

        end
    end    
cd(currentFolder);
end

