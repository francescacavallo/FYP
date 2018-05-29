
%%% Load spreadsheets

% load baseline info
baseSheet = readtable("../spreadsheets/BaselineInfo.xlsx");
baseline = table2struct(baseSheet);

% load data from FFQs
FFQ = cell(1,9);
tmp = readtable("../spreadsheets/FFQsorted.xlsx",'Sheet','FFQ1');
FFQ{1} = table2cell(tmp);
tmp = readtable("../spreadsheets/FFQsorted.xlsx",'Sheet','FFQ2');
FFQ{2} = table2cell(tmp);
tmp = readtable("../spreadsheets/FFQsorted.xlsx",'Sheet','FFQ3');
FFQ{3} = table2cell(tmp);
tmp = readtable("../spreadsheets/FFQsorted.xlsx",'Sheet','FFQ4');
FFQ{4} = table2cell(tmp);
tmp = readtable("../spreadsheets/FFQsorted.xlsx",'Sheet','FFQ5');
FFQ{5} = table2cell(tmp);
tmp = readtable("../spreadsheets/FFQsorted.xlsx",'Sheet','FFQ6');
FFQ{6} = table2cell(tmp);

% load food categories and corresponding calories per portion
foodCalories = readtable("../spreadsheets/foodCalories.xlsx");
foodCalories = table2cell(foodCalories);

% load data from Measurements spreadsheet    
Code = readtable("../spreadsheets/Measurements.xlsx",'Sheet','Code');
WeightWeek = readtable("../spreadsheets/Measurements.xlsx",'Sheet','W1');
WeightFortn = readtable("../spreadsheets/Measurements.xlsx",'Sheet','W2');
CaloriesWeek = readtable("../spreadsheets/Measurements.xlsx",'Sheet','C1');
CaloriesFortn = readtable("../spreadsheets/Measurements.xlsx",'Sheet','C2');
Leptin = readtable("../spreadsheets/Measurements.xlsx",'Sheet','L');