function [tf, frex] = timeTransOWNbaseline(EEGtask,freqs, numFreq, cycles,baseline_windows)
%timeTrans Applies time freq transformation to various sets performing
%normalization to another baseline set
%   Detailed explanation goes here

    tf = {};
    for seti =1 :length(EEGtask)
            [tftaski, frex] = timeFreqCohenAllChan(EEGtask(seti),freqs, numFreq, cycles);
            tf{seti}= baselineNormCohenAllChan(EEGtask(seti),tftaski,baseline_windows);   
    end
    tf = tf';
end


