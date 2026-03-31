%% produce figures for error analysis using bar plots instead of box plots and with the right colors
clear all

load('groups.mat')
% load moCap
load('medAbsAllconditions.mat')

colorC = [0.4 0.7 0.9];
colorS = [0.9 0.4 0.4];

combSetC = [medabsH2(group==1)  medabsMH2(group==1)];
combSetS = [medabsH2(group==2)  medabsMH2(group==2)];

combErrs = [median(combSetC) ;median(combSetS)];
combStd  =  [std(combSetC)/sqrt(length(combSetC)) ;std(combSetS)/sqrt(length(combSetS))];
figure
subplot(1,3,1)
h = bar(combErrs,'BarWidth', 1,'FaceColor','flat');
xticklabels({'Controls', 'Skilled'});
xCnt =  h(1).XData.' + [h.XOffset]; 
hold on;
er = errorbar(xCnt(:),combErrs(:),combStd(:),'.','LineWidth',2) ; % <--- If you want 1 errorbar object
er.Color = [0 0 0];
hold on

% significance line
plot([xCnt(1) xCnt(2)], [1 1]*37, '-k','Linewidth', 2);  plot(mean([xCnt(1) xCnt(2)]), 38, '*k');

h.CData(1,:) = colorC;
h.CData(2,:)= colorS;
ylim([0 45])
box('off')
title('BDM & UDR','fontsize', 14)
ylabel('Proprioceptive error (mm)','fontsize', 14)
%% bar for BDM
combErrs = [median(medabsH2(group==1)) ;median(medabsH2(group==2))];
combStd  =  [std(medabsH2(group==1))/sqrt(length(medabsH2(group==1)))...
                ;std(medabsH2(group==2))/sqrt(length(medabsH2(group==2)))];
subplot(1,3,2)
h = bar(combErrs,'BarWidth', 1,'FaceColor','flat');
xticklabels({'Controls', 'Skilled'});

xCnt =  h(1).XData.' + [h.XOffset]; 
hold on;
er = errorbar(xCnt(:),combErrs(:),combStd(:),'.','LineWidth',2) ; % <--- If you want 1 errorbar object
er.Color = [0 0 0];
hold on

% significance line
plot([xCnt(1) xCnt(2)], [1 1]*37, ':k','Linewidth', 2);  plot(mean([xCnt(1) xCnt(2)]), 38, '*k');

h.CData(1,:) = colorC;
h.CData(2,:)= colorS;
ylim([0 45])
hatchfill2(h,'single','HatchAngle',30,'hatchcolor','k','HatchLineWidth',2,'HatchDensity',12.5);

box('off')
title('BDM','fontsize', 14)

%% for UDR

combErrs = [median(medabsMH2(group==1)) ;median(medabsMH2(group==2))];
           
combStd  =  [std(medabsMH2(group==1))/sqrt(length(medabsMH2(group==1)))...
                ;std(medabsMH2(group==2))/sqrt(length(medabsMH2(group==2)))];
subplot(1,3,3)
h = bar(combErrs,'BarWidth', 1,'FaceColor','flat');
xticklabels({'Controls', 'Skilled'});

xCnt =  h(1).XData.' + [h.XOffset]; 
hold on;
er = errorbar(xCnt(:),combErrs(:),combStd(:),'.','LineWidth',2);  % <--- If you want 1 errorbar object
er.Color = [0 0 0];
hold on

% significance line
plot([xCnt(1) xCnt(2)], [1 1]*37, '-k','Linewidth', 2);  plot(mean([xCnt(1) xCnt(2)]), 38, '*k');

h.CData(1,:) = colorC;
h.CData(2,:)= colorS;
hatchfill2(h,'single','HatchAngle',30,'hatchcolor','w','HatchLineWidth',2,'HatchDensity',12.5);

ylim([0 45])
box('off')
% title('Replication error, UDR','fontsize', 14)
title('UDR','fontsize', 14)

%% for between groups with and without visibility of target

BDMC = medabsH2(group == 1);
BDMVC = medabsH2V(group == 1);

BDMS = medabsH2(group == 2);
BDMVS = medabsH2V(group == 2);
% errors
eBDMC = std(BDMC)/sqrt(length(BDMC));
eBDMVC = std(BDMVC)/sqrt(length(BDMVC));
eBDMS = std(BDMS)/sqrt(length(BDMS));
eBDMVS = std(BDMVS)/sqrt(length(BDMVS));


figure;
h1 = bar(1,mean(BDMC),'BarWidth', 1,'FaceColor','flat');hold on;
h2 = bar(2,mean(BDMVC),'BarWidth', 1,'FaceColor','flat');hold on;
h3 = bar(4,mean(BDMS),'BarWidth', 1,'FaceColor','flat');hold on;
h4 = bar(5,mean(BDMVS),'BarWidth', 1,'FaceColor','flat');hold on;

xticks([1.5 4.5])
xticklabels({'Controls', 'Skilled'})


ylim([0 27])
box('off')
% error bars
hold on;
er1 = errorbar(1,mean(BDMC),eBDMC,'.','LineWidth',2);  % <--- If you want 1 errorbar object
er1.Color = [0 0 0];
er2 = errorbar(2,mean(BDMVC),eBDMVC,'.','LineWidth',2);  % <--- If you want 1 errorbar object
er2.Color = [0 0 0];
er3 = errorbar(4,mean(BDMS),eBDMS,'.','LineWidth',2);  % <--- If you want 1 errorbar object
er3.Color = [0 0 0];
er4 = errorbar(5,mean(BDMVS),eBDMVS,'.','LineWidth',2);  % <--- If you want 1 errorbar object
er4.Color = [0 0 0];

% sig lines
% significance line
plot([1 2], [1 1]*25, '-k','Linewidth', 2);  plot(mean([1 2]), 25.6, '*k')

%% Add color to the lines and then hatch them
h1.CData(1,:) = colorC;
h2.CData(1,:)= colorC;
h3.CData(1,:) = colorS;
h4.CData(1,:)= colorS;

hatchfill2(h1,'single','HatchAngle',30,'hatchcolor','k','HatchLineWidth',2,'HatchDensity',12.5);
hatchfill2(h2,'single','HatchAngle',30,'hatchcolor','k','HatchDensity',25);

hatchfill2(h3,'single','HatchAngle',30,'hatchcolor','k','HatchLineWidth',2,'HatchDensity',12.5);
hatchfill2(h4,'single','HatchAngle',30,'hatchcolor','k','HatchDensity',25);

ylabel('Proprioceeptive Error (mm)', 'FontSize', 14)

%% hgetting the legend 

figure;
h1 = bar(1,mean(BDMC),'BarWidth', 1,'FaceColor','flat');hold on;
h2 = bar(2,mean(BDMVC),'BarWidth', 1,'FaceColor','flat');hold on;
h3 = bar(4,mean(BDMS),'BarWidth', 1,'FaceColor','flat');hold on;
h4 = bar(5,mean(BDMVS),'BarWidth', 1,'FaceColor','flat');hold on;

xticks([1.5 4.5])
xticklabels({'Controls', 'Skilled'})


ylim([0 27])
box('off')
% error bars
hold on;
er1 = errorbar(1,mean(BDMC),eBDMC,'.','LineWidth',2)  % <--- If you want 1 errorbar object
er1.Color = [0 0 0];
er2 = errorbar(2,mean(BDMVC),eBDMVC,'.','LineWidth',2)  % <--- If you want 1 errorbar object
er2.Color = [0 0 0];
er3 = errorbar(4,mean(BDMS),eBDMS,'.','LineWidth',2)  % <--- If you want 1 errorbar object
er3.Color = [0 0 0]
er4 = errorbar(5,mean(BDMVS),eBDMVS,'.','LineWidth',2)  % <--- If you want 1 errorbar object
er4.Color = [0 0 0];

% sig lines
% significance line
plot([1 2], [1 1]*25, '-k','Linewidth', 2);  plot(mean([1 2]), 25.6, '*k')

h1.CData(1,:) = colorC;
h2.CData(1,:)= colorS;
h3.CData(1,:) = colorC;
h4.CData(1,:)= colorS;

hatchfill2(h1,'single','HatchAngle',30,'hatchcolor','k','HatchLineWidth',2,'HatchDensity',12.5);
hatchfill2(h2,'single','HatchAngle',30,'hatchcolor','k','HatchLineWidth',2,'HatchDensity',12.5);

hatchfill2(h3,'single','HatchAngle',30,'hatchcolor','k','HatchDensity',25);
hatchfill2(h4,'single','HatchAngle',30,'hatchcolor','k','HatchDensity',25);

%% New Fig 7

colorC = [0.4 0.7 0.9]; %[0.04 0.54 0.87];
colorS = [0.9 0.4 0.4];%[0.81 0.22 0.12];

combSetC = [medabsH2(group==1)  medabsMH2(group==1)];
combSetS = [medabsH2(group==2)  medabsMH2(group==2)];

combErrs = [median(combSetC) ;median(combSetS)];
combStd  =  [std(combSetC)/sqrt(length(combSetC)) ;std(combSetS)/sqrt(length(combSetS))];
figure
% subplot(1,3,1)
h = bar(combErrs,'BarWidth', 1,'FaceColor','flat');
xticklabels({'Controls', 'Skilled'});
% ylabel('Time to complete test (sec)', 'FontSize', 14);
% title({'9-Hole Peg Test', '(fine dexterity)'},'fontsize', 14);

xCnt =  h(1).XData.' + [h.XOffset]; 
hold on;
er = errorbar(xCnt(:),combErrs(:),combStd(:),'.','LineWidth',2)  % <--- If you want 1 errorbar object
er.Color = [0 0 0];
hold on

% significance line
plot([xCnt(1) xCnt(2)], [1 1]*36, '-k','Linewidth', 2);  plot(mean([xCnt(1) xCnt(2)]), 37, '*k')


h.CData(1,:) = colorC;
h.CData(2,:)= colorS;
yticks([0 5 15 25 35 45])
ylim([0 47])
xlim([0.2 2.8])
box('off')
% title('Combined BDM and UDR','fontsize', 14)
% title('BDM & UDR','fontsize', 14)
ylabel('Proprioceptive error (mm)','fontsize', 14)


figure;
% bar for BDM
combErrs = [mean(medabsH2(group==1)) ;mean(medabsH2(group==2))];
combStd  =  [std(medabsH2(group==1))/sqrt(length(medabsH2(group==1))) std(medabsMH2(group==1))/sqrt(length(medabsMH2(group==1)))...
                ;std(medabsH2(group==2))/sqrt(length(medabsH2(group==2))) std(medabsH2(group==2))/sqrt(length(medabsMH2(group==2)))...
                ];
h1 = bar(1,mean(medabsH2(group==1)),'BarWidth', 1,'FaceColor','flat'); hold on;
h2 = bar(2,mean(medabsMH2(group==1)),'BarWidth', 1,'FaceColor','flat'); hold on;
h3 = bar(4,mean(medabsH2(group==2)),'BarWidth', 1,'FaceColor','flat'); hold on;
h4 = bar(5,mean(medabsMH2(group==2)),'BarWidth', 1,'FaceColor','flat'); hold on;

xlim([0.2 5.7])
xticks([1.5 4.5])
xticklabels({'Controls', 'Skilled'}); hold on

er = errorbar(1,mean(medabsH2(group==1)),combStd(1,1),'.','LineWidth',2); er.Color = [0 0 0];hold on
er = errorbar(2,mean(medabsMH2(group==1)),combStd(1,2),'.','LineWidth',2); er.Color = [0 0 0];hold on
er = errorbar(4,mean(medabsH2(group==2)),combStd(2,1),'.','LineWidth',2); er.Color = [0 0 0];hold on
er = errorbar(5,mean(medabsMH2(group==2)),combStd(2,2),'.','LineWidth',2); er.Color = [0 0 0];hold on

% significance line
plot([1 2], [1 1]*36, '-k','Linewidth', 2);  plot(mean([1 2]), 37, '*k')
plot([4 5], [1 1]*36, '-k','Linewidth', 2);  plot(mean([4 5]), 37, '*k')

plot([1 4], [1 1]*40, ':k','Linewidth', 2);  plot(mean([1 4]), 41, '*k')
plot([2 5], [1 1]*44, '-k','Linewidth', 2);  plot(mean([2 5]), 45, '*k')


h1.CData = colorC; h2.CData = colorC;
h3.CData = colorS; h4.CData = colorS;

hatchfill2(h1,'single','HatchAngle',30,'hatchcolor','k','HatchLineWidth',2,'HatchDensity',12.5);
hatchfill2(h2,'single','HatchAngle',30,'hatchcolor','w','HatchLineWidth',2,'HatchDensity',12.5);
hatchfill2(h3,'single','HatchAngle',30,'hatchcolor','k','HatchLineWidth',2,'HatchDensity',12.5);
hatchfill2(h4,'single','HatchAngle',30,'hatchcolor','w','HatchLineWidth',2,'HatchDensity',12.5);

yticks([0 5 15 25 35 45])
box('off')
ylim([0 47])
ylabel('Proprioceptive error (mm)')
% title('Matching error, BDM','fontsize', 14)
% title('BDM','fontsize', 14)
%% find the p values

% significance test 
[p2 h2]= signrank(medabsMH2(group == 1), medabsH2(group == 1),'tail','right');
[p3 h3]= signrank(medabsMH2(group == 2),medabsH2(group == 2),'tail','right');


[p,h] = ranksum(medabsH2(group == 1),medabsH2(group == 2),'tail','right');
[p1,h1] = ranksum(medabsMH2(group == 1),medabsMH2(group == 2),'tail','right');
