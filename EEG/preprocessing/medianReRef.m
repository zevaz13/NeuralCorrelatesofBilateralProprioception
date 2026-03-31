function [EEG] = medianReRef(EEG)
%medianReRef Re references EEG set to the median 
%   Detailed explanation goes here

%% re-referencing
    nChans = EEG.nbchan;
    reference = repmat(squeeze(median(EEG.data,1)),[nChans 1]);
    data = EEG.data - reference;
    EEG.data = data;

end

