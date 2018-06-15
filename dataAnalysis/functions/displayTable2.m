
function table = displayTable2(array, type)
table = array2table(array, ...
    'VariableNames',{'Leptin','Weight','Calories','GenotypeID'},...
    'RowNames',{'Leptin','Weight','Calories','GenotypeID'});
name = [num2str(type), ' Coefficients'];
disp(name)
disp(table)
end
