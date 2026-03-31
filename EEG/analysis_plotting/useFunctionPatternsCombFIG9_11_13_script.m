clear all
% load data 

load('ERSPfeatures.mat')

colorC = [0.4 0.7 0.9]; %[0.04 0.54 0.87];
colorS = [0.9 0.4 0.4];%[0.81 0.22 0.12];
colorComb = [0.8 0.6 0.9];


titleSize = 16;
labSize = 14;
task1 = 1;
task2 = 2;

Featonmu = cM1_onset_mu(:,[task1 task2]) ;
Featoffmu = cM1_offset_mu(:,[task1 task2]); 
Featonlb = cM1_onset_mu(:,[task1 task2]) ;
Featofflb = cM1_offset_mu(:,[task1 task2]); 

meanMU = [mean(Featonmu); mean(Featoffmu)];
meanlb = [mean(Featonlb); mean(Featofflb)];

stdMU = [std(Featonmu)./sqrt(size(Featonmu,1)); std(Featoffmu)./sqrt(size(Featoffmu,1))];
stdLB = [std(Featonlb)./sqrt(size(Featonlb,1)); std(Featofflb)./sqrt(size(Featofflb,1))];

figure;
subplot(1,2,1)
h = bar(meanMU,'BarWidth', 1)
h(1).FaceColor = colorComb;
h(2).FaceColor = colorComb;
% error bars
xCnt =  h(1).XData.' + [h.XOffset]; 
hold on;
er = errorbar(xCnt(:),meanMU(:),stdMU(:),'.','LineWidth',2)  % <--- If you want 1 errorbar object
er.Color = [0 0 0];

% hatching 
switch task1
    
    case 1
        
    case 2
        hatchfill2(h(1),'single','HatchAngle',45,'hatchcolor','k','HatchLineWidth',2,'HatchDensity',5,'HatchDensity',15);
end

switch task2
    
    case 2
        hatchfill2(h(2),'single','HatchAngle',45,'hatchcolor','k','HatchLineWidth',2,'HatchDensity',5,'HatchDensity',15);
    case 3
        hatchfill2(h(2),'single','HatchAngle',45,'hatchcolor','k','HatchDensity',100);
    case 4
        hatchfill2(h(2),'single','HatchAngle',135,'hatchcolor','w','HatchLineWidth',2,'HatchDensity',5,'HatchDensity',15);
end

% sig lines 
sigL = [1 2 3 4];
if ~isempty(sigL)
    if sum(sigL == 1) == 1
        plot([xCnt(1) xCnt(3)], [1 1]*0.5, '-k','Linewidth', 2);  plot(mean([xCnt(1) xCnt(3)]), 0.6, '*k')
    end
    
    if sum(sigL == 2) == 1
        plot([xCnt(2) xCnt(4)], [1 1]*0.5, '-k','Linewidth', 2);  plot(mean([xCnt(2) xCnt(4)]), 0.6, '*k')
    end
end
% other
ylabel('Band power (dB)','FontSize',labSize);
xticklabels({'Onset', 'Offset'})
box('off')
title('\mu band','FontSize',titleSize);
ylim([-2.5 1])

%% low beta

subplot(1,2,2)

h = bar(meanlb,'BarWidth', 1)
h(1).FaceColor = colorComb;
h(2).FaceColor = colorComb;
% error bars
xCnt =  h(1).XData.' + [h.XOffset]; 
hold on;
er = errorbar(xCnt(:),meanlb(:),stdLB(:),'.','LineWidth',2)  % <--- If you want 1 errorbar object
er.Color = [0 0 0];

% hatching 
switch task1
    
    case 1
        
    case 2
        hatchfill2(h(1),'single','HatchAngle',45,'hatchcolor','k','HatchLineWidth',2,'HatchDensity',5,'HatchDensity',15);
end

switch task2
    
    case 2
        hatchfill2(h(2),'single','HatchAngle',45,'hatchcolor','k','HatchLineWidth',2,'HatchDensity',5,'HatchDensity',15);
    case 3
        hatchfill2(h(2),'single','HatchAngle',45,'hatchcolor','k','HatchDensity',100);
    case 4
        hatchfill2(h(2),'single','HatchAngle',135,'hatchcolor','w','HatchLineWidth',2,'HatchDensity',5,'HatchDensity',15);
end

% sig lines 
if ~isempty(sigL)
    if sum(sigL == 3) == 1
        plot([xCnt(1) xCnt(3)], [1 1]*0.5, '-k','Linewidth', 2);  plot(mean([xCnt(1) xCnt(3)]), 0.6, '*k')
    end
    
    if sum(sigL == 4) == 1
        plot([xCnt(2) xCnt(4)], [1 1]*0.5, '-k','Linewidth', 2);  plot(mean([xCnt(2) xCnt(4)]), 0.6, '*k')
    end
end
% other
xticklabels({'Onset', 'Offset'})
box('off')
title('Low \beta band','FontSize',titleSize);
ylim([-2.5 1])

%% use the function

% fig 9
limY = [-2.5 1];
multPlotsGroupsCombined_hatching(cM1_onset_mu,cM1_offset_mu,cM1_onset_lb,cM1_offset_lb,...
    colorComb, 1,2,[1 2 3 4],limY)
% fig 11

limY = [-1 0.7];
multPlotsGroupsCombined_hatching(cM1_onset_mu,cM1_offset_mu,cM1_onset_lb,cM1_offset_lb,...
    colorComb, 2,4,[3 4],limY)


limY = [-1 0.7];
multPlotsGroupsCombined_hatching(cM1_onset_mu,cM1_offset_mu,cM1_onset_lb,cM1_offset_lb,...
    colorComb, 2,3,[3 4],limY)
