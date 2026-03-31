% share data with Disha 

clear all; 

% load EEG features 
path2use = 'D:\proprioceptionExperiment\spectralAnalysis_prop\tfDecomposition\';

% load the time freq data
load([path2use 'tf5Cond.mat']);
% load location info
load([path2use 'locInfo.mat']);

% define times of interest
mp = [0 200];
onset = [200 400];
offset= [400 800];

% define frequencies of interest
mu = [8 12];
lb = [12 18];
% define locations of interest

cM1 = {'C3', 'CP5', 'P3', 'CP1'};

cM1idx = findChannelIDs({chanlocs.labels}, cM1);


% group information
group = [1 1 1 2 1 2 1 1 2 2 2 1 1 1 2 2 1 1 2 2]; % groups

times = timeFrex{1}.times;
mpIdx = findTimesIdx(times, mp);
onsetIdx = findTimesIdx(times, onset);
offsetIdx = findTimesIdx(times, offset);

frex        = timeFrex{1}.frex;
muIdx       = findTimesIdx(frex, mu);
lbIdx       = findTimesIdx(frex, lb);

conditions2use = [1 2 3 4 5];

cM1_mp_mu = getFeaturesTFindices(timeFrex,conditions2use,cM1idx, muIdx, mpIdx);
cM1_mp_lb = getFeaturesTFindices(timeFrex,conditions2use,cM1idx, lbIdx, mpIdx);

cM1_onset_mu = getFeaturesTFindices(timeFrex,conditions2use,cM1idx, muIdx, onsetIdx);
cM1_onset_lb = getFeaturesTFindices(timeFrex,conditions2use,cM1idx, lbIdx, onsetIdx);

cM1_offset_mu = getFeaturesTFindices(timeFrex,conditions2use,cM1idx, muIdx, offsetIdx);
cM1_offset_lb = getFeaturesTFindices(timeFrex,conditions2use,cM1idx, lbIdx, offsetIdx);


save('C:\Users\rued7682\Desktop\figuresPropResults\ERSPfeatures_Disha.mat', 'group', 'cM1_mp_mu', 'cM1_mp_lb', 'cM1_onset_mu', 'cM1_onset_lb', 'cM1_offset_mu', 'cM1_offset_lb')