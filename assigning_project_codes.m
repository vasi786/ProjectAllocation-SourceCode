clc;clear

[num,txt] = xlsread('students-choices.xlsx');
%txt = string(txt);

[num2,txt2] = xlsread('prof_list-keywords.xlsx');
%%
%Need to write every thing in generic form. I am writing for this particular example
proj = 'proj';
txt = [txt(:,2) txt(:,5:14)]

txt2 = txt2(2:end,end);
[N_students,total_choices] = size(txt);


%for i = 2: N_students   % First column is titles
i = 2;
    for j = 2:total_choices
        %txt_char(i,j) = {char(txt(i,j));}
        for k = 1:length(txt2)
            result(k) = ~cellfun('isempty',regexpi(txt(i,j),txt2(k)));
            if result(k) == 1
                storing(j) = k;
                repeated = cellstr(num2str((sum(storing(:)== k))));
                txt(2,j) = append(txt2(k),proj,repeated);
                %continue
                
            end
            
        end
        
    end
    
    txt (2,2)
    
