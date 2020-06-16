function [winner] = GateScore_decision(clashed_labels)
% read Gatescore excel file
[nu,tx] = xlsread('GATE_Score');
D = zeros(length(tx),1);
% converting Gatescore from the char to numeric
for i=1:length(tx)
    d = str2num(char(tx(i,3)));
    if isempty(d)
        D(i)=0;
    else
        D(i)=d;
    end
end
ind1 = find(strcmpi(tx(:,2),clashed_labels(1)));
ind2 = find(strcmpi(tx(:,2),clashed_labels(2)));
% Get only first element in "ind1" and "ind2",
% trust me, there are some duplicates
ind1 = ind1(1); ind2 = ind2(1);
if D(ind1) >= D(ind2)
    winner = char(tx(ind1,2));
else
    winner = char(tx(ind2,2));
end

end

