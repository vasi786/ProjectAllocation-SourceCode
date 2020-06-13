clc;clear

[num,txt] = xlsread('students-choices.xlsx');
txt = string(txt);

[num2,txt2] = xlsread('prof_list-keywords.xlsx');
%%
%Need to write every thing in generic form. I am writing for this particular example

txt = [txt(:,2) txt(:,5:14)]

txt2 = txt2(2:end,end);
[N_students,total_choices] = size(txt);

for i = 2: N_students   % First column is titles
    for j = 2:total_choices
        txt_char(i,j) = {char(txt(i,j));}
        for k = 1:length(txt2)
            result(k) = ~cellfun('isempty',regexpi(txt_char(i,j),txt2(k)));
            if result(k) == 1 
                
        end
        
    end
    
end

txt (2,2)

