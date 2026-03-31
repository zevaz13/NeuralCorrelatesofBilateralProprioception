% repeat analysis for median of absolute errors
clear all
load('dextData.mat')
load('medAbsAllconditions.mat')
load('groups.mat')
% H2 median errors vs B&B Rh
[RHO1,PVAL1] = corr(medabsH2',BBRH,'Type','Spearman');
% H2 median errors vs 9HPT Rh
[RHO2,PVAL2] = corr(medabsH2',NHPTRH,'Type','Spearman');


% H2V median errors vs B&B Rh
[RHO5,PVAL5] = corr(medabsH2V',BBRH,'Type','Spearman');

% H2V median errors vs 9HPT Rh
[RHO6,PVAL] = corr(medabsH2V',NHPTRH,'Type','Spearman');

% MH2 median errors vs B&B Rh
[RHO3,PVAL3] = corr(medabsMH2',BBRH,'Type','Spearman');

% MH2 median errors vs 9HPT Rh
[RHO4,PVAL4] = corr(medabsMH2',NHPTRH,'Type','Spearman');
%% separing into groups

% H2 median errors vs B&B Rh
[RHO11,PVAL11] = corr(medabsH2(group==1)',BBRH(group==1),'Type','Spearman');

% H2 median errors vs 9HPT Rh
[RHO12,PVAL12] = corr(medabsH2(group==1)',NHPTRH(group==1),'Type','Spearman');
% MH2 median errors vs B&B Rh
[RHO13,PVAL13] = corr(medabsMH2(group==1)',BBRH(group==1),'Type','Spearman');

% MH2 median errors vs 9HPT Rh
[RHO14,PVAL14] = corr(medabsMH2(group==1)',NHPTRH(group==1),'Type','Spearman');

% H2V median errors vs B&B Rh
[RHO15,PVAL15] = corr(medabsH2V(group==1)',BBRH(group==1),'Type','Spearman');

% H2V median errors vs 9HPT Rh
[RHO16,PVAL16] = corr(medabsH2V(group==1)',NHPTRH(group==1),'Type','Spearman');


[RHO18,PVAL18] = corr(medabsMH2V(group==1)',NHPTRH(group==1),'Type','Spearman');

%% skilled
% H2 median errors vs B&B Rh
[RHO21,PVAL21] = corr(medabsH2(group==2)',BBRH(group==2),'Type','Spearman');

% H2 median errors vs 9HPT Rh
[RHO22,PVAL22] = corr(medabsH2(group==2)',NHPTRH(group==2),'Type','Spearman');
% MH2 median errors vs B&B Rh
[RHO23,PVAL23] = corr(medabsMH2(group==2)',BBRH(group==2),'Type','Spearman');

%% combined plotting 

% MH2 median errors vs 9HPT Rh
[RHO24,PVAL24] = corr(medabsMH2(group==2)',NHPTRH(group==2),'Type','Spearman');

% H2V median errors vs B&B Rh
[RHO25,PVAL25] = corr(medabsH2V(group==2)',BBRH(group==2),'Type','Spearman');

% H2V median errors vs 9HPT Rh
[RHO26,PVAL26] = corr(medabsH2V(group==2)',NHPTRH(group==2),'Type','Spearman');


%% combined plotting 
% first plot controls with their tendency line 

p = polyfit(medabsH2(group==1)',NHPTRH(group==1), 1);   % linear fit
f1H2 = polyval(p, medabsH2(group==1)');   % fitted values

p = polyfit(medabsH2V(group==1)',NHPTRH(group==1), 1);   % linear fit
f1H2V = polyval(p, medabsH2V(group==1)');   % fitted values

p = polyfit(medabsH2(group==2)',NHPTRH(group==2), 1);   % linear fit
f2H2 = polyval(p, medabsH2(group==2)');   % fitted values

p = polyfit(medabsH2V(group==2)',NHPTRH(group==2), 1);   % linear fit
f2H2V = polyval(p, medabsH2V(group==2)');   % fitted values

p = polyfit(medabsMH2(group==1)',NHPTRH(group==1), 1);   % linear fit
f1MH2 = polyval(p, medabsMH2(group==1)');   % fitted values

p = polyfit(medabsMH2(group==2)',NHPTRH(group==2), 1);   % linear fit
f2MH2 = polyval(p, medabsMH2(group==2)');   % fitted values

%%
% panel H2
marSize = 8;
titleSize = 16;
labSize = 14;
legSize = 14;
figure;
subplot(1,2,1)
plot(medabsH2(group==1)',NHPTRH(group==1),'bo','MarkerSize',marSize);
hold on; 
plot(medabsH2(group==2)',NHPTRH(group==2),'r^','MarkerSize',marSize);
plot(medabsH2(group==1)',f1H2,'b'); plot(medabsH2(group==2)',f2H2,'r');
xlabel({'abs median error' 'BJPM (mm)'}, 'FontSize', 14);
ylabel('Time to complete test (sec)', 'FontSize', 14);
legend off
title(['\rho Controls= ' num2str(RHO12,2) newline '\rho Skilled= ' num2str(RHO22,2) ' *'], 'FontSize', titleSize);
xlim([0 44.1])
ylim([12 25])

subplot(1,2,2)
plot(medabsMH2(group==1)',NHPTRH(group==1),'bo','MarkerSize',marSize);
hold on; 
plot(medabsMH2(group==2)',NHPTRH(group==2),'r^','MarkerSize',marSize);
plot(medabsMH2(group==1)',f1MH2,'b'); plot(medabsMH2(group==2)',f2MH2,'r'); 
xlabel({'abs median error' 'UJPM (mm)'}, 'FontSize', 14);
ylabel('')
legend('Controls', 'Skilled','Orientation', 'horizontal', 'FontSize', legSize);
legend('boxoff');
title(['\rho Controls= ' num2str(RHO14,2) newline '\rho Skilled= ' num2str(RHO24,2) ' *'], 'FontSize', titleSize);
xlim([0 44.1])
ylim([12 25])

% MH2V median errors vs 9HPT Rh controls
[RHO18,PVAL18] = corr(medabsMH2V(group==1)',NHPTRH(group==1),'Type','Spearman');

% H2V median errors vs B&B Rh
[RHO28,PVAL28] = corr(medabsMH2V(group==2)',NHPTRH(group==2),'Type','Spearman');


