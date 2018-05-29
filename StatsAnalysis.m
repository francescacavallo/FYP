%%%%%%% Statistical Analysis %%%%
addpath('boundtheline')
addpath('boundtheline/Inpaint_nans')
addpath('boundtheline/boundedline')
addpath('boundtheline/catuneven')
addpath('boundtheline/singlepatch')

%% Correlation with personal info
% correlate leptin1 to personal info (both groups together)

% Create an input matrix containing the sample data. 
personal = [baseline.genderID; baseline.Age; baseline.Weight; baseline.BMI; baseline.ethnicityID; baseline.genotypeID; baseline.Leptin]';
[rho,pval] = partialcorr(personal);
rho = displayTable(rho, 'Correlation');
pval = displayTable(pval, 'P Value');

% save results to excel 
delete 'baselineCorrelation.xlsx';
filename = 'baselineCorrelation.xlsx';
writetable(rho,filename,'Sheet','Rho','WriteRowNames',true)
writetable(pval,filename,'Sheet','Pval','WriteRowNames',true)

%% Comparison of mean

% get leptin from measurements struct
[leptinControl, leptinIntervention]=getmeasure(Measurements,'leptin');

% check for normality
hNormInt = kstest(leptinControl);
hNormContr = kstest(leptinIntervention);
if hNormInt+hNormContr==0
    disp("Both groups are normally distributed")
end
if hNormInt*hNormContr==1
    disp("Cannot assume normal distribution")
end
fprintf('\n')

% leptin of intervention at week 0 VS at week 8
disp('Paired ttest for intervention samples 1 VS 5')
compareMean(leptinIntervention(:,1),leptinIntervention(:,5),'paired');
fprintf('\n')    

% leptin of control VS intervention at each sample
    % there should not be difference in the 2 means at baseline, but there
    % should be at week 8
for sample=1:5
    name=['Ttest for intervention VS control at sample',num2str(sample)];
    disp(name)
    compareMean(leptinIntervention(:,sample),leptinControl(:,sample),'2sample');   
    fprintf('\n')
end

% boxplot for leptin at baseline
figure
boxplot([baseline.Leptin],[baseline.Group],'Notch','on','Labels',{'Control','Intervention'})
ylabel('Salivary leptin (pg/ml)')
set(gca,'fontsize',12)

% boxplot for leptin at week 8
figure
leptin5=[leptinControl(:,5); leptinIntervention(:,5)];
boxplot(leptin5,[baseline.Group],'Notch','on','Labels',{'Control','Intervention'})
ylabel('Salivary leptin (pg/ml)')
set(gca,'fontsize',12)


% Plot
    %%%%% can't really do a fit cause x is discrete variable
    % average trend of leptin for control group (scatter with fit)
%     figure
%     for sample=1:5
%         x(:,sample) = sample*ones(11,1);
%         p(sample)=plot(x(:,sample),leptinControl(:,sample),'*');
%         hold all
%     end
%     [curve,gof] = nonlinearFit(x(1,:),leptinControl,2); % fit non linear function to data
%     fit = plot(curve);
%     legend([fit,'Fit with gof = ', num2str(gof)])
%     ylabel('Salivary leptin (pg/ml)')
%     names = {'Week 0'; 'Week 2'; 'Week 4'; 'Week 6'; 'Week 8'};
%     set(gca,'xtick',[1:5],'xticklabel',names)
%     set(gca,'fontsize',12)

    % average trend of leptin for intervention group (scatter with fit)
    
    
% mean with confidence intervals trend of leptin for intervention group and control (on same
% plot) (estimating parameters from normal distribution)
[meanControl, stdControl, muCIControl, stdCIControl]=normfit(leptinControl);
[meanInterv, stdInterv, muCIInterv, stdCIInterv]=normfit(leptinIntervention);
plotMean(meanInterv,muCIInterv)
plotMean(meanControl,muCIControl)

figure
plot(meanControl,'lineWidth',2) 
hold on
plot(meanInterv,'lineWidth',2) 
leptinlegend
legend('Control', 'Intervention')
    
%% Relation with weight & calories
% get weight from measurements
[WeightFControl, WeightFIntervention]=getmeasure(Measurements,'weightF');
[CalFControl, CalFIntervention]=getmeasure(Measurements,'caloriesF');

% visualise weight VS leptin 
% at week 0
week = [1,5];
for i=1:2
    figure
    sample = week(i);
    scatter(WeightFIntervention(:,sample),leptinIntervention(:,sample),'b*')
    hold on
    scatter(WeightFControl(:,sample),leptinControl(:,sample),'r*')
    ylabel('Salivary Leptin (pg/ml)')
    xlabel('Weight (kcal)')
    set(gca,'fontsize',12)
    legend('Intervention', 'Control')
    title(['Measured at Week ',num2str((week(i)-1)*2)])
end
%%%%%% quantify separability of points: median distance between points %%% 


% visualise calories VS leptin 
% at week 0 and 8, interv VS control
week = [1,5];
for i=1:2
    figure
    sample = week(i);
    scatter(CalFIntervention(:,sample),leptinIntervention(:,sample),'b*')
    hold on
    scatter(CalFControl(:,sample),leptinControl(:,sample),'r*')
    ylabel('Salivary Leptin (pg/ml)')
    xlabel('Calories (kcal)')
    set(gca,'fontsize',12)
    legend('Intervention', 'Control')
    title(['Measured at Week ',num2str((week(i)-1)*2)])
end

% Correlation of leptin with calories, weight and genotype
genotype_tmp = [baseline.genotypeID,baseline.genotypeID,baseline.genotypeID,baseline.genotypeID,baseline.genotypeID];
data = [Measurements.Leptin; Measurements.WeightFortn; Measurements.CaloriesFortn; genotype_tmp]';
[rho_data,pval_data] = partialcorr(data,'Rows','pairwise');
rho_data = displayTable2(rho_data, 'Correlation');
pval_data = displayTable2(pval_data, 'P Value');

% save results to excel 
delete 'MeasurementsCorrelation.xlsx';
filename = 'MeasurementsCorrelation.xlsx';
writetable(rho,filename,'Sheet','Rho','WriteRowNames',true)
writetable(pval,filename,'Sheet','Pval','WriteRowNames',true)


%% Correlation leptin with amount of recommended food 
% get recommended food at sample
food =zeros(1,60);
sample = [1 3 5 7 9];
for i=1:3 %%%%% to 5
    idx = sample(i);
    for n=12:23
        food((n-11)*i) = [FFQ{idx}{n,4}];
    end
end

recomm_tmp = [food; Measurements(12:23).Leptin]'; % only for intervention
[rho_rec,pval_rec] = corr(recomm_tmp);
rho_rec = displayTable3(rho_rec, 'Correlation');
pval_rec = displayTable3(pval_rec, 'P Value');

% save results to excel 
delete 'RecommendedCorrelation.xlsx';
filename = 'RecommendedCorrelation.xlsx';
writetable(rho,filename,'Sheet','Rho','WriteRowNames',true)
writetable(pval,filename,'Sheet','Pval','WriteRowNames',true)

    
    
%% %%%%%%%%% functions %%%%%
function table = displayTable(array, type)
table = array2table(array, ...
    'VariableNames',{'GenderID','Age','Weight','BMI','EthnicityID','GenotypeID','Leptin'},...
    'RowNames',{'GenderID','Age','Weight','BMI','EthnicityID','GenotypeID','Leptin'});
name = [num2str(type), ' Coefficients'];
disp(name)
disp(table)
end

function table = displayTable2(array, type)
table = array2table(array, ...
    'VariableNames',{'Leptin','Weight','Calories','GenotypeID'},...
    'RowNames',{'Leptin','Weight','Calories','GenotypeID'});
name = [num2str(type), ' Coefficients'];
disp(name)
disp(table)
end

function table = displayTable3(array, type)
table = array2table(array, ...
    'VariableNames',{'Leptin','Food'},...
    'RowNames',{'Leptin','Food'});
name = [num2str(type), ' Coefficients'];
disp(name)
disp(table)
end

function [curve,gof] = nonlinearFit(xvals,yvals,n)
   fo = fitoptions('Method','NonlinearLeastSquares',...
               'Lower',[0,0],...
               'Upper',[Inf,max(xvals)],...
               'StartPoint',[1 1]);
    ft = fittype('a*(x-b)^n','problem','n','options',fo);
    [curve,gof] = fit(xvals',yvals,ft,'problem',n);
end


function plotMean(mean,CI)
    figure
    hold all
    plot(mean,'lineWidth',2) 
    plot(CI', 'r--','lineWidth',2)
    leptinlegend
    legend('Mean Leptin', '95% Confidence Intervals')
end

function leptinlegend
ylabel('Salivary leptin (pg/ml)')
names = {'Week 0'; 'Week 2'; 'Week 4'; 'Week 6'; 'Week 8'};
set(gca,'xtick',[1:5],'xticklabel',names)
set(gca,'fontsize',12)
end