clc;clear;
tic
% filename1 = 'students-choices';
% filename2 = 'prof_list-keywords.xlsx';
assigning_project_codes;
%% Extracting the data and comparing the roll no's of CGPA excel file and choices file


[num_sort,txt_sort] = xlsread('./name_CGPA_2');
txt_headers = string(txt_sort(1,:));   % First row contains headings

button = 'NAME';
button_2 = 'CGPA';
button_3 = 'roll no';

for i = 1: length(txt_headers)
    if strcmpi(txt_headers(i),button)
        disp(['The candidate name column is : (', num2str(i),')']);
        name_column = i;
    elseif strcmpi(txt_headers(i),button_2)
        disp(['The CGPA column is : (', num2str(i),')']);
        CGPA_column = i;
        
    elseif strcmpi(txt_headers(i),button_3)
        disp(['The Roll no column is : (', num2str(i),')']);
        Roll_no_column = i;
    end
end

Roll_nos_CGPA = num_sort(:,Roll_no_column);  % Roll_nos_CGPA mean the roll nos are taken from CGPA file.

CGPA = num_sort(:,CGPA_column);

roll_and_CGPA = [Roll_nos_CGPA CGPA];

for i = 1: length(Roll_nos_choices)
    
    if Roll_nos_choices(i) == Roll_nos_CGPA(i)
        
        sprintf('Roll no %.f ,matched in both files',Roll_nos_choices(i));
    else
        Error_Prone = sprintf('Info about Roll no %.f or %.f are missing in either one of the file',Roll_nos_choices(i),Roll_nos_CGPA(i))
        error('Error, exiting');
    end
    
end

original_proj_list = txt3;

%%   Recommendations GUI

Roll_nos_GUI = 'kfjhsedh';  % something which doesn't clash at all.

%uiwait(app.UIfigure);
%%%%%%% Recommendations GUI%%%%%%%%%%%%%
APPINFO = matlab.apputil.install('./APPS/Recommendations');
matlab.apputil.run('RecommendationsAPP')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

while strcmpi(Roll_nos_GUI,'kfjhsedh') == 1
    pause(1)
end


[N_students,txt,txt3,roll_and_CGPA] = ...
    recommendations_fn(Roll_nos_GUI,Projnames_GUI,txt3,...
    txt,N_students,roll_and_CGPA)


%% Calling sorting_CGPA function and extracting variables
[sorted_details,sorted_txt] = Sorting_CGPA(roll_and_CGPA,txt);  % Calling sorting CGPA function file.

sorted_Roll_nos = sorted_details(:,2);
sorted_CGPA = sorted_details(:,3:4);
%% Calling some handy functions

delproj = @removingproj; % [sorted_txt] = removingproj (same_CGPA_project,sorted_txt,N_students)
assign = @assignment;
recommend = @recommendations_fn;

%% Actual allocation is done here

[total_choices,~] = size(original_proj_list);
[N_students,~] = size(sorted_txt);


original_sorted_CGPA = sorted_CGPA;

Assigned_proj_nos = zeros(N_students,2);
Student_no = 1;
No_duplicate = 0;
stored_index = 0;
Already_computed = zeros(1,50);

while true
    
    if original_sorted_CGPA(Student_no,2) ~= 0
        
        [No_of_same_choice_students,Assigned_proj_roll_nos_fromCGPA,...
            No_duplicate,sorted_txt,txt3,message,stored_index,sorted_CGPA,Already_computed] ...
            =  same_CGPA(sorted_CGPA,sorted_txt,sorted_Roll_nos,...
            txt3,N_students,total_choices,original_sorted_CGPA,No_duplicate,stored_index,Student_no,Already_computed);
        
        if isequal(message,'Direct_assignment')
            
            Assigned_proj_roll_nos(Student_no,1:2) = Assigned_proj_roll_nos_fromCGPA
            
        elseif isequal(message,'Gate_Direct_assignment')
            Assigned_proj_roll_nos(Student_no:Student_no+No_of_same_choice_students-1,1:2)...
                = Assigned_proj_roll_nos_fromCGPA
            
        else
            
            Assigned_proj_roll_nos(Student_no:Student_no+No_of_same_choice_students-1,1:2)...
                = Assigned_proj_roll_nos_fromCGPA
        end
        if  isequal(message,'Direct_assignment')
            
            Student_no = Student_no + 1;
            
        elseif  isequal(message,'NaN')
            
            Student_no = Student_no + No_of_same_choice_students;
            
        else
            
            Student_no = Student_no + No_of_same_choice_students;
            
        end
        
        
    else
        
        
        his_choice = sorted_txt(Student_no,2);
        
        for j = 1 : total_choices
            if contains(his_choice,txt3(j,2))
                Assigned_proj_roll_nos(Student_no,:) = string([txt3(j,2) sorted_Roll_nos(Student_no)])
                sorted_txt = delproj(txt3(j,2),sorted_txt,N_students); %call removing project from sorted_txt
                txt3(j,2) = {'Assigned'};
                j = 1;
                Student_no = Student_no+1
                break
            end
        end
        
        
    end
    
    
    %% Keeping track of student numbers and this para should be at last of this main for loop
    
    if Student_no > N_students
        break
    end
    
end

[N_students,total_choices] = size(sorted_txt);

Assigned_proj_roll_nos
toc
% [original_proj_list txt3(:,2)]