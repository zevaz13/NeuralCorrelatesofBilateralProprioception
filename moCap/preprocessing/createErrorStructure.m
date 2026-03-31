clear all;

% Subjects to check
subs = {'S01','S02','S03','S04','S05','S06','S07','S08','S09','S10','S11','S12','S13','S14','S15','S16','S17','S18','S19','S20','S21','S22','S23','S24'};
%% remove arraw MH2NV (second row starts at S11)
removeMH2NV  ={[20 60 61],[24 38],[1 34:44],[],[20 21 23 39 41 52]...
               ,[10 32 44 55 61],[1 7 16 66],[8 41 43], [44 49],[],...
                [2 15 23 37], [12 17 50 55 64 65], [1], [48], [2 5 50],...
                [5 34], [15], [57 65], [], [1 2 10 11 18 50 52 66],...
                [43 ], [], [1 9 23 34 54], [2 5 6 7 8 9 10 11 48 58 63]};
%% remove array H2NV (second row starts at S11)
removeH2NV   ={[60],[24 38],[1 34:44],[],[23 ]...
            ,[32 44],[66],[41],[], [],...
            [2], [64 65], [], [], [50],...
            [5 34 ],[],[57],[],[10 50 52 66],...
            [43],[],[9],[6 7 8 9 10 11]};


%% remove arraw MH2vis (second row starts at S11)
removeMH2vis ={[1 39],[8 44],[3 34 35 39 44 ],[29 62],[15 18 26 27 31 34 36]...
    ,[3 15 ],[1 28 29 37 46 48 56 57 66],[5 6 7 8 14 18 22 58], [10 23 35 40 ], [29 31], ...
    [1], [37 43 48 60 61 62 63], [], [8 37 50], [5 8 16 32 ],...
    [51],[34 45],[27],[13 ],[],...
    [23], [], [32 45 60], [1 11 26 37 39 52]};
%% remove array H2vis (second row starts at S11)
removeH2vis  ={[],[8],[35 44],[62],[]...
    ,[],[28 37 46 48 56 57 66],[58], [], [],...
    [], [36 38 39 40 43 49 50 62 63 ], [], [], [8],...
    [7 23 47 51],[],[],[],[],...
    [],[], [32], [1 26 37 39 52]};

moCap = {};
path2data = ''; % Replace for where the shared data repo is located in your computer.
for si = 1:length(subs)
    subMocap = [];
    subMocap.subID = subs{si};
    
    % for the no visual error 
    pathNV = [path2data subs{si} '\moCap\noVis\'];
    removeH2 = removeH2NV{si};
    errH2NV = errorH2fromArray(pathNV,removeH2,si);
    removeMH2 = removeMH2NV{si};
    errMH2NV= errprMH2fromArray(pathNV, removeMH2,si);
    subMocap.NV.errorH2 = errH2NV;
    subMocap.NV.errorMH2 = errMH2NV;
    subMocap.NV.removeH2 = removeH2;
    subMocap.NV.removeMH2 = removeMH2;
    subMocap.NV.meanH2   = mean(errH2NV(find(errH2NV<500)));
    subMocap.NV.meanMH2   = mean(errMH2NV(find(errMH2NV<500)));
    subMocap.NV.stdH2   = std(errH2NV(find(errH2NV<500)));
    subMocap.NV.stdMH2   = std(errMH2NV(find(errMH2NV<500)));
    % for the visual error 
    pathVis= [path2data subs{si} '\moCap\vis\'];
    
    removeH2 = removeH2vis{si};
    errH2NV = errorH2fromArray(pathVis,removeH2,si);
    removeMH2 = removeMH2vis{si};
    errMH2NV= errprMH2fromArray(pathVis, removeMH2,si);
    subMocap.vis.errorH2 = errH2NV;
    subMocap.vis.errorMH2 = errMH2NV;
    subMocap.vis.removeH2 = removeH2;
    subMocap.vis.removeMH2 = removeMH2;
    subMocap.vis.meanH2   = mean(errH2NV(find(errH2NV<500)));
    subMocap.vis.meanMH2   = mean(errMH2NV(find(errMH2NV<500)));
    subMocap.vis.stdH2   = std(errH2NV(find(errH2NV<500)));
    subMocap.vis.stdMH2   = std(errMH2NV(find(errMH2NV<500)));
    
    moCap{si} = subMocap;
end

% save the structure 

% save('\files\moCapErrors.mat','moCap')