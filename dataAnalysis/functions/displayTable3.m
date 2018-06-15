
function table = displayTable3(array, type)
table = array2table(array, ...
    'VariableNames',{'Leptin','Food'},...
    'RowNames',{'Leptin','Food'});
name = [num2str(type), ' Coefficients'];
disp(name)
disp(table)
end