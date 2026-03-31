function [tf, frex] = timeFreqCohen(EEG, chann, freqs, numFreq, cycles)
    %timeFreqCohen Performs timeFreq conversion using Wavelet convolution
    %   Detailed explanation goes here
    % frequency parameters
    min_freq =  freqs(1);
    max_freq = freqs(2);
    num_frex = numFreq;
    frex = linspace(min_freq,max_freq,num_frex);

    % which channel to plot

    % other wavelet parameters
    range_cycles = cycles;

    % notice: defining cycles as a vector for all frequencies
    s = logspace(log10(range_cycles(1)),log10(range_cycles(end)),num_frex) ./ (2*pi*frex);
    wavtime = -2:1/EEG.srate:2;
    half_wave = (length(wavtime)-1)/2;


    % FFT parameters
    nWave = length(wavtime);
    nData = EEG.pnts * EEG.trials;
    nConv = nWave + nData - 1;


    % now compute the FFT of all trials concatenated
    alldata = reshape( EEG.data(chann,:,:) ,1,[]);
    dataX   = fft( alldata ,nConv );


    % initialize output time-frequency data
    tf = zeros(length(frex),EEG.pnts);

    %% now perform convolution

    % loop over frequencies
    for fi=1:length(frex)

        % create wavelet and get its FFT
        wavelet  = exp(2*1i*pi*frex(fi).*wavtime) .* exp(-wavtime.^2./(2*s(fi)^2));
        waveletX = fft(wavelet,nConv);
        waveletX = waveletX ./ max(waveletX);

        % now run convolution in one step
        as = ifft(waveletX .* dataX);
        as = as(half_wave+1:end-half_wave);

        % and reshape back to time X trials
        as = reshape( as, EEG.pnts, EEG.trials );

        % compute power and average over trials
        tf(fi,:) = mean( abs(as).^2 ,2);
    end

end

