function [FFQ] = processFFQ(FFQ,foodCalories,nParticipants)

% adds calories per day for each subject
frequencies = ["Never","Once a week","2-4 per week","5-6 per week",...
               "Once a day","2-3 per day","4-5 per day","6+ per day"];
frequenciesInt = [0 1 3 5.5 7 15 31 43];

recomm = ["0-10%: almost nothing","10-30%: only few","30-50%: half and half", ...
          "50-70%: mostly all recommended food","70-100%: exclusively recommended foods"];
recommInt = [1 2 3 4 5];

eatOutFreq = ["Every meal","Once a day", "Three times a week",...
                          "Once a week", "Never"];
eatOutFreqInt = [28 7 3 1 0];

caloriesWeek=zeros(nParticipants,1);

for i=1:nParticipants
    if ~isnan(FFQ{i,2}) && ~strcmp(FFQ{i,3},'No')
        
        % convert recommended food used into double
        FFQ{i,4}=convertRecomm(recomm,recommInt,FFQ{i,4});
        
        for j=6:43 % for each food category
            conversion = convertFreq(frequencies,frequenciesInt,FFQ(i,j));
            caloriesWeek(i) = caloriesWeek(i) + foodCalories{j-5,2}*conversion;
            %replace frequency string with double
            FFQ{i,j}=conversion;
        end

        % multiply by eating out factor 1.17
        eatOutFactor=1.17;
        weeklyMeals = 28;
        eatOut = convertFreq(eatOutFreq,eatOutFreqInt,FFQ(i,5));
        homemade = weeklyMeals-eatOut;
        caloriesWeek(i) = (caloriesWeek(i)/weeklyMeals)*(homemade+eatOut*eatOutFactor);

        %put into last column of FFQ
        FFQ{i,44} = caloriesWeek(i);
    end
end


end


function [conversion] = convertRecomm(recomm,recommInt,input)
tot=length(recommInt);
for i=1:tot
    if strcmp(input,recomm(i))
        conversion=recommInt(i);
        break
    end
end
end


function [output] = convertFreq(frequencies,frequenciesInt,string)

tot=length(frequenciesInt);
for i=1:tot
    if strcmp(string,frequencies(i))
        output=frequenciesInt(i);
        break
    end
end

end


