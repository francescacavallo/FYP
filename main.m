clear 
clc

%Call prepareData script
prepareData;

%% Features of the participants cohort
features = retrieveFeatures(baseline, nParticipants);

% visualise some features 
data=[features.totNormMales features.totNormFemales;...
      features.totOverMales features.totOverFemales];
labels = categorical({'18.5<BMI<25','BMI>25'});
bar(labels, data);
legend('Males','Females')
ylabel('Number of participants')
set(gca,'fontsize',12)



%% Statistical test
StatsAnalysis;

%% Regression Models

%% Classification (?)




