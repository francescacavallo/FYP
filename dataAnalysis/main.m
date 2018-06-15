clear 
clc

% Load all data
prepareData;
%% Features of the participants cohort
features = retrieveFeatures(baseline, nParticipants);

% visualise some features 
data=[features.totNormMales features.totNormFemales;...
      features.totOverMales features.totOverFemales];
labels = categorical({'18.5<BMI<25','BMI>25'});
bar(labels,data);
legend('Males','Females')
ylabel('Number of participants')
set(gca,'fontsize',20)

% calories VS weight
idxI = isnan(CalFIntervention(:,1));
idxC = isnan(CalFControl(:,1));
bmi = [BMIIntervention(~idxI);BMIControl(~idxC)];
cal = [CalFIntervention(~idxI,1);CalFControl(~idxC,1)]./7;
figure
p1=scatter(BMIControl(:,1),CalFControl(:,1)./7,40,'r*');
hold on
p2=scatter(BMIIntervention(:,1),CalFIntervention(:,1)./7,40,'b*');
hold on
p3=plot(nanmean([BMIIntervention(:,1);BMIControl(:,1)]),nanmean([CalFIntervention(:,1);CalFControl(:,1)])./7,'o','MarkerSize',12,...
    'MarkerFaceColor',[1,0.8,0]);
legend([p1,p2,p3],{'Control','Intervention','Mean'})
hold on
% fit poly
[f,gof,output]=fit(bmi,cal,'poly1');
%histogram(output.residuals,1)
idx = cal>4000;
h=plot(f,bmi(~idx),cal(~idx));
set(h, 'LineWidth',2,'MarkerSize',15)
xlabel('Baseline BMI')
ylabel('Baseline Calories')
legend('Participants', 'Fitted line')
set(gca,'fontsize',20)


%% Statistical test
StatsAnalysis;

%% Regression Models
Regression;

%% Classification
%%not doing it cause there's not enough data
Classification;


