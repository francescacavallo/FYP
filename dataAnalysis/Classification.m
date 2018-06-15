close all
clc
%%%%% to do here: run the two below in the classification learner and show:
    % scatter plot
    % confusion matrix
    % trained tree
    
% predict genotype from leptin (at week 8 & 0) & BMI (at baseline)

genotypeControl = {baseline(1:11).Genotype}';
genotypeIntervention = {baseline(12:23).Genotype}';
genotypeTotal = [genotypeControl;genotypeIntervention];

BMIControl = [baseline(1:11).BMI]';
BMIIntervention = [baseline(12:23).BMI]';
BMITotal = [BMIControl;BMIIntervention];

leptinControl;
leptinIntervention;
leptinTotal = [leptinControl;leptinIntervention];

leptin1BMIGenotype = table(leptinTotal(:,1), BMITotal, genotypeTotal, ...
                    'VariableNames',{'Leptin1','BMI','Genotype'});
                
leptin5BMIGenotype = table(leptinTotal(:,5), BMITotal, genotypeTotal, ...
                    'VariableNames',{'Leptin5','BMI','Genotype'}); 
                
% predict group from leptin (week 8) & genotype & BMI
Group = [baseline.Group]';
leptinBMIGenotypeGroup = table(leptinTotal(:,5),BMITotal,genotypeTotal,Group,...
                    'VariableNames',{'Leptin5','BMI','Genotype','Group'});
                
% predict how much recommended food they've had from leptin 1,5 and
% genotype and BMI


