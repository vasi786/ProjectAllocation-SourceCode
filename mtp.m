function mtp(Number_of_projs_floated_coded,...
    Max_proj_allocations,Projnames_GUI,Roll_nos_GUI,...
    original_proj_list,original_sorted_CGPA,...
    sorted_CGPA,sorted_txt,sorted_Roll_nos,txt3,N_students,total_choices)

tic
max_proj_checker = [Number_of_projs_floated_coded(:,1) Max_proj_allocations];
%max_proj_checker = a; % Remove this in the real code
r_students = length(Projnames_GUI);

if r_students > 0
    for a  = 1 : r_students
        proj_code_index = find(strcmpi(original_proj_list(:,1),Projnames_GUI(a)));
        GUI_projs_code(a) = original_proj_list(proj_code_index,2);
    end
    Assigned_proj_roll_with_gui = [GUI_projs_code' Roll_nos_GUI'];
    Recommended_GUI = [GUI_projs_code' Roll_nos_GUI'];
else
    Assigned_proj_roll_with_gui=["NaN" "NaN"];
    Recommended_GUI=["NaN" "NaN"];

end


delproj = @removingproj; % [sorted_txt] = removingproj (same_CGPA_project,sorted_txt,N_students)
assign = @assignment;
recommend = @recommendations_fn;


Assigned_proj_nos = zeros(N_students,2);
Student_no = 1;
No_duplicate = 0;
stored_index = 0;
Already_computed = zeros(1,50);
No_DA = 0;
previous_No_duplicate_new = NaN;
previous_No_duplicate_DA = NaN;

%global proj_sent_no;
proj_sent_no = 0;
%Recommended_GUI_results = [GUI_projs_code' Roll_nos_GUI];
%Assigned_proj_roll_with_gui=["NaN" "NaN"]

save('choices_made_before_allocation.mat');

%load('choices_made_before_allocation.mat');
while true
    
    
    
    if original_sorted_CGPA(Student_no,2) ~= 0
        
        [No_of_same_choice_students,Assigned_proj_roll_nos_fromCGPA,...
            No_duplicate,sorted_txt,txt3,message,stored_index,sorted_CGPA,...
            Already_computed,No_DA,previous_No_duplicate_new,previous_No_duplicate_DA] ...
            = same_CGPA(sorted_CGPA,sorted_txt,sorted_Roll_nos,...
            txt3,N_students,total_choices,original_sorted_CGPA,...
            No_duplicate,stored_index,Student_no,Already_computed,...
            No_DA,previous_No_duplicate_new,previous_No_duplicate_DA,Assigned_proj_roll_with_gui,max_proj_checker);
        
        
        if isequal(message,'Direct_assignment')
            
            Assigned_proj_roll_nos(Student_no:Student_no+No_of_same_choice_students-1,1:2) = Assigned_proj_roll_nos_fromCGPA;
            
        elseif isequal(message,'Gate_Direct_assignment')
            Assigned_proj_roll_nos(Student_no:Student_no+No_of_same_choice_students-1,1:2)...
                = Assigned_proj_roll_nos_fromCGPA;
            
        else
            
            Assigned_proj_roll_nos(Student_no:Student_no+No_of_same_choice_students-1,1:2)...
                = Assigned_proj_roll_nos_fromCGPA;
        end
        if  isequal(message,'Direct_assignment')
            
            Student_no = Student_no + No_of_same_choice_students;
            
        elseif  isequal(message,'NaN')
            
            Student_no = Student_no + No_of_same_choice_students;
            
        else
            
            Student_no = Student_no + No_of_same_choice_students;
            
        end
        
        
    else
        %%%%%%%%%%%%%
        
        %%%%%%%%%%%%%%%
        
        
        
        while true
            
            his_choice = sorted_txt(Student_no,2);
            BeforeOrAfter = 'Before';
            %%%%%%%%%%%%%%%%%%
            single_proj_max_checker = [Assigned_proj_roll_with_gui; [his_choice string(sorted_Roll_nos(Student_no))]];
            
            single_proj_max_checker(strcmp(single_proj_max_checker(:,1),"NaN"),:) = [];
            %%%%%%%%%%%%%%%%%%%%%%
            [sorted_txt,~,tracking_max_projs,~,message_MAX_PROJS3] =...
                max_proj_checker_deleter (single_proj_max_checker,max_proj_checker,N_students,sorted_txt,proj_sent_no,BeforeOrAfter);
            
            if  message_MAX_PROJS3 ~= 'NoneLeft'
                break
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%
        
        
        
        
        
        
        for j = 1 : total_choices
            if contains(his_choice,txt3(j,2))
                Assigned_proj_roll_nos(Student_no,:) = string([txt3(j,2) sorted_Roll_nos(Student_no)]);
                sorted_txt = delproj(txt3(j,2),sorted_txt,N_students); %call removing project from sorted_txt
                j = 1;
                Student_no = Student_no+1;
                break
            end
        end
        txt3 = assign(his_choice,total_choices,txt3);
        
    end
    
    
    %% Keeping track of student numbers and this para should be at last of this main for loop
    
    
    Assigned_proj_roll_nos;
    Assigned_proj_roll_with_gui=[Recommended_GUI;Assigned_proj_roll_nos];
    Assigned_proj_roll_with_gui(strcmp(Assigned_proj_roll_with_gui(:,1),"NaN"),:) = [];
    
    %     for u = x : length(Assigned_proj_roll_with_gui)
    %         Assigned_projs_with_gui_codes{u,1} = Assigned_proj_roll_with_gui{u,1}(1:end-1);
    %     end
    % x = length(Assigned_proj_roll_with_gui);
    % Assigned_projs_rolls_with_gui_codes = [Assigned_projs_with_gui_codes Assigned_proj_roll_with_gui(:,2)];
    BeforeOrAfter = 'After';
    
    [sorted_txt,~,tracking_max_projs,~,~] =...
        max_proj_checker_deleter (Assigned_proj_roll_with_gui,max_proj_checker,N_students,sorted_txt,proj_sent_no,BeforeOrAfter);
    
    tracking_max_projs;
    Assigned_proj_roll_with_gui
    if Student_no > N_students
        break
    end
end






if size(sorted_txt,2) == 1
    Opt.Interpreter = 'tex';
    Opt.WindowStyle = 'modal';
    
    waitfor(msgbox("\fontsize{14} Maximum Allotment Reached. Maximum Project per Professor Criteria Successfull.",...
        'Success','help',Opt));
end


[~,idx]=unique(  strcat(tracking_max_projs(:,1), 'rows'));
tracking_max_projs = tracking_max_projs(idx,:);

[N_students] = size(Assigned_proj_roll_with_gui,1);

original_max_proj_checker = max_proj_checker;
max_proj_checker(:,2) = "NoneAssigned";

for i = 1:length(tracking_max_projs)
   found_index =  find(strcmpi(tracking_max_projs(i,1),max_proj_checker));
   max_proj_checker(found_index,2) = tracking_max_projs(i,2);
end
 tracking_max_projs = max_proj_checker
max_proj_checker = original_max_proj_checker;

Assigned_proj_info = Assigned_proj_roll_with_gui(:,1);

for a  = 1 : N_students
    full_proj_index = find(strcmpi(original_proj_list(:,2),Assigned_proj_info(a)));
    fullprojs(a) = original_proj_list(full_proj_index,1);
end

Assigned_proj_roll_with_gui(:,1) = fullprojs

final_assignment = Assigned_proj_roll_with_gui;
%xlswrite('final_allotment',final_assignment)
%writematrix(final_assignment,'final_assignment_prabir_kumar_reco.csv')
xlswrite('final_assignment.xlsx',final_assignment); % this should be
%uncommented
toc




% [original_proj_list txt3(:,2)]