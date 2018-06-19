%%%%% Analysis for each subject and similar groups %%%%%

%% plot leptin at each week
close all
clc
week = 1:5;
figure
clear l
i=1;
for n=1:11
    if sum(isnan([Measurements(n).Leptin]))==0
        Xi = 1:0.1:5;
        Yi = pchip(week,[Measurements(n).Leptin],Xi);
        plot(Xi,Yi,'LineWidth',2)
        hold on
        l{i}=['Subject ' num2str(Measurements(n).Code)];
        i=i+1;
    end
    leptinlegend
end
legend(l)

figure
i=1; clear l
for n=12:23
    if sum(isnan([Measurements(n).Leptin]))==0
        Xi = 1:0.1:5;
        Yi = pchip(week,[Measurements(n).Leptin],Xi);
        plot(Xi,Yi,'LineWidth',2)
        hold on
        l{i}=['Subject ' num2str(Measurements(n).Code)];
        i=i+1;
    end
    leptinlegend  
end
legend(l);


%% Group by similar features
%% females and genotype GG
clc 
close all
%
[similarControl_leptin,similarInter_leptin]=LeptinByGroup(baseline,Measurements,1);

[~,~,~,~]=compareMean(similarInter_leptin(:,1),similarInter_leptin(:,5),'paired');
[~,~,~,~]=compareMean(similarInter_leptin(:,5),similarControl_leptin(:,1),'2sample');

clear idxC idxI
idxC = find(similarControl_leptin(:,1)~=0);
idxI = find(similarInter_leptin(:,1)~=0);

MyAnova(similarControl_leptin(idxC,5),similarInter_leptin(idxI,5),baseline,idxC,idxI);
%% female CG
clc 
close all
%
[similarControl_leptin,similarInter_leptin]=LeptinByGroup(baseline,Measurements,2);

[~,~,~,~]=compareMean(similarInter_leptin(:,1),similarInter_leptin(:,5),'paired');
[~,~,~,~]=compareMean(similarInter_leptin(:,5),similarControl_leptin(:,1),'2sample');

clear idxC idxI  

idxC = find(similarControl_leptin(:,1)~=0);
idxI = find(similarInter_leptin(:,1)~=0);

MyAnova(similarControl_leptin(idxC,5),similarInter_leptin(idxI,5),baseline,idxC,idxI);

%% females
clc
[similarControl_leptin,similarInter_leptin]=LeptinByGroup(baseline,Measurements,3);

[~,~,~,~]=compareMean(similarInter_leptin(:,1),similarInter_leptin(:,5),'paired');
[~,~,~,~]=compareMean(similarInter_leptin(:,5),similarControl_leptin(:,1),'2sample');
clear idxC idxI
idxC = find(similarControl_leptin(:,1)~=0);
idxI = find(similarInter_leptin(:,1)~=0);

MyAnova(similarControl_leptin(idxC,5),similarInter_leptin(idxI,5),baseline,idxC,idxI);
%% males %%%%%%% different means % not confirmed by ANOVA
[similarControl_leptin,similarInter_leptin]=LeptinByGroup(baseline,Measurements,4);
    
[~,~,~,~]=compareMean(similarInter_leptin(:,1),similarInter_leptin(:,5),'paired');
[~,~,~,~]=compareMean(similarInter_leptin(:,5),similarControl_leptin(:,5),'2sample');
clear idxC idxI
idxC = find(similarControl_leptin(:,1)~=0);
idxI = find(similarInter_leptin(:,1)~=0);

MyAnova(similarControl_leptin(idxC,5),similarInter_leptin(idxI,5),baseline,idxC,idxI);

%% GG   %%% different means % confirmed by ANOVA
[similarControl_leptin,similarInter_leptin]=LeptinByGroup(baseline,Measurements,5);
[~,~,~,~]=compareMean(similarInter_leptin(:,1),similarInter_leptin(:,5),'paired');
[~,~,~,~]=compareMean(similarInter_leptin(:,5),similarControl_leptin(:,5),'2sample');

clear idxC idxI
idxC = find(similarControl_leptin(:,1)~=0);
idxI = find(similarInter_leptin(:,1)~=0);

MyAnova(similarControl_leptin(idxC,5),similarInter_leptin(idxI,5),baseline,idxC,idxI);

caloriesC_tmp=reshape([Measurements(1:11).CaloriesWeek],9,11)';
caloriesC = caloriesC_tmp(idxC,9);
caloriesI_tmp=reshape([Measurements(12:23).CaloriesWeek],9,12)';
caloriesI = caloriesI_tmp(idxI,9);
MyAnova(caloriesC,caloriesI,baseline,idxC,idxI);

%% CG
[similarControl_leptin,similarInter_leptin]=LeptinByGroup(baseline,Measurements,6);

[~,~,~,~]=compareMean(similarInter_leptin(:,1),similarInter_leptin(:,5),'paired');
[~,~,~,~]=compareMean(similarInter_leptin(:,5),similarControl_leptin(:,5),'2sample');
clear idxC idxI
idxC = find(similarControl_leptin(:,1)~=0);
idxI = find(similarInter_leptin(:,1)~=0);

MyAnova(similarControl_leptin(idxC,5),similarInter_leptin(idxI,5),baseline,idxC,idxI);

caloriesC_tmp=reshape([Measurements(1:11).CaloriesWeek],9,11)';
caloriesC = caloriesC_tmp(idxC,9);
caloriesI_tmp=reshape([Measurements(12:23).CaloriesWeek],9,12)';
caloriesI = caloriesI_tmp(idxI,9);
MyAnova(caloriesC,caloriesI,baseline,idxC,idxI);
%% CC %%%no data

%% BMI normal 
[similarControl_leptin,similarInter_leptin]=LeptinByGroup(baseline,Measurements,8);

[~,~,~,~]=compareMean(similarInter_leptin(:,1),similarInter_leptin(:,5),'paired');
[~,~,~,~]=compareMean(similarInter_leptin(:,5),similarControl_leptin(:,5),'2sample');

clear idxI idxC

idxC = find(similarControl_leptin(:,1)~=0);
idxI = find(similarInter_leptin(:,1)~=0);

MyAnova(similarControl_leptin(idxC,5),similarInter_leptin(idxI,5),baseline,idxC,idxI);

caloriesC_tmp=reshape([Measurements(1:11).CaloriesWeek],9,11)';
caloriesC = caloriesC_tmp(idxC,9);
caloriesI_tmp=reshape([Measurements(12:23).CaloriesWeek],9,12)';
caloriesI = caloriesI_tmp(idxI,9);
MyAnova(caloriesC,caloriesI,baseline,idxC,idxI);
%% BMI over
[similarControl_leptin,similarInter_leptin]=LeptinByGroup(baseline,Measurements,9);

[~,~,~,~]=compareMean(similarInter_leptin(:,1),similarInter_leptin(:,5),'paired');
[~,~,~,~]=compareMean(similarInter_leptin(:,5),similarControl_leptin(:,5),'2sample');

idxC = find(similarControl_leptin(:,1)~=0);
idxI = find(similarInter_leptin(:,1)~=0);

MyAnova(similarControl_leptin(idxC,5),similarInter_leptin(idxI,5),baseline,idxC,idxI);

caloriesC_tmp=reshape([Measurements(1:11).CaloriesWeek],9,11)';
caloriesC = caloriesC_tmp(idxC,9);
caloriesI_tmp=reshape([Measurements(12:23).CaloriesWeek],9,12)';
caloriesI = caloriesI_tmp(idxI,9);
MyAnova(caloriesC,caloriesI,baseline,idxC,idxI);

%% BMI under %% no data

%% Males GG No Data

%% Males GC No Data
[similarControl_leptin,similarInter_leptin]=LeptinByGroup(baseline,Measurements,12);

[~,~,~,~]=compareMean(similarInter_leptin(:,1),similarInter_leptin(:,5),'paired');
[~,~,~,~]=compareMean(similarInter_leptin(:,5),similarControl_leptin(:,5),'2sample');

idxC = find(similarControl_leptin(:,1)~=0);
idxI = find(similarInter_leptin(:,1)~=0);

MyAnova(similarControl_leptin(idxC,5),similarInter_leptin(idxI,5),baseline,idxC,idxI);

caloriesC_tmp=reshape([Measurements(1:11).CaloriesWeek],9,11)';
caloriesC = caloriesC_tmp(idxC,9);
caloriesI_tmp=reshape([Measurements(12:23).CaloriesWeek],9,12)';
caloriesI = caloriesI_tmp(idxI,9);
MyAnova(caloriesC,caloriesI,baseline,idxC,idxI);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% BMI between 18.5 and 25 (normal weight)& male & genotype GG
%%% no one in intervention

[similarControl_leptin,similarInter_leptin]=LeptinByGroup(baseline,Measurements,13);

clear idxI idxC
idxC = find(similarControl_leptin(:,1)~=0);
idxI = find(similarInter_leptin(:,1)~=0);

% leptinI(1)/leptinI(0), leptinI(8)/leptinI(0)
MyAnova(similarInter_leptin(idxI,2)./similarInter_leptin(idxI,1),...
        similarInter_leptin(idxI,5)./similarInter_leptin(idxI,1),baseline,idxI,idxI);

% leptinC(1)/leptinC(0), leptinC(8)/leptinC(0) % no difference w/out
% normalisation
MyAnova(similarControl_leptin(idxC,2),...
        similarControl_leptin(idxC,5),baseline,idxC,idxC);
    
% leptinC(8)/leptinC(0), leptinI(8)/leptinI(0)
MyAnova(similarControl_leptin(idxC,5)./similarControl_leptin(idxC,1),...
        similarInter_leptin(idxI,5)./similarInter_leptin(idxI,1),baseline,idxC,idxI);


%% BMI between >25 (overweight)& male & genotype GG
%%% no one in intervention, only one in control
clc
[similarControl_leptin,similarInter_leptin]=LeptinByGroup(baseline,Measurements,14);

clear idxI idxC
idxC = find(similarControl_leptin(:,1)~=0);
idxI = find(similarInter_leptin(:,1)~=0);

% leptinI(1)/leptinI(0), leptinI(8)/leptinI(0)
MyAnova(similarInter_leptin(idxI,2)./similarInter_leptin(idxI,1),...
        similarInter_leptin(idxI,5)./similarInter_leptin(idxI,1),baseline,idxI,idxI);

% leptinC(1)/leptinC(0), leptinC(8)/leptinC(0)
MyAnova(similarControl_leptin(idxC,2)./similarControl_leptin(idxC,1),...
        similarControl_leptin(idxC,5)./similarControl_leptin(idxC,1),baseline,idxC,idxC);
    
% leptinC(8)/leptinC(0), leptinI(8)/leptinI(0)
MyAnova(similarControl_leptin(idxC,5)./similarControl_leptin(idxC,1),...
        similarInter_leptin(idxI,5)./similarInter_leptin(idxI,1),baseline,idxC,idxI);
    
    
%% BMI between 18.5 and 25 (normal weight)& female & genotype GG
%%only one subject in each group... can't do anova
clc
[similarControl_leptin,similarInter_leptin]=LeptinByGroup(baseline,Measurements,15);

clear idxI idxC
idxC = find(similarControl_leptin(:,1)~=0);
idxI = find(similarInter_leptin(:,1)~=0);

% leptinI(1)/leptinI(0), leptinI(8)/leptinI(0) 
% can't: 1 vs 1
MyAnova(similarInter_leptin(idxI,2)./similarInter_leptin(idxI,1),...
        similarInter_leptin(idxI,5)./similarInter_leptin(idxI,1),baseline,idxI,idxI);

% leptinC(1)/leptinC(0), leptinC(8)/leptinC(0)
MyAnova(similarControl_leptin(idxC,2)./similarControl_leptin(idxC,1),...
        similarControl_leptin(idxC,5)./similarControl_leptin(idxC,1),baseline,idxC,idxC);
    
% leptinC(8)/leptinC(0), leptinI(8)/leptinI(0)
MyAnova(similarControl_leptin(idxC,5)./similarControl_leptin(idxC,1),...
        similarInter_leptin(idxI,5)./similarInter_leptin(idxI,1),baseline,idxC,idxI);


%% BMI between > 25 (overweight)& female & genotype GG
 %%no one in intervention & only one in control
 
[similarControl_leptin,similarInter_leptin]=LeptinByGroup(baseline,Measurements,16);

clear idxI idxC
idxC = find(similarControl_leptin(:,1)~=0);
idxI = find(similarInter_leptin(:,1)~=0);

% leptinI(1)/leptinI(0), leptinI(8)/leptinI(0)
MyAnova(similarInter_leptin(idxI,2)./similarInter_leptin(idxI,1),...
        similarInter_leptin(idxI,5)./similarInter_leptin(idxI,1),baseline,idxI,idxI);

% leptinC(1)/leptinC(0), leptinC(8)/leptinC(0)
MyAnova(similarControl_leptin(idxC,2)./similarControl_leptin(idxC,1),...
        similarControl_leptin(idxC,5)./similarControl_leptin(idxC,1),baseline,idxC,idxC);
    
% leptinC(8)/leptinC(0), leptinI(8)/leptinI(0)
MyAnova(similarControl_leptin(idxC,5)./similarControl_leptin(idxC,1),...
        similarInter_leptin(idxI,5)./similarInter_leptin(idxI,1),baseline,idxC,idxI);

    
%% BMI between 18.5 and 25 (normal weight)& male & genotype GC
% only one person in intervention
[similarControl_leptin,similarInter_leptin]=LeptinByGroup(baseline,Measurements,17);

clear idxI idxC
idxC = find(similarControl_leptin(:,1)~=0);
idxI = find(similarInter_leptin(:,1)~=0);

% leptinI(1)/leptinI(0), leptinI(8)/leptinI(0) %Cannot compare means with 0 degrees of freedom for error.
MyAnova(similarInter_leptin(idxI,2),...
        similarInter_leptin(idxI,5),baseline,idxI,idxI);

% leptinC(1)/leptinC(0), leptinC(8)/leptinC(0) % no difference %Cannot normalise because of nans.
MyAnova(similarControl_leptin(idxC,1),...
        similarControl_leptin(idxC,5),baseline,idxC,idxC);
    
% leptinC(8)/leptinC(0), leptinI(8)/leptinI(0) % no difference with or
% without normal
MyAnova(similarControl_leptin(idxC,5),...
        similarInter_leptin(idxI,5),baseline,idxC,idxI);

    
%% BMI between >25 (overweight)& male & genotype GC
% only one person in control
[similarControl_leptin,similarInter_leptin]=LeptinByGroup(baseline,Measurements,18);

clear idxI idxC
idxC = find(similarControl_leptin(:,1)~=0);
idxI = find(similarInter_leptin(:,1)~=0);

% leptinI(1)/leptinI(0), leptinI(8)/leptinI(0) % no difference w/wout
% normal
MyAnova(similarInter_leptin(idxI,2)./similarInter_leptin(idxI,1),...
        similarInter_leptin(idxI,5)./similarInter_leptin(idxI,1),baseline,idxI,idxI);

% leptinC(1)/leptinC(0), leptinC(8)/leptinC(0) %%Cannot compare means with 0 degrees of freedom for error.
% there is 1 Vs 1
MyAnova(similarControl_leptin(idxC,1)./similarControl_leptin(idxC,1),...
        similarControl_leptin(idxC,5)./similarControl_leptin(idxC,1),baseline,idxC,idxC);
     
% leptinC(8)/leptinC(0), leptinI(8)/leptinI(0)  % no difference w/out
% normal
MyAnova(similarControl_leptin(idxC,5)./similarControl_leptin(idxC,1),...
        similarInter_leptin(idxI,5)./similarInter_leptin(idxI,1),baseline,idxC,idxI);

    
 
%% BMI between 18.5 and 25 (normal weight)& female & genotype GC
% no data
[similarControl_leptin,similarInter_leptin]=LeptinByGroup(baseline,Measurements,19);

clear idxI idxC
idxC = find(similarControl_leptin(:,1)~=0);
idxI = find(similarInter_leptin(:,1)~=0);

% leptinI(1)/leptinI(0), leptinI(8)/leptinI(0)  % no difference 
MyAnova(similarInter_leptin(idxI,2),...
        similarInter_leptin(idxI,5),baseline,idxI,idxI);

% leptinC(1)/leptinC(0), leptinC(8)/leptinC(0) %no one
MyAnova(similarControl_leptin(idxC,2)./similarControl_leptin(idxC,1),...
        similarControl_leptin(idxC,5)./similarControl_leptin(idxC,1),baseline,idxC,idxC);
    
% leptinC(8)/leptinC(0), leptinI(8)/leptinI(0) % no one
MyAnova(similarControl_leptin(idxC,5)./similarControl_leptin(idxC,1),...
        similarInter_leptin(idxI,5)./similarInter_leptin(idxI,1),baseline,idxC,idxI);

    
%% BMI between > 25 (overweight)& female & genotype GC
%no data
[similarControl_leptin,similarInter_leptin]=LeptinByGroup(baseline,Measurements,20);

clear idxI idxC
idxC = find(similarControl_leptin(:,1)~=0);
idxI = find(similarInter_leptin(:,1)~=0);

% leptinI(1)/leptinI(0), leptinI(8)/leptinI(0)  %Cannot compare means with 0 degrees of freedom for error.
MyAnova(similarInter_leptin(idxI,2)./similarInter_leptin(idxI,1),...
        similarInter_leptin(idxI,5)./similarInter_leptin(idxI,1),baseline,idxI,idxI);

% leptinC(1)/leptinC(0), leptinC(8)/leptinC(0) %Cannot compare means with 0 degrees of freedom for error.
MyAnova(similarControl_leptin(idxC,2)./similarControl_leptin(idxC,1),...
        similarControl_leptin(idxC,5)./similarControl_leptin(idxC,1),baseline,idxC,idxC);
    
% leptinC(8)/leptinC(0), leptinI(8)/leptinI(0) %Cannot compare means with 0 degrees of freedom for error.
MyAnova(similarControl_leptin(idxC,5)./similarControl_leptin(idxC,1),...
        similarInter_leptin(idxI,5)./similarInter_leptin(idxI,1),baseline,idxC,idxI);

 
 
