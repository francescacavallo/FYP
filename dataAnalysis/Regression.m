close all
clc
% Regression
%% test 1
% response: baseline leptin  
% predictors: gender, age, genotype, baseline BMI, calories at FFQ1
firstCal = findFirstCal(FFQ);
variables = table({baseline.Gender}', [baseline.Age]',...
              [baseline.genotypeID]', [baseline.BMI]', firstCal,[baseline.Leptin]',...
              'VariableNames',{'Gender','Age','Genotype','BMI','BaselineCal','BaselineLept'});
% fit model
model1 = stepwiselm(variables, 'interactions')
plotResiduals(model1);
%outlier = model1.Residuals.Raw > 3;
%model1 = stepwiselm(variables, 'interactions','Exclude',find(outlier))

figure
plotEffects(model1)
set(gca,'fontsize',20)
figure
plotInteraction(model1, 'Gender', 'BMI')
set(gca,'fontsize',20)
figure
plotInteraction(model1, 'Gender', 'BMI','predictions') 
% if lines are crossing there is a strong interaction between gender and bmi
set(gca,'fontsize',20)

% visualise validity of model


%% test 2        
% response: last leptin
% predictors: group, gender, genotype, weight (x4), leptin (x4)
weight_tmp = [WeightFControl(:,1:4);WeightFIntervention(:,1:4)];
leptin_tmp = [leptinControl;leptinIntervention];
group = cell(23,1);
for i=1:23
    switch baseline(i).Group
        case 1
            group{i} = 'Control';
        case 2
            group{i} = 'Intervention';
    end
end
variables = table(group, {baseline.Gender}',...
              [baseline.genotypeID]', weight_tmp(:,1), weight_tmp(:,2),weight_tmp(:,3),...
              weight_tmp(:,4),leptin_tmp(:,1),leptin_tmp(:,2),leptin_tmp(:,3),leptin_tmp(:,4),...
              leptin_tmp(:,5), 'VariableNames',{'Group','Gender','Genotype','Weight1',...
              'Weight2','Weight3','Weight4', 'Leptin1','Leptin2','Leptin3',...
              'Leptin4','FinalLeptin'});

model2 = stepwiselm(variables, 'interactions')
plotResiduals(model2);
outlier = model2.Residuals.Raw > 3;
model2 = stepwiselm(variables, 'interactions','Exclude',find(outlier))

figure
plotEffects(model2)
set(gca,'fontsize',20)
figure
plotInteraction(model2, 'Gender', 'Group')
set(gca,'fontsize',20)
figure
%plotInteraction(model2, 'Gender', 'BMI','predictions') 
% if lines are crossing there is a strong interaction between gender and bmi
set(gca,'fontsize',20)



