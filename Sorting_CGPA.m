clc;
function [sorted_details,sort_index,sorted_Roll_nos,sorted_CGPA] = Sorting_CGPA(num_sort,txt_sort)

%#################### Sorting CGPA and Roll no's accordingly##############

[num_sort,txt_sort] = xlsread('name_CGPA_2');  % importing the file

txt_headers = string(txt_sort(1,:));   % First row contains headings

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

CGPA = num_sort(:,CGPA_column);

[sorted_CGPA,sort_index] = sort(CGPA,'descend');


%%%%%%%%%%%%%%%%%%%%%% adding seperate column to differentiate same CGPA %%
a = sorted_CGPA;
[ii,jj,kk]=unique(a);
repeated=ii(histc(kk,1:numel(ii))>1);


k = 1;

while true
    for i = 1: length(a)
        for j = i:length(a)
            if repeated(k) == a(j)
                a(j,2) = k;
            end
            
        end
    end
    k = k + 1;
    
    if k > length(repeated)
        break
    end
end

clear k 
clear repeated
clear i 
clear j

sorted_CGPA = a;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Roll_nos_CGPA = num_sort(:,Roll_no_column);

sorted_Roll_nos = Roll_nos_CGPA(sort_index,:);
format longG

IA = [sorted_Roll_nos (1:length(sorted_Roll_nos))']; % IA is for index assignment (input for a getindex function file)

sorted_details = [sort_index sorted_Roll_nos sorted_CGPA];
%########################################################################
end
