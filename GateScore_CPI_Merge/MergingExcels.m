% Reading CSV files
clc; clear all;
CPI = readtable('CPI.xlsx', 'Range' , 'A:C');
GateScore = readtable('GATE_Score.xlsx','Range','B:C');

T = cell2table(cell(69,1))

for i = 1:height(CPI)
    A = string(CPI{i,2});
    for j = 1:height(GateScore)
        B = string(GateScore{j,1});         
    if (strcmpi(A,B) == 1)
        T.Var1(i) = table2cell(GateScore(j,2));
    end
    end
end

MergedList = [CPI T];