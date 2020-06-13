clc;clear

[num,txt] = xlsread('students-choices.xlsx');
%txt = string(txt);

[num2,txt2] = xlsread('prof_list-keywords.xlsx');
%%
%Need to write every thing in generic form. I am writing for this particular example
proj = 'proj';
txt = [txt(:,2) txt(:,5:end)]

txt2 = txt2(2:end,end);
[N_students,total_choices] = size(txt);

clc;
%for i = 2: N_students   % First column is titles
i = 2;   % For first student, It is written to save the project names.

for j = 2:total_choices
    
    for k = 1:length(txt2)
        
        result(k) = ~cellfun('isempty',regexpi(txt(i,j),txt2(k)));
        
        if result(k) == 1
            storing(j) = k;
            repeated = cellstr(num2str((sum(storing(:)== k))));
            append(txt2(k),proj,repeated)
            choic_no = j - 1
            txt(2,j) = append(txt2(k),proj,repeated);
            break
        end
        
    end
    
    if strlength(txt(2,j)) > 20
        Message = sprintf('It is observed that the professor name is misspelled or used a surname instead of last name')
        Fix = sprintf( 'go to choice no: %f and check for the correct/actual name',choic_no+1)
        Example = sprintf('If the name is prof A.PR. Thorne, then consider Thorne')
        prompt{1} = ('Enter the correct name of the professor');
        prompt{2} = ('Specify the row number of that professor in the prof_list-keywords.xlsx file');
        name1 = 'Updated Professor Name';
        name2 = 'Row Number';
        new_name=(inputdlg(prompt{1},name1, [1 50]));
        Row_num=(inputdlg(prompt{2},name2, [1 50]));
        location = char(append('B',Row_num));
        xlswrite('prof_list-keywords.xlsx',new_name,1,location)
        error('Error in Professor name')
    end
    
    clear k
    clear repeated
    
end
clc;
