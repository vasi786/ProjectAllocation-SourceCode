function [winner,I] = GateScore_decision(clashed_Roll_nos)  % nu variable contains only rolls and Gate score
% read Gatescore excel file

%[nu,tx] = importdata('Student details.csv');
nu = getappdata(0,"nu");
%nu = nu.data;

for i = 1: length(clashed_Roll_nos)
    
person_clashed_row(i,1) = find(nu(:,1) == clashed_Roll_nos(i));
prewinner(i,:) = nu(person_clashed_row(i,1),:);

end

[~,I] = sort(prewinner(:,2),'descend');

winner = prewinner(I,:);



% D = zeros(length(tx),1);
% % converting Gatescore from the char to numeric
% for i=1:length(tx)
%     d = str2num(char(tx(i,3)));
%     if isempty(d)
%         D(i)=0; % need to give a warning saying that the entry is null.
%     else
%         D(i)=d;
%     end
% end
% ind1 = find(strcmpi(tx(:,2),clashed_Roll_nos(1)));
% ind2 = find(strcmpi(tx(:,2),clashed_Roll_nos(2)));
% % Get only first element in "ind1" and "ind2",
% % trust me, there are some duplicates
% ind1 = ind1(1); ind2 = ind2(1);
% if D(ind1) >= D(ind2)
%     winner = char(tx(ind1,2));
% else
%     winner = char(tx(ind2,2));
% end

end
