%% make EEG montage using EEGlab labels 

chanlocs = struct('labels', {'Fp1', 'Fp2','AF3', 'AF4', 'F7','F3','Fz','F4','F8',...
                        'FC5','FC1', 'FC2', 'FC6', 'T7', 'C3', 'Cz', 'C4', 'T8' ,...
                        'CP5', 'CP1', 'CP2', 'CP6', 'P7', 'P3', 'Pz','P4', 'P8' , ...
                        'PO3', 'PO4', 'O1', 'Oz', 'O2', 'A1', 'A2'});
pop_chanedit( chanlocs );

%% import data from temporal array
elec = hdr.elec;
save('C:\Users\rued7682\OneDrive - University of Idaho\proprioception\scripts\files\electsFT.mat','elec')

load('C:\Users\rued7682\OneDrive - University of Idaho\proprioception\scripts\files\electsFT.mat','elec')
cfg = [];
cfg.elec = elec;

                    
layout = ft_prepare_layout(cfg);
ft_layoutplot(cfg)
data = eeglab2fieldtrip(EEG)
hdr    = ft_read_header( 'D:\\testlay.set' ); 


cfg          = [];
cfg.elec = elec;
cfg.method   = 'triangulation';
cfg.feedback = 'yes'; % visualizes the neighbors

neighbors = ft_prepare_neighbours(cfg);
