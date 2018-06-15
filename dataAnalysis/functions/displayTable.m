function table = displayTable(array, type)
table = array2table(array, ...
    'VariableNames',{'GenderID','Age','Weight','BMI','EthnicityID','GenotypeID','Leptin'},...
    'RowNames',{'GenderID','Age','Weight','BMI','EthnicityID','GenotypeID','Leptin'});
name = [num2str(type), ' Coefficients'];
disp(name)
disp(table)
end
