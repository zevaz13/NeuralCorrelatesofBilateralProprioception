function [tf,frex] = timeFreqCohenAllChan(EEG,freqs, numFreq, cycles)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    
% start a timeFreq array for all channels
tf = zeros(EEG.nbchan,numFreq,EEG.pnts);
    for chi = 1:EEG.nbchan
        [tf(chi,:,:) frex] = timeFreqCohen(EEG, chi, freqs, numFreq, cycles);
    end
end

