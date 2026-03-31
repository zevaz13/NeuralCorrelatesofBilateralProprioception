% this script is intented to get the time freq decomposition of all
% subjects for each condition

clear all;

% subjects to get data from
%subs = {'S01','S02','S03','S04','S05','S06','S07','S08','S09','S10','S11','S12','S13','S14','S15','S16','S17','S18','S19','S20','S21'};
subs = {'S01','S02','S03','S04','S05','S06','S07','S09','S10','S11','S12','S13','S14','S15','S17','S18','S19','S21','S23','S24'};

% time freq params
freqs = [2 30];
numFreq = 50;
cycles = [4 10];
baseline_windows = [ -600 -200];

% time trimming parameters
tiempos2plot = [-300 1200]; % to tream
tSampling    = 2;

% what are the conditions to be tested
cond1 = 'RH';
cond2 = 'H2';
cond3 = 'H2_V';
cond4 = 'MH2';
cond5 = 'MH2_V';

% names only to save in timeFrex cell array of strucs
condName3 = 'H2V';
condName5 = 'MH2V';
% path to save on 
path2save = 'D:\spectralAnalysis_prop\tfDecomposition\';

% start output array
timeFrex = {};
for si = 1:length(subs)
%     path = ['D:\comparison2RHpropExperiment\' subs{si} ];
    path = ['D:\spcDecomp\' subs{si} ];
    cd(path)
    % creating names so it is easy to control what is loaded into memory
    nameRH = [subs{si} '_' cond1 '.set'];
    nameH2 = [subs{si} '_' cond2 '.set'];
    nameH2V= [subs{si} '_' cond3 '.set'];
    nameMH2= [subs{si} '_' cond4 '.set'];
    nameMH2V= [subs{si} '_' cond5 '.set'];
    % load sets in the same structure
    EEG = pop_loadset('filename',{nameRH,nameH2,nameH2V,nameMH2,nameMH2V});

    % compute time Frex transformation 
    [tf, frex] = timeTransOWNbaseline(EEG,freqs, numFreq, cycles,baseline_windows) ;        

    % time triming and downsampling
    tiemposIDs = find(EEG(1).times >= tiempos2plot(1) & EEG(1).times <= tiempos2plot(2)); % trim corners
    tiemposIDs = tiemposIDs(1:tSampling:end); % time trimming
    times = EEG(1).times(tiemposIDs); % new time vector
    
    % trim the actual structure
    tfx = {};
    for i =1:length(tf)
        tfx{i} = tf{i}(:,:,tiemposIDs);
    end

    % make the output structure
    timeFrex{si}.subID  = subs{si};
    timeFrex{si}.tf     = tfx;
    timeFrex{si}.times  = times;
    timeFrex{si}.frex   = frex;
    timeFrex{si}.condOrder = [cond1 '_' cond2 '_' condName3 '_' cond4 '_' condName5];
    timeFrex{si}.dims   = 'chans_frex_time';
end

% save this set
save([path2save 'tf5Cond.mat'], 'timeFrex')

%%%%%%%% save the location information

chanlocs = EEG(1).chanlocs;
chanInfo = EEG(1).chaninfo;
save([path2save 'locInfo.mat'], 'chanlocs', 'chanInfo');