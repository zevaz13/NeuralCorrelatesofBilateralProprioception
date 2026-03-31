function [DICorr] = correctDIvis(stimulusPresenter,DI, SR)
%correctDI deals with the misplaced triggers
%   uses the stimulus Presetenter data (BCI stimulusCode) and the DI
%   triggers
    H2markers = find(stimulusPresenter == 10);
    MH2markers = find(stimulusPresenter == 11);

    DImarks = find(DI);
    
    numSamp = 1*SR; % a second in ssamples 
    inxEndH2 = H2markers(find(diff(H2markers) > numSamp));
    inxEndH2(end+1) = H2markers(end);
    inxEndMH2 = MH2markers(find(diff(MH2markers) > numSamp));
    inxEndMH2(end+1) = MH2markers(end);


    % with the end of each stimulus there, just look in the DI signal 250ms to
    % the future 512/4, if DI finds something, then look at what is, for H2,
    % this value should be 40, for MH2, this value should be 60.
    DICorr = DI;
    %DICorr = zeros(size(DI));
    numSamples = SR/2;
    for i = 1:length(inxEndH2)
        matchH2 = find(DI(inxEndH2(i):inxEndH2(i)+numSamples) == 20);
        if isempty(matchH2)
             wrongH2 = find(DI(inxEndH2(i):inxEndH2(i)+numSamples) == 30);
             indices2Correct = inxEndH2(i):inxEndH2(i)+numSamples;
             DICorr(indices2Correct(wrongH2)) = 20;
        end
    end

    for i = 1:length(inxEndMH2)
        matchMH2 = find(DI(inxEndMH2(i):inxEndMH2(i)+numSamples) == 30);
        if isempty(matchMH2)
             wrongMH2 = find(DI(inxEndMH2(i):inxEndMH2(i)+numSamples) == 20);
             indices2CorrectMH2 = inxEndMH2(i):inxEndMH2(i)+numSamples;
             DICorr(indices2CorrectMH2(wrongMH2)) = 30;
        end
    end

end

