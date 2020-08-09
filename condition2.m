function [Assigned_proj_roll_nos_fromCGPA,sorted_txt,stored_index,txt3]...
    = condition2(index,sorted_txt,sorted_Roll_nos,N_students,total_choices,txt3)   

delproj = @removingproj; % [sorted_txt] = removingproj(same_CGPA_project,sorted_txt,N_students)
assign = @assignment;

k = 2;
        for j = 1: length(index)
            choice(j) = sorted_txt(index(j),k);
            same_CGPA_Roll_nos(j) = sorted_Roll_nos(index(j));
            same_CGPA_project(j) = sorted_txt(index(j),2); % Lot of confusion, everytime name of the student
            %is coming in the middle, better if we take out name column from
            %txt matrix
        end
        
        for k = 1: 2
            Assigned_proj_roll_nos(k,:) = string([same_CGPA_project(k) same_CGPA_Roll_nos(k)]);
            sorted_txt = delproj(same_CGPA_project(k),sorted_txt,N_students);
            stored_index = 0;
        end
        Assigned_proj_roll_nos_fromCGPA = Assigned_proj_roll_nos;
        txt3 = assign(choice,total_choices,txt3);