clear all; 

% where is the data
subs = {'S01','S02','S03','S04','S05','S06','S07','S09','S10'...
'S11', 'S12','S13','S14','S15', 'S17','S18','S19','S21','S23','S24'};
coordinateTransformParameters = [0.68403 -17.0438 0.14956 1.3757e-07 1.0376e-08 -1.5708 1 1 1];
templateChannelFilePath = 'C:\Users\rued7682\Documents\eeglab2020_0\plugins\dipfit\standard_BEM\elec\standard_1005.elc';
hdmFilePath             = 'C:\Users\rued7682\Documents\eeglab2020_0\plugins\dipfit\standard_BEMstandard_vol.mat';

interp = 1;
for si = 2:length(subs)
    if interp
    % no visual
        path = ['D:\AMICAtest\prePropData\' subs{si} '\noVis\'];
        targetPath = ['D:\AMICAtest\results2\' subs{si} '\'];
    else
        path = ['D:\AMICAtest\noInterpolation\preProcessed\' subs{si} '\noVis\'];  
        targetPath = ['D:\AMICAtest\noInterpolation\ICA\' subs{si} '\'];
    end
    mkdir(targetPath);
    fileName = [subs{si} '_NV.set'];

    cd(path);
    EEG = pop_loadset(fileName);
    dataRank = sum(eig(cov(double(EEG.data'))) > 1E-6); % 1E-6 follows pop_runica() line 531, changed from 1E-7.

    pcaVal = min(20,dataRank-1);
[weights, sphere,mods] = runamica15(EEG.data, 'num_chans', EEG.nbchan,...
    'pcakeep', pcaVal, 'num_models', 1,...
    'do_reject', 1, 'numrej', 15, 'rejsig', 3, 'rejint', 1);

    EEG.etc.amica  = mods;
    EEG.etc.amica.S = EEG.etc.amica.S(1:EEG.etc.amica.num_pcs, :); % Weirdly, I saw size(S,1) be larger than rank. This process does not hurt anyway.
    EEG.icaweights = EEG.etc.amica.W;
    EEG.icasphere  = EEG.etc.amica.S;
    EEG = eeg_checkset(EEG, 'ica');
    
    EEG = pop_editset(EEG,'setname',fileName(1:end-4));
    
    %% find the dipoles
    EEG = pop_dipfit_settings( EEG, 'hdmfile', hdmFilePath, 'coordformat', 'MNI',...
    'mrifile', '[EEGLABroot]/eeglab/plugins/dipfit2.3/standard_BEM/standard_mri.mat',...
    'chanfile', templateChannelFilePath, 'coord_transform', coordinateTransformParameters,...
    'chansel', 1:EEG.nbchan);

    EEG = pop_multifit(EEG, 1:EEG.nbchan,'threshold', 100, 'dipplot','off','plotopt',{'normlen' 'on'});

    % Step 12: Search for and estimate symmetrically constrained bilateral dipoles
    EEG = fitTwoDipoles(EEG, 'LRR', 35);


    %% save datasets separated
    EEG = pop_saveset( EEG, 'filename',[fileName(1:end-4) '.set'],'filepath',targetPath);

   clear 'EEG' 

end
