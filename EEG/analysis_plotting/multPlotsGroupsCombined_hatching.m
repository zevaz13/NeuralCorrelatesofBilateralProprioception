function [] = multPlotsGroupsCombined_hatching(muOn,muOff, lbOn, lbOff, colorComb,task1, task2,sigL,limY )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
titleSize = 16;
labSize = 14;

featmuon = muOn(:,[task1 task2]);
featmuoff = muOff(:,[task1 task2]);
featlbon = lbOn(:,[task1 task2]);
featlboff = lbOff(:,[task1 task2]);


meanMU = [mean(featmuon); mean(featmuoff)];
meanlb = [mean(featlbon); mean(featlboff)];

stdMU = [std(featmuon)./sqrt(size(featmuon,1)); std(featmuoff)./sqrt(size(featmuoff,1))];
stdLB = [std(featlbon)./sqrt(size(featlbon,1)); std(featlboff)./sqrt(size(featlboff,1))];

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
        hatchfill2(h(1),'single','HatchAngle',30,'hatchcolor','k','HatchLineWidth',2,'HatchDensity',12.5);
end

switch task2
    
    case 2
        hatchfill2(h(2),'single','HatchAngle',30,'hatchcolor','k','HatchLineWidth',2,'HatchDensity',12.5);
    case 3
        hatchfill2(h(2),'single','HatchAngle',30,'hatchcolor','k','HatchDensity',25);
    case 4
        hatchfill2(h(2),'single','HatchAngle',30,'hatchcolor','w','HatchLineWidth',2,'HatchDensity',12.5);
end

% sig lines 
if ~isempty(sigL)
    if sum(sigL == 1) == 1
        plot([xCnt(1) xCnt(3)], [1 1]*0.45, '-k','Linewidth', 2);  plot(mean([xCnt(1) xCnt(3)]), 0.5, '*k')
    end
    
    if sum(sigL == 2) == 1
        plot([xCnt(2) xCnt(4)], [1 1]*0.45, '-k','Linewidth', 2);  plot(mean([xCnt(2) xCnt(4)]), 0.5, '*k')
    end
end
% other
ylabel('Band power (dB)','FontSize',labSize);
xticklabels({'Onset', 'Offset'})
box('off')
title('\mu band','FontSize',titleSize);
ylim(limY)
xlim([0.5 2.5])

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
        hatchfill2(h(1),'single','HatchAngle',30,'hatchcolor','k','HatchLineWidth',2,'HatchDensity',12.5);
end

switch task2
    
    case 2
        hatchfill2(h(2),'single','HatchAngle',30,'hatchcolor','k','HatchLineWidth',2,'HatchDensity',12.5);
    case 3
        hatchfill2(h(2),'single','HatchAngle',30,'hatchcolor','k','HatchDensity',25);
    case 4
        hatchfill2(h(2),'single','HatchAngle',30,'hatchcolor','w','HatchLineWidth',2,'HatchDensity',12.5);
end

% sig lines 
if ~isempty(sigL)
    if sum(sigL == 3) == 1
        plot([xCnt(1) xCnt(3)], [1 1]*0.45, '-k','Linewidth', 2);  plot(mean([xCnt(1) xCnt(3)]), 0.5, '*k')
    end
    
    if sum(sigL == 4) == 1
        plot([xCnt(2) xCnt(4)], [1 1]*0.45, '-k','Linewidth', 2);  plot(mean([xCnt(2) xCnt(4)]), 0.5, '*k')
    end
end
% other
xticklabels({'Onset', 'Offset'})
box('off')
title('Low \beta band','FontSize',titleSize);
ylim(limY)
xlim([0.5 2.5])

end

