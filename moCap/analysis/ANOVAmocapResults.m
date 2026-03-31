clear all;
load('groups.mat')
load('medAbsAllconditions.mat')

y = [medabsH2 medabsMH2];
gr = [group group]
[p, rbl, stats] = anova1(y,gr);
results = multcompare(stats);

%% make this a 2 way
vis = [zeros(1,20) ones(1,20) zeros(1,20) ones(1,20) ];
mem = [zeros(1,20) zeros(1,20) ones(1,20) ones(1,20) ];
gr = [group group group group];
cond = [ones(1,20) 2*ones(1,20) 3*ones(1,20) 4*ones(1,20) ];

% [p, rb2, stats1] = anova1(yvis, vis)


yvis = [medabsH2 medabsH2V medabsMH2 medabsMH2V];
[pvg tvg svg]= anovan(yvis, {vis, gr},'model','interaction','varnames',{'vision','group'})
[pmg tmg smg]= anovan(yvis, {mem, gr},'model','interaction','varnames',{'mem','group'})
[pcg tcg scg]= anovan(yvis, {cond, gr},'model','interaction','varnames',{'cond','group'})


[pmvg tmvg smvg]= anovan(yvis, {mem,vis, gr},'model','interaction','varnames',{'mem','vis','group'})

[results,~,~,gnames]  =  multcompare(smg,"dimension", [1]);
