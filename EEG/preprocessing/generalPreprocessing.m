function [] = generalPreprocessing(path,targetPath,cond,debug)
%generalPreprocessing(path,targetPath,cond,debug) imports data for each
%subject and run of a given condition,imports them, pre-process them
%separately and saves them to a target file.
%   Detailed explanation goes here
    currentFolder = pwd;
    cd(path);


    fileList = dir('*.dat');
    
    for ri = 1:length(fileList)
        % look for all sets 
        fileName = fileList(ri).name;
        %% import data
        % open them using fieldtrip import tool, you give it the cell array of
        % names and it string the data together into the signal variable
        [ signal, states, parameters, total_samples, file_samples ] ...
              = load_bcidat( [path fileName]); 

        % Should import data into matlab. events should be of 2 kinds BCI events
        % and digital input events
        SR = parameters.SamplingRate.NumericValue;

        %% managing markers
        % get stimulus code from Paradigm presenter
        stimulusPresenter = states.StimulusCode;
        % get stimulus from digital inputs
        if strcmp(cond, 'NV')
            % NV
            DI = 40 *states.DigitalInput4 + 60*states.DigitalInput6;
            DIcorr = correctDI(stimulusPresenter, DI, SR);
        elseif strcmp(cond,'VIS')
            
            % visual
            DI = 20 *states.DigitalInput4 + 30*states.DigitalInput6;
%             DIcorr = correctDI(stimulusPresenter, DI, SR);
            DIcorr = correctDIvis(stimulusPresenter, DI, SR);

        elseif strcmp(cond, 'RH')
            % RH
            DI = 50 *states.DigitalInput4 + 50*states.DigitalInput6;
            DIcorr = DI;
        else
           error('condition not supported') 
        end
        
        % find when are the relater markers located
        
        %DIcorr = correctDIvis(stimulusPresenter, DI, SR);
        %% plotting
        % plot the non-corrected vs corrected versions of the markers. Spot
        % mistakes here
        if debug
            figure;
            subplot(3,1,1)
            plot(stimulusPresenter)
            hold on; 
            plot(DI); grid minor 
            title('original hardware triggering using teensy') 

            % for RH
            %DIcorr = DI;
            subplot(3,1,2)
            plot(stimulusPresenter)
            hold on; 
            plot(DIcorr); grid minor 
            title('corrected hardware triggering using teensy')
        end

        % make a signal with the information to load to EEGLAB

        signal = double(signal); % EEG data
        eventChan = double([stimulusPresenter DIcorr]);

        % add events as chnallens, the paradigm and the corrected DI markers
        signal = [signal eventChan]';

        %% import to EEGLAB

        % name of variable to link passed to ufnction as string with the same name
        % of the array variable 
        EEG = pop_importdata('dataformat','array','nbchan',0,'data',signal,'srate',SR,'pnts',0,'xmin',0);

        %% set the event channels as markers 
        EEG = pop_chanevent(EEG, [34 35] ,'edge','leading','edgelen',0);

        %% remove channel 33 (A2)
        EEG = pop_select( EEG, 'nochannel',33); % removes ref channel 

        %% resample
        %     %EEG = pop_resample(EEG, 100,0.8,0.4);
        EEG = pop_resample(EEG, 256);

        %% filter the signal
        EEG = pop_eegfiltnew(EEG, 'locutoff',0.5);

        %EEG = pop_eegfiltnew(EEG, 'locutoff',0.2,'hicutoff',50,'minphase',1);

        %% add location information
        EEG=pop_chanedit(EEG, 'lookup','C:\\Users\\rued7682\\Documents\\eeglab2020_0\\plugins\\dipfit\\standard_BESA\\standard-10-5-cap385.elp',...
            'load',{'C:\\Users\\rued7682\\OneDrive - University of Idaho\\proprioception\\scripts\\eegMontageFile\\eegMon32electrodesNOREF.ced',...
            'filetype','autodetect'});

        %% clean line to remove line noise 

        % Run cleanLineNoise (requires PREP Pipeline toolbox) The original CleanLine was replaced (04/25/2020).
        signal      = struct('data', EEG.data, 'srate', EEG.srate);
        lineNoiseIn = struct('lineNoiseMethod', 'clean', ...
                             'lineNoiseChannels', 1:EEG.nbchan,...
                             'Fs', EEG.srate, ...
                             'lineFrequencies',[60 120],...% [60 120],...
                             'p', 0.01, ...
                             'fScanBandWidth', 2, ...
                             'taperBandWidth', 2, ...
                             'taperWindowSize', 3, ...
                             'taperWindowStep', 1, ...
                             'tau', 100, ...
                             'pad', 2, ...
                             'fPassBand', [0 EEG.srate/2], ...
                             'maximumIterations', 10);
        [clnOutput, lineNoiseOut] = cleanLineNoise(signal, lineNoiseIn);
        EEG.data = clnOutput.data;

        %% clean_rawdata() to reject bad channels
%         orgEEG = EEG;
%         EEG = pop_clean_rawdata(EEG, 'FlatlineCriterion',5,'ChannelCriterion',0.8,'LineNoiseCriterion',4,'Highpass','off','BurstCriterion','off','WindowCriterion','off','BurstRejection','off','Distance','Euclidian');
% 
%         %% interpolate removed channels 
%         EEG = pop_interp(EEG, orgEEG.chanlocs, 'spherical');
        %% re - referencing to average or median 
        EEG = medianReRef(EEG);
        %EEG = pop_reref( EEG, []);

        %% adaptive reconstruction (ASR)
        EEG = pop_clean_rawdata(EEG, 'FlatlineCriterion','off','ChannelCriterion','off','LineNoiseCriterion',...
            'off','Highpass','off','BurstCriterion',20,'WindowCriterion','off','BurstRejection','off','Distance','Euclidian');
        %% re - referencing to average or median 
        EEG = medianReRef(EEG);
        %EEG = pop_reref( EEG, []);
        EEG = pop_editset(EEG,'setname',fileName(1:end-4));

        %% save datasets separated
        EEG = pop_saveset( EEG, 'filename',[fileName(1:end-4) '.set'],'filepath',targetPath);

       clear 'EEG' 
    end
    cd(currentFolder);
end

