function [N_students,Number_of_projs_floated_coded]= number_of_projs_floated(txt3,N_students)

%load txt3.mat

prof_proj_list  = txt3(:,2);

j = 1;

for  m = 1:length(prof_proj_list)
prof_proj_floated{m,:} = prof_proj_list{m}(1:end-1);
end

while true
    
    same_projs = strncmpi(prof_proj_floated{1},prof_proj_list,strlength(prof_proj_floated{1}));
    same_projs_index = find(strncmpi(prof_proj_floated{1},prof_proj_list,strlength(prof_proj_floated{1})));
    Number_of_projs_floated(j,:) = [prof_proj_floated{1}(1:end-4) string(sum(same_projs))];
    Number_of_projs_floated_coded(j,:) = [prof_proj_floated{1} string(sum(same_projs))];
    prof_proj_list(same_projs_index) = [];
    prof_proj_floated(same_projs_index) = [];
   j = j + 1;
    if size(prof_proj_list,1) <1
        break
    end
end
Number_of_projs_floated;

[~,full] =xlsread('prof_list-keywords.xlsx');

full_prof_names = full(:,1);
prof_codes = string(full(:,2));

for i = 1:length(Number_of_projs_floated)
    prof_index(i) = find(strncmpi(Number_of_projs_floated(i,1),prof_codes,strlength(Number_of_projs_floated(i,1))));
end
Number_of_projs_floated(:,1) = full_prof_names(prof_index);
Number_of_projs_floated2 = [Number_of_projs_floated Number_of_projs_floated(:,2)];
Number_of_projs_floated2 = ["a1","a2","a3";Number_of_projs_floated2];
writematrix(Number_of_projs_floated2,'FinalAssignedStatus.xls');
Total_no_projects = sum(str2double(Number_of_projs_floated(:,2)));
N_students
end

%save('projs_floated.mat')
