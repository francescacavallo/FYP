%%% Preparation of all data %%%
addpath('functions')

% load all spreadsheets
loadData;

nParticipants=size(baseline,1);

% add extra info to baseline struct 
for i=1:nParticipants
    baseline(i).BMI = baseline(i).Weight/(baseline(i).Height/100)^2;
    % group
    num = baseline(i).Code -'0';
    group = num(find(num >= 0 & num < 10, 1));
    switch group
        case 1
            baseline(i).Group=1;
        case 2 
            baseline(i).Group=2;
    end
    % genderID
    switch baseline(i).Gender
        case 'Male'
            baseline(i).genderID = 1;
        case 'Female'
            baseline(i).genderID = 2;
    end
    % ethnicityID
    switch baseline(i).Ethnicity
        case 'White European' 
            baseline(i).ethnicityID = 1;
        case 'South Asian' 
            baseline(i).ethnicityID = 2;
        case 'East Asian'
            baseline(i).ethnicityID = 3;
        case 'Middle Eastern'
            baseline(i).ethnicityID = 4;
    end
    %genotypeID
    switch baseline(i).Genotype
        case 'GG' 
            baseline(i).genotypeID = 1;
        case {'GC','CG'}
            baseline(i).genotypeID = 2;
        case 'CC'
            baseline(i).genotypeID = 3;
    end
end

% add calories per day to each FFQ & replace empty entries with NaN
for i=1:9 % change to 9
    FFQ{i}=processFFQ(FFQ{i},foodCalories,nParticipants);   
    empties = cellfun('isempty',FFQ{i});
    FFQ{i}(empties) = {NaN};
    for n=12:23
        if isnan(FFQ{i}{n,4})
           FFQ{i}{n,4}=1;
        end
    end
end

% fix for vinay
FFQ{6}{7,44}=17250;
FFQ{7}{7,44}=17020;
FFQ{8}{7,44}=12850;
FFQ{9}{7,44}=15350;

% cal baseline leptin 1
% 2+3 = leptin 2
% 4+5 = leptin 3
% 6+0.5*7 = leptin 4
% 0.5*8+9 =leptin 5
                                            % 

% Tidy up measured variables (weight, calories, leptin) 
for i=1:nParticipants
    for j=1:9
    Measurements(i) = struct('Code',Code{i,1},'WeightWeek',WeightWeek{i,:},...
                      'WeightFortn',WeightFortn{i,:},'CaloriesWeek',...
                      CaloriesWeek{i,:},'CaloriesFortn',CaloriesFortn{i,:},...
                      'Leptin',Leptin{i,:});
    end
end
       

% delete tmp variables 
clear Code WeightWeek WeightFortn CaloriesWeek CaloriesFortn Leptin
clear baseSheet
clear i j num group n
clear tmp empties



