function [tfout] = baselineNormCohenAllChan(EEG,tf,baselineTimes)
%baselineNormCohenAllChan performs decibel conversion for all channels
%   Detailed explanation goes here

    baseidx = reshape( dsearchn(EEG.times',baselineTimes(:)), [],2);
    tfout = zeros(size(tf));
    for chi =1:EEG.nbchan
        activity = squeeze(tf(chi,:,:));
        %baseline = mean( tf(:,baseidx(1):baseidx(2),chi) ,2);
        baseline = mean( tf(chi,:,baseidx(1):baseidx(2)) ,3); % for fieldtrip
        % decibel
        tfout(chi,:,:) = 10*log10( bsxfun(@rdivide, activity, baseline') );
    end

end

