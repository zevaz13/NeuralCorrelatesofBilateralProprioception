clear all
% load data 

load('ERSPfeatures.mat')
colorC = [0.4 0.7 0.9];
colorS = [0.9 0.4 0.4];
colorComb = [0.8 0.6 0.9];
limitsY = [-3 1];
%% features
task1 = 1;
task2 = 2;


contrlsFeat = cM1_onset_mu(group == 1,[task1 task2]) 
skilledFeat = cM1_onset_mu(group == 2,[task1 task2]) 

meanMU = [mean(contrlsFeat) mean(skilledFeat)];
stdMU = [std(contrlsFeat)./sqrt(size(contrlsFeat,1)) std(skilledFeat)./sqrt(size(skilledFeat,1))];

figure; 
h1 = bar(1,meanMU(1),'BarWidth', 1,'FaceColor','flat'); hold on
h2 = bar(2,meanMU(2),'BarWidth', 1,'FaceColor','flat'); hold on
h3 = bar(4,meanMU(3),'BarWidth', 1,'FaceColor','flat'); hold on
h4 = bar(5,meanMU(4),'BarWidth', 1,'FaceColor','flat'); hold on

xticks([1.5 4.5])
xticklabels({'Controls', 'Skilled'})
% bar colors
h1.CData = colorC;
h2.CData(1,:)= colorC;
h3.CData(1,:) = colorS;
h4.CData(1,:)= colorS;

%% error bars
hold on;
er1 = errorbar(1,meanMU(1),stdMU(1),'.','LineWidth',2);  % <--- If you want 1 errorbar object
er1.Color = [0 0 0];
er2 = errorbar(2,meanMU(2),stdMU(2),'.','LineWidth',2);  % <--- If you want 1 errorbar object
er2.Color = [0 0 0];
er3 = errorbar(4,meanMU(3),stdMU(3),'.','LineWidth',2);  % <--- If you want 1 errorbar object
er3.Color = [0 0 0]
er4 = errorbar(5,meanMU(4),stdMU(4),'.','LineWidth',2);  % <--- If you want 1 errorbar object
er4.Color = [0 0 0];



% hatching
hatchfill2(h2,'single','HatchAngle',45,'hatchcolor','k','HatchLineWidth',2,'HatchDensity',5,'HatchDensity',15);
hatchfill2(h4,'single','HatchAngle',45,'hatchcolor','k','HatchLineWidth',2,'HatchDensity',5,'HatchDensity',15);

% limits 
ylim(limitsY)

%% FIG 10
limitsY = [-3 1];
multPlotsPaperFlex(cM1_onset_mu,group,task1, task2, colorC, colorS, limitsY);
multPlotsPaperFlex(cM1_onset_lb,group,task1, task2, colorC, colorS, limitsY);
multPlotsPaperFlex(cM1_offset_mu,group,task1, task2, colorC, colorS, limitsY);
multPlotsPaperFlex(cM1_offset_lb,group,task1, task2, colorC, colorS, limitsY);

%% FIG 12
limitsY = [-1.5 1];
multPlotsPaperFlex(cM1_onset_mu,group,2, 3, colorC, colorS, limitsY);
multPlotsPaperFlex(cM1_onset_lb,group,2, 3, colorC, colorS, limitsY);
multPlotsPaperFlex(cM1_offset_mu,group,2, 3, colorC, colorS, limitsY);
multPlotsPaperFlex(cM1_offset_lb,group,2, 3, colorC, colorS, limitsY);

%% FIG 14
limitsY = [-1.5 1];
multPlotsPaperFlex(cM1_onset_mu,group,2, 4, colorC, colorS, limitsY);
multPlotsPaperFlex(cM1_onset_lb,group,2, 4, colorC, colorS, limitsY);
multPlotsPaperFlex(cM1_offset_mu,group,2, 4, colorC, colorS, limitsY);
multPlotsPaperFlex(cM1_offset_lb,group,2, 4, colorC, colorS, limitsY);
