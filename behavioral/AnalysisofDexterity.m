% This script evaluates differences in manual dexterity between non-musicians (controls)
% and skilled pianists, with a focus on both fine and gross motor performance.
%
% Two standardized behavioral assessments are used:
%   - 9-Hole Peg Test (9HPT): measures fine motor dexterity (completion time)
%   - Box and Blocks Test (B&B): measures gross motor dexterity (blocks moved per minute)
%
% The analysis is structured to address two key questions:
%   1. Do skilled individuals exhibit superior dexterity compared to controls?
%   2. Are there differences between dominant and non-dominant hand performance,
%      and do these differences depend on skill level?
%
% For each modality (9HPT and B&B), the script:
%   - Computes group-level summary statistics (mean ± SEM)
%   - Visualizes results across hands and groups
%   - Performs statistical comparisons:
%         • Between-group comparisons (rank-sum test)
%         • Within-subject hand comparisons (sign-rank test)
%
% This analysis provides a behavioral foundation for interpreting
% training-related adaptations in motor performance.

clear all;
load('dextData.mat')
subs = {'S01','S02','S03','S04','S05','S06','S07','S09','S10','S11','S12','S13','S14','S15','S17','S18','S19','S21','S23','S24'};
group = [1 1 1 2 1 2 1 1 2 2 2 1 1 1 2 2 1 1 2 2]; % groups

%% for 9HPT
%left hand 
meanNhPTCL = mean(NHPTLH(group == 1));
meanNhPTML = mean(NHPTLH(group == 2));

stdNHPTCL = std(NHPTLH(group ==1))/ sqrt(length(NHPTLH(group == 1)));
stdNHPTML = std(NHPTLH(group ==2))/ sqrt(length(NHPTLH(group == 2)));

% right hand
meanNhPTCR = mean(NHPTRH(group == 1));
meanNhPTMR = mean(NHPTRH(group == 2));

stdNHPTCR = std(NHPTRH(group ==1)) / sqrt(length(NHPTRH(group == 1)));
stdNHPTMR = std(NHPTRH(group ==2)) / sqrt(length(NHPTRH(group == 2)));

% H9HPT = [meanNhPTCR meanNhPTMR; meanNhPTCL meanNhPTML]
H9HPT = [meanNhPTCL meanNhPTML; meanNhPTCR meanNhPTMR ]

figure;

colorC = [0.4 0.7 0.9];
colorS = [0.9 0.4 0.4];

subplot(1,2,2)
h = bar(H9HPT,'BarWidth', 1);
ylabel('Completion time (sec)', 'FontSize', 14);
xticklabels({'Left hand', 'Right hand'});
title({'9-Hole Peg Test', '(fine dexterity)'},'fontsize', 14);

xCnt =  h(1).XData.' + [h.XOffset]; 
std9HPT = [stdNHPTCL stdNHPTML; stdNHPTCR stdNHPTMR ];
hold on;
er = errorbar(xCnt(:),H9HPT(:),std9HPT(:),'.','LineWidth',2)  % <--- If you want 1 errorbar object
er.Color = [0 0 0];
hold on

plot([xCnt(1) xCnt(2)], [1 1]*22, '-k','Linewidth', 2);  plot(mean([xCnt(1) xCnt(2)]), 22.6, '*k')
h(1).FaceColor = colorC;
h(2).FaceColor = colorS;
ylim([0 30])
yticks([0 10 20 30])
L = legend('controls', 'skilled', 'Orientation', 'horizontal','Location','northeast'); legend('boxoff');

box('off')
%% for B&B
%left hand 
meanBBLC = mean(BBLH(group == 1));
meanBBLM = mean(BBLH(group == 2));

stdBBLC = std(BBLH(group ==1))/ sqrt(length(BBLH(group == 1)));
stdBBLM = std(BBLH(group ==2))/ sqrt(length(BBLH(group == 2)));

% right hand
meanBBRC = mean(BBRH(group == 1));
meanBBRM = mean(BBRH(group == 2));

stdBBRC = std(BBRH(group ==1)) / sqrt(length(BBRH(group == 1)));
stdBBRM = std(BBRH(group ==2)) / sqrt(length(BBRH(group == 2)));


BB = [meanBBLC meanBBLM ;meanBBRC meanBBRM ];

subplot(1,2,1)
h = bar(BB,'BarWidth', 1);
xticklabels({'Left hand', 'Right hand'});
title({'Box and Blocks Test', '(gross dexterity)'},'fontsize', 14);

xCnt =  h(1).XData.' + [h.XOffset]; 
stdBB = [stdBBLC stdBBLM; stdBBRC stdBBRM  ];
hold on;
er = errorbar(xCnt(:),BB(:),stdBB(:),'.','LineWidth',2)  % <--- If you want 1 errorbar object
er.Color = [0 0 0];
h(1).FaceColor = colorC;
h(2).FaceColor = colorS;
ylabel('Blocks moved in 1 min', 'FontSize', 14);
ylim([0 85])
plot([xCnt(1) xCnt(2)], [1 1]*70, '-k','Linewidth', 2);  plot(mean([xCnt(1) xCnt(2)]), 72, '*k')
box('off')

%% perform comparisons 9HPT

%same hand group comparison 
p1 = ranksum(NHPTRH(group == 1),NHPTRH(group == 2)) % dominant hand 9HPT
p2 = ranksum(NHPTLH(group == 1),NHPTLH(group == 2)) % dominant hand 9HPT

% between hands comparison
p3 = signrank(NHPTRH(group == 1),NHPTLH(group == 1)) % dominant hand 9HPT
p4 = signrank(NHPTRH(group == 2),NHPTLH(group == 2)) % dominant hand 9HPT

%% perform comparisons B&B
%same hand group comparison 
p11 = ranksum(BBRH(group == 1),BBRH(group == 2)) % dominant hand 9HPT
p12 = ranksum(BBLH(group == 1),BBLH(group == 2)) % dominant hand 9HPT

% between hands comparison
p13 = signrank(BBRH(group == 1),BBLH(group == 1)) % dominant hand 9HPT
p14 = signrank(BBRH(group == 2),BBLH(group == 2)) % dominant hand 9HPT

