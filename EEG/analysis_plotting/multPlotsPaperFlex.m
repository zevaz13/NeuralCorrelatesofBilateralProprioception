function [] = multPlotsPaperFlex(feat,group,task1, task2, colorC, colorS, LimitsY)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
featC = feat(group == 1,[task1 task2]) 
featS = feat(group == 2,[task1 task2]) 

meanMU = [mean(featC) mean(featS)];
stdMU = [std(featC)./sqrt(size(featC,1)) std(featS)./sqrt(size(featS,1))];

figure; 
h1 = bar(1,meanMU(1),'BarWidth', 1,'FaceColor','flat'); hold on
h2 = bar(2,meanMU(2),'BarWidth', 1,'FaceColor','flat'); hold on
h3 = bar(4,meanMU(3),'BarWidth', 1,'FaceColor','flat'); hold on
h4 = bar(5,meanMU(4),'BarWidth', 1,'FaceColor','flat'); hold on

xticks([])
yticks([LimitsY(1):1:LimitsY(2)])
box('off')
ax = gca;
ax.FontSize = 14;
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
switch task1
    case 1
        
    case 2
        hatchfill2(h1,'single','HatchAngle',30,'hatchcolor','k','HatchLineWidth',2,'HatchDensity',12.5);
        hatchfill2(h3,'single','HatchAngle',30,'hatchcolor','k','HatchLineWidth',2,'HatchDensity',12.5);
end
      
switch task2
    case 1
        
    case 2
        hatchfill2(h2,'single','HatchAngle',30,'hatchcolor','k','HatchLineWidth',2,'HatchDensity',12.5);
        hatchfill2(h4,'single','HatchAngle',30,'hatchcolor','k','HatchLineWidth',2,'HatchDensity',12.5);
    case 3
        hatchfill2(h2,'single','HatchAngle',30,'hatchcolor','k','HatchDensity',25);
        hatchfill2(h4,'single','HatchAngle',30,'hatchcolor','k','HatchDensity',25);
    case 4
        hatchfill2(h2,'single','HatchAngle',30,'hatchcolor','w','HatchLineWidth',2,'HatchDensity',12.5);
        hatchfill2(h4,'single','HatchAngle',30,'hatchcolor','w','HatchLineWidth',2,'HatchDensity',12.5);
end

% limits 
ylim(LimitsY)
xlim([0.2 5.8])
ylabel('Band power (dB)','Fontsize', 16);
end

