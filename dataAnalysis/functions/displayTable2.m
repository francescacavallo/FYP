
function table = displayTable2(array, type)
table = array2table(array, ...
    'VariableNames',{'Leptin','BMI','Calories','GenotypeID'},...
    'RowNames',{'Leptin','BMI','Calories','GenotypeID'});
name = [num2str(type), ' Coefficients'];
disp(name)
disp(table)
end
