close all
clc
%%%%% to do here: run the two below in the classification learner and show:
    % scatter plot
    % confusion matrix
    % trained tree
    
%% predict genotype from leptin (at week 8 & 0) & BMI (at baseline)

genotypeControl = {baseline(1:11).Genotype}';
genotypeIntervention = {baseline(12:23).Genotype}';
genotypeTotal = [genotypeControl;genotypeIntervention];

BMIControl = [baseline(1:11).BMI]';
BMIIntervention = [baseline(12:23).BMI]';
BMITotal = [BMIControl;BMIIntervention];

leptinControl;
leptinIntervention;
leptinTotal = [leptinControl;leptinIntervention];

leptin0BMIGenotype = table(leptinTotal(:,1), BMITotal, genotypeTotal, ...
                    'VariableNames',{'Leptin','BMI','Genotype'});
                
leptin5BMIGenotype = table(leptinTotal(:,5), BMITotal, genotypeTotal, ...
                    'VariableNames',{'Leptin','BMI','Genotype'}); 
leptin3BMIGenotype = table(leptinTotal(:,3), BMITotal, genotypeTotal, ...
                    'VariableNames',{'Leptin','BMI','Genotype'});

% train classifier on leptin week 0
[trainedClassifier, validationAccuracy] = trainClassifier(leptin0BMIGenotype);
view(trainedClassifier.ClassificationTree,'Mode','graph')
% test on leptin week 5
fit5 = trainedClassifier.predictFcn(leptin5BMIGenotype);
fit0 = trainedClassifier.predictFcn(leptin0BMIGenotype);
fit3 = trainedClassifier.predictFcn(leptin3BMIGenotype);
% accuracy
correct5=length(find(strcmp(fit5,genotypeTotal)));
accuracy5 = correct5/nParticipants;
correct0=length(find(strcmp(fit0,genotypeTotal)));
accuracy0 = correct0/nParticipants;
correct3=length(find(strcmp(fit3,genotypeTotal)));
accuracy3 = correct3/nParticipants;
%% scatter
gscatter(leptinTotal(:,5), BMITotal, genotypeTotal,'bmc','*',[10 10 10])
xlabel('Leptin (pg/ml)')
ylabel('BMI (kg/m^2)')
set(gca,'fontsize',20)
hold on
idx = find(strcmp(fit5,genotype));
plot(leptinTotal(:,5), BMITotal,'ro','MarkerSize',20,'LineWidth',2)
hold on
plot(leptinTotal(idx,5), BMITotal(idx),'go','MarkerSize',20,'LineWidth',2)
legend('GC','GG','CC','Not Predicted Correctly','Predicted Correctly')

%% predict group from leptin (week 8) & genotype & BMI
Group = [baseline.Group]';
leptinBMIGenotypeGroup = table(leptinTotal(:,5),BMITotal,genotypeTotal,Group,...
                    'VariableNames',{'Leptin5','BMI','Genotype','Group'});
                
%% classify how much recommended food they've had from leptin 3 and genotype and BMI
% use model to predict leptin 5
food = [FFQ{9}{:,45}]';
leptinBMIGenotypeFood3 = table(leptinTotal(:,3),BMITotal,genotypeTotal,food,...
    'VariableNames',{'Leptin','BMI','Genotype','Food'});

leptinBMIGenotypeFood5 = table(leptinTotal(:,5),BMITotal,genotypeTotal,food,...
    'VariableNames',{'Leptin','BMI','Genotype','Food'});

[trainedClassifier, validationAccuracy] = trainClassifier4(leptinBMIGenotypeFood3)

fit4 = trainedClassifier.predictFcn(leptinBMIGenotypeFood5);
fit5 = trainedClassifier.predictFcn(leptinBMIGenotypeFood3);

% accuracy
correct4=length(find(fit4==food));
accuracy4 = correct4/nParticipants;

% scatter
figure
gscatter(leptinTotal(:,5), BMITotal, food,'bmc','*',[10 10 10])
xlabel('Leptin (pg/ml)')
ylabel('BMI (kg/m^2)')
set(gca,'fontsize',20)
hold on
idx = find(fit4==food);
plot(leptinTotal(:,5), BMITotal,'ro','MarkerSize',20,'LineWidth',2)
hold on
plot(leptinTotal(idx,5), BMITotal(idx),'go','MarkerSize',20,'LineWidth',2)
legend('0-10%','10-30%','Not Predicted Correctly','Predicted Correctly')

% scatter
figure
gscatter(leptinTotal(:,3), BMITotal, food,'bmc','*',[10 10 10])
xlabel('Leptin (pg/ml)')
ylabel('BMI (kg/m^2)')
set(gca,'fontsize',20)
hold on
idx = find(fit5==food);
plot(leptinTotal(:,3), BMITotal,'ro','MarkerSize',20,'LineWidth',2)
hold on
plot(leptinTotal(idx,3), BMITotal(idx),'go','MarkerSize',20,'LineWidth',2)
legend('0-10%','10-30%','Not Predicted Correctly','Predicted Correctly')
