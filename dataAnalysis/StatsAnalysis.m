%%%%%%% Statistical Analysis %%%%
clc
close all
addpath('functions')
addpath('ext')

%% Correlation with personal info
% correlate leptin1 to personal info (both groups together)

% Create an input matrix containing the sample data_tmp. 
baselineDouble = [baseline.genderID; baseline.Age; baseline.Weight; baseline.BMI; baseline.ethnicityID; baseline.genotypeID; baseline.Leptin]';
[rhoLeptin2Person,pvalLeptin2Person] = partialcorr(baselineDouble,'rows','complete');
rhoLeptin2Person = displayTable(rhoLeptin2Person, 'Correlation');
pvalLeptin2Person = displayTable(pvalLeptin2Person, 'P Value');

% save results to excel 
delete 'spreadsheets/baselineCorrelation.xlsx';
filename = 'spreadsheets/baselineCorrelation.xlsx';
writetable(rhoLeptin2Person,filename,'Sheet','Rho','WriteRowNames',true)
writetable(pvalLeptin2Person,filename,'Sheet','Pval','WriteRowNames',true)

%% Comparison of mean


% get leptin from measurements struct
[leptinControl, leptinIntervention]=getmeasure(Measurements,'leptin');
leptinAll=[leptinControl; leptinIntervention];
%%plot all leptin data
sample = zeros(size(leptinAll));
for i=1:5
    sample(:,i)=i;
end
plot(sample,leptinAll,'Marker','o')

%check if data is normally distributed
checkNormal(leptinControl(:,1),leptinIntervention(:,1));

% trasform data_tmp if necessary & check again 
[leptinControl, leptinIntervention]=getmeasure(Measurements,'leptin');
outlierControl = leptinControl(:,1)<0.6;
outlierInter = leptinIntervention(:,1)<0.6;
leptinControl_trans=1./(leptinControl(~outlierControl,1));
leptinIntervention_trans = 1./(leptinIntervention(~outlierInter,1));
checkNormal(leptinControl_trans,leptinIntervention_trans);
leptinAll_trans=[leptinControl_trans; leptinIntervention_trans];

% if transformation good, transform all leptin values 
clear outlier
for i=1:5
    outlier = leptinAll(:,i)<0.6;
    for j=1:nParticipants
        if outlier(j)==0
            leptinAll(j,i)=1./(leptinAll(j,i));
        else
            leptinAll(j,i)=NaN;
        end      
    end
end
leptinControl = leptinAll(1:size(leptinControl,1),:);
leptinIntervention = leptinAll(size(leptinIntervention,1):end,:);

%% leptin of intervention at week 0 VS at week 8
disp('Paired ttest for intervention samples 1 VS 5')
[~,~,~,~]=compareMean(leptinIntervention(:,1),leptinIntervention(:,5),'paired');
fprintf('\n')    

%% leptin of control VS intervention at each sample
    % there should not be difference in the 2 means at baseline, but there
    % should be at week 8
for sample=2:5
    name=['Ttest for intervention VS control at sample',num2str(sample)];
    disp(name)
    compareMean(leptinIntervention(:,sample)./leptinIntervention(:,1),leptinControl(:,sample)./leptinControl(:,1),'2sample');   
    fprintf('\n')
    % plot distributions
    figure
    [pdC(sample),pdI(sample)] = createFit3(leptinControl(:,sample),leptinIntervention(:,sample));
end


%% boxplot for leptin at baseline
figure
boxplot([1./leptinControl(:,1); 1./leptinIntervention(:,1)],[baseline.Group],'Labels',{'Control','Intervention'})
ylabel('Salivary leptin (pg/ml)')
set(gca,'fontsize',20)
set(findobj(gca,'type','line'),'linew',2)

% boxplot for leptin at week 8
figure
boxplot([1./leptinControl(:,5); 1./leptinIntervention(:,5)],[baseline.Group],'Labels',{'Control','Intervention'})
ylabel('Salivary leptin (pg/ml)')
set(gca,'fontsize',20)
set(findobj(gca,'type','line'),'linew',2)

    
%% mean (with confidence intervals) trend of leptin for intervention group and control

% for i=1:5
%     meanLeptInterv(i)=pdI(i).mu;
%     meanLeptControl(i)=pdC(i).mu;
%     SEI = nanstd(leptinIntervention(:,i))/sqrt(length(leptinIntervention(:,i)));              
%     SEC = nanstd(leptinControl(:,i))/sqrt(length(leptinControl(:,i)));
%     tsI = tinv([0.025  0.975],length(leptinIntervention(:,i))-1);     
%     tsC = tinv([0.025  0.975],length(leptinControl(:,i))-1); 
%     CII_tmp = meanLeptInterv(i) + tsI*SEI;  
%     CIC_tmp = meanLeptControl(i) + tsC*SEC; 
%     CII(i,:) = CII_tmp;  
%     CIC(i,:) = CIC_tmp; 
% end

% figure
% plot(1./meanLeptControl,'lineWidth',2) 
% hold on
% plot(1./meanLeptInterv,'r','lineWidth',2) 
% hold on
% plot(1./CIC,'Color',[0 0.4470 0.741],'LineStyle','--')
% hold on
% plot(1./CII,'Color','r','LineStyle','--')
% leptinlegend
% legend('Control', 'Intervention','95% CI')
    
%% Relation with BMI & calories
% get weight from measurements
[leptinControl, leptinIntervention]=getmeasure(Measurements,'leptin');
BMIControl = [baseline(1:11).BMI,]';
BMIIntervention =[baseline(12:23).BMI,]'; 
[CalFControl, CalFIntervention]=getmeasure(Measurements,'caloriesF');

% visualise weight VS leptin 
% at week 0
week = [1,5];
for i=1:2
    figure
    sample = week(i);
    scatter(BMIIntervention(:),leptinIntervention(:,sample),60,'b*')
    hold on
    scatter(BMIControl(:),leptinControl(:,sample),60,'r*')
    ylabel('Salivary Leptin (pg/ml)')
    xlabel('BMI (kcal/m^2)')
    set(gca,'fontsize',20)
    legend('Intervention', 'Control')
    title(['Measured at Week ',num2str((week(i)-1)*2)])
end


% visualise calories VS leptin 
% at week 0 and 8, interv VS control
week = [1,5];
for i=1:2
    figure
    sample = week(i);
    scatter(CalFIntervention(:,sample)./2,leptinIntervention(:,sample),60,'b*')
    hold on
    scatter(CalFControl(:,sample)./2,leptinControl(:,sample),60,'r*')
    ylabel('Salivary Leptin (pg/ml)')
    xlabel('Calories/week (kcal)')
    set(gca,'fontsize',12)
    legend('Intervention', 'Control')
    title(['Measured at Week ',num2str((week(i)-1)*2)])
    set(gca,'fontsize',20)
end

% Correlation of leptin with calories, weight and genotype for everyone
genotype_tmp = [baseline.genotypeID;baseline.genotypeID;baseline.genotypeID;baseline.genotypeID;baseline.genotypeID]';
BMI_tmp = [baseline.BMI;baseline.BMI;baseline.BMI;baseline.BMI;baseline.BMI]';
leptin_tmp = reshape([Measurements.Leptin],5,23)';
calories_tmp=reshape([Measurements.CaloriesFortn],5,23)';
data_tmp = [leptin_tmp(:,5), [baseline.BMI]', calories_tmp(:,5), [baseline.genotypeID]'];
[rhoLeptin2Cal,pvalLeptin2Cal] = partialcorr(data_tmp,'Rows','pairwise');
rhoLeptin2Cal = displayTable2(rhoLeptin2Cal, 'Correlation');
pvalLeptin2Cal = displayTable2(pvalLeptin2Cal, 'P Value');

% save results to excel 
delete 'spreadsheets/MeasurementsCorrelation.xlsx';
filename = 'spreadsheets/MeasurementsCorrelation.xlsx';
writetable(rhoLeptin2Cal,filename,'Sheet','Rho','WriteRowNames',true)
writetable(pvalLeptin2Cal,filename,'Sheet','Pval','WriteRowNames',true)

% Correlation of leptin with calories, weight and genotype for intervention
leptin_tmp = reshape([Measurements.Leptin],5,23)';
calories_tmp=reshape([Measurements.CaloriesFortn],5,23)';
data_tmp = [leptin_tmp(12:23,5), [baseline(12:23).BMI]', calories_tmp(12:23,5), [baseline(12:23).genotypeID]'];
[rhoLeptin2Cal,pvalLeptin2Cal] = partialcorr(data_tmp,'Rows','pairwise');
rhoLeptin2Cal = displayTable2(rhoLeptin2Cal, 'Correlation');
pvalLeptin2Cal = displayTable2(pvalLeptin2Cal, 'P Value');

% Correlation of leptin with calories, weight and genotype for control
leptin_tmp = reshape([Measurements.Leptin],5,23)';
calories_tmp = reshape([Measurements.CaloriesFortn],5,23)';
data_tmp = [leptin_tmp(1:11,5), [baseline(1:11).BMI]', calories_tmp(1:11,5), [baseline(1:11).genotypeID]'];
[rhoLeptin2Cal,pvalLeptin2Cal] = partialcorr(data_tmp,'Rows','pairwise');
rhoLeptin2Cal = displayTable2(rhoLeptin2Cal, 'Correlation');
pvalLeptin2Cal = displayTable2(pvalLeptin2Cal, 'P Value');

%% Correlation leptin at week 8 with amount of recommended food and genotype 
% get amount of recommended food eaten at sample
% food_tmp =zeros(1,60);
% sample = [1 3 5 7 9];
% for i=1:5 %%%%% to 5
%     idx = sample(i);
%     for n=12:23
%         food_tmp((n-11)*i) = [FFQ{idx}{n,4}];
%     end
% end
food_tmp = [FFQ{9}{:,4}]';
genotype_tmp = [baseline(12:23).genotypeID]';

recomm_tmp = [food_tmp(12:23), leptin_tmp(12:23,5)]; % only for intervention at week 8
[rhoLeptin2Recc,pvalLeptin2Recc] = partialcorr(recomm_tmp,'Rows','pairwise');
rhoLeptin2Recc = displayTable3(rhoLeptin2Recc,'Correlation');
pvalLeptin2Recc = displayTable3(pvalLeptin2Recc, 'P Value');

% save results to excel 
delete 'spreadsheets/RecommendedCorrelation.xlsx';
filename = 'spreadsheets/RecommendedCorrelation.xlsx';
writetable(rhoLeptin2Recc,filename,'Sheet','Rho','WriteRowNames',true)
writetable(pvalLeptin2Recc,filename,'Sheet','Pval','WriteRowNames',true)

%% repeat adjusting for genotype

recomm_tmp = [food_tmp(12:23), leptin_tmp(12:23,5), genotype_tmp]; % only for intervention
[rhoLeptin2Recc,pvalLeptin2Recc] = partialcorr(recomm_tmp,'Rows','complete');
rhoLeptin2Recc = array2table(rhoLeptin2Recc, ...
    'VariableNames',{'Leptin','Food','Genotype'},...
    'RowNames',{'Leptin','Food','Genotype'});
name = 'Correlation Coefficients adjusted for genotype';
disp(name)
disp(rhoLeptin2Recc)
pvalLeptin2Recc = array2table(pvalLeptin2Recc, ...
    'VariableNames',{'Leptin','Food','Genotype'},...
    'RowNames',{'Leptin','Food','Genotype'});
name = 'P value Coefficients adjusted for genotype';
disp(name)
disp(pvalLeptin2Recc)    
filename = 'spreadsheets/RecommendedCorrelation.xlsx';
writetable(rhoLeptin2Recc,filename,'Sheet','Rho_G','WriteRowNames',true)
writetable(pvalLeptin2Recc,filename,'Sheet','Pval_G','WriteRowNames',true)

%% repeat adjusting for calories

recomm_tmp = [food_tmp(12:23), leptin_tmp(12:23,5), calories_tmp(12:23,5)]; % only for intervention
[rhoLeptin2Recc,pvalLeptin2Recc] = partialcorr(recomm_tmp,'Rows','complete');
rhoLeptin2Recc = array2table(rhoLeptin2Recc, ...
    'VariableNames',{'Leptin','Food','Calories'},...
    'RowNames',{'Leptin','Food','Calories'});
name = 'Correlation Coefficients adjusted for calories';
disp(name)
disp(rhoLeptin2Recc)
pvalLeptin2Recc = array2table(pvalLeptin2Recc, ...
    'VariableNames',{'Leptin','Food','Calories'},...
    'RowNames',{'Leptin','Food','Calories'});
name = 'P value Coefficients adjusted for calories';
disp(name)
disp(pvalLeptin2Recc)    
filename = 'spreadsheets/RecommendedCorrelation.xlsx';
writetable(rhoLeptin2Recc,filename,'Sheet','Rho_C','WriteRowNames',true)
writetable(pvalLeptin2Recc,filename,'Sheet','Pval_C','WriteRowNames',true)

%% repeat adjusting for calories and genotype
recomm_tmp = [food_tmp(12:23), leptin_tmp(12:23,5), calories_tmp(12:23,5), genotype_tmp, BMIIntervention]; % only for intervention
[rhoLeptin2Recc,pvalLeptin2Recc] = partialcorr(recomm_tmp,'Rows','complete');
rhoLeptin2Recc = array2table(rhoLeptin2Recc, ...
    'VariableNames',{'Leptin','Food','Calories','Genotype','BMI'},...
    'RowNames',{'Leptin','Food','Calories','Genotype','BMI'});
name = 'Correlation Coefficients adjusted for calories';
disp(name)
disp(rhoLeptin2Recc)
pvalLeptin2Recc = array2table(pvalLeptin2Recc, ...
    'VariableNames',{'Leptin','Food','Calories','Genotype','BMI'},...
    'RowNames',{'Leptin','Food','Calories','Genotype','BMI'});
name = 'P value Coefficients adjusted for calories';
disp(name)
disp(pvalLeptin2Recc)    
filename = 'spreadsheets/RecommendedCorrelation.xlsx';
writetable(rhoLeptin2Recc,filename,'Sheet','Rho_CG','WriteRowNames',true)
writetable(pvalLeptin2Recc,filename,'Sheet','Pval_CG','WriteRowNames',true)

%% %% clean workspace
clear i j idx name n sample week ans
clear CIC CIC_tmp CII CII_tmp data_tmp
clear genotype_tmp recomm_tmp food_tmp 
clear filename table
clear hT pvalT stats ci
clear outlier outlierControl outlierInter
clear pdC pdI SEC SEI tsC tsI





