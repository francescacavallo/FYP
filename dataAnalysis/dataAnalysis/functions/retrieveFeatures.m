function [features] = retrieveFeatures(baseline, nParticipants)
%% Participants features
features = struct;
% gender
features.totMales=0;
features.totFemales=0;
% age
features.totOld=0; %>50yrs
features.totYoung=0; %<50yrs
% ethnicity
features.totEurope=0;
features.totEastAsia=0;
features.totSouthAsia=0;
features.totMidEast=0;
% genotype
features.totIncr=0;
features.totDecr=0;
% BMI & gender
features.totOverFemales=0;
features.totOverMales=0;
features.totUnderFemales=0;
features.totUnderMales=0;
features.totNormFemales=0;
features.totNormMales=0;

for i=1:nParticipants
    %gender
    if strcmp(baseline(i).Gender, 'Male')
        features.totMales=features.totMales+1;
    end
    if strcmp(baseline(i).Gender,'Female')
        features.totFemales=features.totFemales+1;
    end
    % age
    if baseline(i).Age > 50
        features.totOld=features.totOld+1;
    end
    if baseline(i).Age < 50
        features.totYoung=features.totYoung+1;
    end
    %Ethnicity
    if strcmp(baseline(i).Ethnicity, 'White European')
        features.totEurope=features.totEurope+1;
    end
    if strcmp(baseline(i).Ethnicity,'East Asian')
        features.totEastAsia=features.totEastAsia+1;
    end
    if strcmp(baseline(i).Ethnicity,'Middle Eastern')
        features.totMidEast=features.totMidEast+1;
    end
    if strcmp(baseline(i).Ethnicity,'South Asian')
        features.totSouthAsia=features.totSouthAsia+1;
    end
    %genotype
    if strcmp(baseline(i).Genotype,'GG')||strcmp(baseline(i).Genotype,'CG')||strcmp(baseline(i).Genotype,'GC')
        features.totIncr=features.totIncr+1;
    end
    if strcmp(baseline(i).Genotype,'CC')
        features.totDecr=features.totDecr+1;
    end
    %BMI & gender
    if strcmp(baseline(i).Gender,'Female')
        if baseline(i).BMI < 18.5
            features.totUnderFemales=features.totUnderFemales+1;
        end
        if baseline(i).BMI > 18.5 && baseline(i).BMI < 25
            features.totNormFemales=features.totNormFemales+1;
        end
        if baseline(i).BMI > 25
            features.totOverFemales=features.totOverFemales+1;
        end
    end
    if strcmp(baseline(i).Gender,'Male')
        if baseline(i).BMI < 18.5
            features.totUnderMales=features.totUnderMales+1;
        end
        if baseline(i).BMI > 18.5 && baseline(i).BMI < 25
            features.totNormMales=features.totNormMales+1;
        end
        if baseline(i).BMI > 25
            features.totOverMales=features.totOverMales+1;
        end
    end
end

tmp=struct2cell(baseline);

features.meanAge=mean(cell2mat(tmp(3,:)));
features.stdAge=std(cell2mat(tmp(3,:)));

features.meanWeight=mean(cell2mat(tmp(4,:)));
features.stdWeight=std(cell2mat(tmp(4,:)));

features.meanHeight=mean(cell2mat(tmp(5,:)));
features.stdHeight=std(cell2mat(tmp(5,:)));

features.meanBMI=mean(cell2mat(tmp(8,:)));
features.stdBMI=std(cell2mat(tmp(8,:)));

%features.meanLeptin=mean(baseline.Leptin);
%features.stdLeptin=std(baseline.Leptin);
end

