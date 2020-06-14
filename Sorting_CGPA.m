clc;clear

%#################### Sorting CGPA and Roll no's accordingly##############

[num,txt] = xlsread('Name_CPI');  % importing the file

txt_headers = string(txt(1,:));   % First row contains headings

button = 'NAME'
button_2 = 'CGPA'
button_3 = 'roll no'

for i = 1: length(txt_headers)
    if strcmpi(txt_headers(i),button)
        disp(['The candidate name column is : (', num2str(i),')'])
        name_column = i;
    elseif strcmpi(txt_headers(i),button_2)
        disp(['The CGPA column is : (', num2str(i),')'])
        CGPA_column = i;
        
    elseif strcmpi(txt_headers(i),button_3)
        disp(['The Roll no column is : (', num2str(i),')'])
        Roll_no_column = i;
    end
end

CGPA = str2double((txt(2:end,CGPA_column)));

[sorted_CGPA,sort_index] = sort(CGPA,'descend');

Roll_nos = str2double((txt(2:end,Roll_no_column)));

sorted_Roll_nos = Roll_nos(sort_index,:);
format longG

sorted_details = [sorted_Roll_nos sorted_CGPA]
%########################################################################

