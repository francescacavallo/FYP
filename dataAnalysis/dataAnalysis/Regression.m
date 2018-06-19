close all
clc
% Regression
%% test 1
% response: baseline leptin  
% predictors: gender, age, genotype, baseline BMI, calories at FFQ1
firstCal = findFirstCal(FFQ);
firstCal = round(firstCal);
BMI = round([baseline.BMI]',1);
variables = table({baseline.Gender}', [baseline.Age]',...
              [baseline.genotypeID]', BMI, firstCal,[baseline.Leptin]',...
              'VariableNames',{'Gender','Age','Genotype','BMI','Calories','Leptin'});
% fit model
model1 = stepwiselm(variables, 'interactions')
plotResiduals(model1);
%outlier = model1.Residuals.Raw > 3;
%model1 = stepwiselm(variables, 'interactions','Exclude',find(outlier))

figure
ax1 = axes('Position',[0.4 0.14 0.55 0.8]);
ax1.ActivePositionProperty = 'position';
plotEffects(model1)
set(gca,'fontsize',20)
set(findall(gca, 'Type', 'Line'),'LineWidth',2);


figure
ax2 = axes('Position',[0.4 0.14 0.55 0.8]);
ax2.ActivePositionProperty = 'position';
plotInteraction(model1, 'Gender', 'Genotype')
set(gca,'fontsize',20)
set(findall(gca, 'Type', 'Line'),'LineWidth',2);

figure
ax1 = axes('Position',[0.4 0.14 0.55 0.8]);
ax1.ActivePositionProperty = 'position';
plotInteraction(model1, 'Age', 'Genotype')
set(gca,'fontsize',20)
set(findall(gca, 'Type', 'Line'),'LineWidth',2);

figure
ax1 = axes('Position',[0.4 0.14 0.55 0.8]);
ax1.ActivePositionProperty = 'position';
plotInteraction(model1, 'Age', 'BMI')
set(gca,'fontsize',20)
set(findall(gca, 'Type', 'Line'),'LineWidth',2);

figure
ax1 = axes('Position',[0.4 0.14 0.55 0.8]);
ax1.ActivePositionProperty = 'position';
plotInteraction(model1, 'Calories', 'Genotype')
set(gca,'fontsize',20)
set(findall(gca, 'Type', 'Line'),'LineWidth',2);

figure
ax1 = axes('Position',[0.4 0.14 0.55 0.8]);
ax1.ActivePositionProperty = 'position';
plotInteraction(model1, 'BMI', 'Calories')
set(gca,'fontsize',20)
set(findall(gca, 'Type', 'Line'),'LineWidth',2);

figure
ax1 = axes('Position',[0.4 0.14 0.55 0.8]);
ax1.ActivePositionProperty = 'position';
plotInteraction(model1, 'BMI', 'Calories','predictions') 
% if lines are crossing there is a strong interaction between gender and bmi
set(gca,'fontsize',20)

% visualise validity of model
p=plotResiduals(model1,'fitted');
set(findall(gca, 'Type', 'Line'),'MarkerSize',12);
set(gca,'fontsize',20)
set(findall(gca, 'Type', 'Line'),'LineWidth',2);

% plot model
figure
plot(model1)
%% test 2        
% response: last leptin
% predictors: group, gender, genotype, weight (x4), leptin (x4)
%weight_tmp = [WeightFControl(:,1:4);WeightFIntervention(:,1:4)];
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
variables = table( {baseline.Gender}',...
              [baseline.genotypeID]', BMI,leptin_tmp(:,1),leptin_tmp(:,2),leptin_tmp(:,3),leptin_tmp(:,4),...
              leptin_tmp(:,5), 'VariableNames',{'Gender','Genotype','BMI'...
              , 'Leptin1','Leptin2','Leptin3',...
              'Leptin4','FinalLeptin'});

model2 = stepwiselm(variables, 'interactions')
plotResiduals(model2);
%outlier = model2.Residuals.Raw > 3;
%model2 = stepwiselm(variables, 'interactions','Exclude',find(outlier))

figure
plotEffects(model2)
set(gca,'fontsize',20)
figure
%plotInteraction(model2, 'Gender', 'Group')
set(gca,'fontsize',20)
figure
%plotInteraction(model2, 'Gender', 'BMI','predictions') 
% if lines are crossing there is a strong interaction between gender and bmi
set(gca,'fontsize',20)

plot(model1)
set(gca,'fontsize',20)
set(findobj(gca,'type','line'),'linew',2)
