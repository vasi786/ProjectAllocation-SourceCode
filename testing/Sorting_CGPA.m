
function [sorted_details,sorted_txt] = Sorting_CGPA(roll_and_CGPA,txt)

clc;

CGPA = roll_and_CGPA(:,2);
Roll_nos_tobe_sorted  = roll_and_CGPA(:,1);
[sorted_CGPA,sort_index] = sort(CGPA,'descend');



%%%%%%%%%%%%%%%%%%%%%% adding seperate column to differentiate same CGPA %%
a = sorted_CGPA;
[ii,~,kk]=unique(a);
repeated=ii(histc(kk,1:numel(ii))>1);

repeated = sort(repeated,'descend');
if repeated > 0
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
    
else
    a(:,2) = 0;
end

sorted_CGPA = a
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Roll_nos_CGPA = num_sort(:,Roll_no_column);

sorted_Roll_nos = Roll_nos_tobe_sorted(sort_index,:);
format longG

sorted_details = [sort_index sorted_Roll_nos sorted_CGPA];

txt_without_headings = txt(1:end,:);
sorted_txt = txt_without_headings(sort_index,:);
end
%########################################################################




