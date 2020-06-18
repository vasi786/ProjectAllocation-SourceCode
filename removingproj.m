%%%%% Function file for removing projects when they are assigned %%%%%
function[sorted_txt] = removingproj (same_CGPA_project,sorted_txt,N_students)

for i = 1:N_students-1
    extracted_txt = sorted_txt(i,:);
    extracted_txt(strcmp(extracted_txt,same_CGPA_project)) = [];
    new_sorted_txt(i,:) = extracted_txt;
    clear extracted_txt
end
sorted_txt = new_sorted_txt;
clear new_sorted_txt;
end