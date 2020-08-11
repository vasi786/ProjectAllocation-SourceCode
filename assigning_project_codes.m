
function [Roll_nos_choices,txt3,N_students,txt,txt_for_recommend] = assigning_project_codes(num,txt)

%[num,txt] = xlsread('Choice List _MTP_2019');

txt_headers = txt(1,:);   % First row contains headings

button = {'choice'};
button_2 = 'name';
button_3 = 'roll no';

for i = 1: length(txt_headers)
    if ~cellfun('isempty',regexpi(txt_headers(i),button))
        disp(['The choices starts from column number ', num2str(i),''])
        choice_column = i;
        break
        
    elseif ~cellfun('isempty',regexpi(txt_headers(i),button_2))
        disp(['The student names are in the column ', num2str(i),''])
        name_column = i;
        
    elseif ~cellfun('isempty',regexpi(txt_headers(i),button_3))
        disp(['The student roll column is ', num2str(i),''])
        roll_column = i;
    end
    
end



Roll_nos_choices = num(:,roll_column);
[num2,txt2] = xlsread('prof_list-keywords.xlsx'); % Keep it here. 
original_txt2 = txt2;
%% To be erased
% Removes serial numbers in the choices. 
% Ex:   1. Prof. xxxxxxxx-Project_name-yyyyyyyyyyyyyyyyyyyy  removes 1.

match = (1:length(txt)) + ". "; 
match2 = (1:length(txt)) + " ";
match3 = (1:length(txt)) + ".";
clear k;
%%
%Need to write every thing in generic form. I am writing for this
%particular example  taken care of just 10 students
proj = 'proj';


txt = [txt(2:end,name_column) txt(2:end,choice_column:end)];
txt = erase(txt,match);
txt = erase(txt,match2);
txt = erase(txt,match3);
txt2 = txt2(2:end,end);
txt_for_recommend=txt;
txt_for_recommend(:,1) = num2cell(Roll_nos_choices);
[N_students,total_choices] = size(txt);
clc


i = 1;   % For first student, It is written to save the project names.
m = 1;
for j = 2:total_choices % first column is Names
    
    for k = 1:length(txt2)
        
        result(k) = ~cellfun('isempty',regexpi(txt(i,j),txt2(k)));
        
        if result(k) == 1
            storing(j) = k;
            repeated = cellstr(num2str((sum(storing(:)== k))));
            append_sub = {char(txt2(k)+"proj"+repeated)}; % If append doesn't work for our version
            %append(txt2(k),proj,repeated)
            choic_no = j - 1;
            txt3{m,1} = char(txt(i,j));
            txt3{m,2} = char(append(txt2(k),proj,repeated));
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
        new_name=(inputdlg(prompt{1},name1, [1 50]));
        Row_num=(inputdlg(prompt{2},name2, [1 50]));
        %location = char("B"+char(Row_num)); % Instead of append
        location = char(append('B',Row_num));
        xlswrite('prof_list-keywords.xlsx',new_name,1,location)
        error('Error in Professor name. Excel sheet updated as per your need,try running the program again')
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


for i = 2:N_students
    for j = 2:total_choices
        for k = 1: length(txt3)
            if contains(string(txt(i,j)),txt3(k,1))
                txt(i,j) = txt3(k,2);
                break
            else
                continue
            end
        end
    end
end



