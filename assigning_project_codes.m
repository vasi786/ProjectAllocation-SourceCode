function [Roll_nos_choices,txt,txt3] = assigning_project_codes(num,txt,num2,txt2)
tic
[num,txt] = xlsread(filename1);
[num2,txt2] = xlsread(filename2);
txt_headers = string(txt(1,:));   % First row contains headings
button = 'Roll No'

for i = 1: length(txt_headers)
    if strcmpi(txt_headers(i),button)
      % disp(['The Roll no column is : (', num2str(i),')'])
        Roll_no_column = i;
    end
end

Roll_nos_choices = num(:,Roll_no_column) % Roll numbers
%% To be erased
match = (1:length(txt)) + ". ";
match2 = (1:length(txt)) + " ";
match3 = (1:length(txt)) + ".";
clear k;
%%
%Need to write every thing in generic form. I am writing for this
%particular example  taken care of just 10 students
proj = 'proj';

txt = [txt(:,2) txt(:,5:end)];
txt = erase(txt,match);
txt = erase(txt,match2);
txt = erase(txt,match3);
txt2 = txt2(2:end,end);
[N_students,total_choices] = size(txt);
clc

%for i = 2: N_students   % First column is titles
i = 2;   % For first student, It is written to save the project names.
m = 1;
for j = 2:total_choices % first column is titles
    
    for k = 1:length(txt2)
        
        result(k) = ~cellfun('isempty',regexpi(txt(i,j),txt2(k)));
        
        if result(k) == 1
            storing(j) = k;
            repeated = cellstr(num2str((sum(storing(:)== k))));
            append_sub = {char(txt2(k)+"proj"+repeated)};% If append doesn't work for our version
            %append(txt2(k),proj,repeated)
            choic_no = j - 1;
            txt3{m,1} = char(txt(i,j));
%             txt3{m,2} = char(append(txt2(k),proj,repeated));
            txt3{m,2} = char(append_sub);% If append doesn't work for our version
            %txt(i,j) = append(txt2(k),proj,repeated);
            txt(i,j) = append_sub; % If append doesn't work for our version
            break
        end
    end
    
    if strlength(txt(i,j)) > 20
        Message = sprintf('It is observed that the professor name is misspelled or used a surname \ninstead of last name')
        project_name = string(txt(2,j));
        Fix = sprintf('The professor name and project is as follows: \n%s',project_name)
        Example = sprintf('If the name of the prof A.PR. Thorne, then consider Thorne')
        prompt{1} = ('Enter the correct name of the professor');
        prompt{2} = ('Specify the row number of that professor in the prof_list-keywords.xlsx file');
        name1 = 'Updated Professor Name';
        name2 = 'Row Number';
        new_name =(inputdlg(prompt{1},name1, [1 50]));
        Row_num =(inputdlg(prompt{2},name2, [1 50]));
        location = char({char("B"+char(Row_num))}) %append('B',Row_num));
        xlswrite('prof_list-keywords.xlsx',new_name,1,location)
        error('Error in Professor name and excel sheet updated as per your need,try running the prog again')
    end
    m = m+1;
end

clear k
clear repeated
clear result
clear storing
clear repeated
clear choic_no
clc


for i = 3:N_students
    
    for j = 2:total_choices
        for k = 1: length(txt3)
            if contains(string(txt(i,j)),txt3(k,1))
                txt(i,j) = txt3(k,2);
                txt(i,j)
                break
            else
                continue
            end
        end
    end
end

toc
end
