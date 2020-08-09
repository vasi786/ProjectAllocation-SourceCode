
function [Assigned_proj_roll_nos_fromCGPA,sorted_txt,txt3,sorted_CGPA,message] = ...
    gate_allocation (index,sorted_Roll_nos,sorted_txt,txt3,N_students,total_choices,sorted_CGPA)



delproj = @removingproj; % [sorted_txt] = removingproj(same_CGPA_project,sorted_txt,N_students)
assign = @assignment;


for r = 1 : length(index)
    
    Rolls_for_gate(r)=sorted_Roll_nos(index(r));
    first_choice_FGATE(r) = sorted_txt(index(r),2);
    
end

clear r
[gate_winner,I] = GateScore_decision(Rolls_for_gate);

winner_roll_nos = gate_winner(:,1);

for r = 1: length(winner_roll_nos)
    
    proj_for_roll_no_gate = sorted_txt(index(r),2);  %  extra step do not consider this project.
    proj_for_winner_roll_nos = proj_for_roll_no_gate; % check I(r),:
    Assigned_proj_roll_nos(r,:) = string([proj_for_winner_roll_nos winner_roll_nos(r)]);
    message = 'Gate_Direct_assignment';
    sorted_txt = delproj(proj_for_winner_roll_nos,sorted_txt,N_students);
    txt3 = assign(proj_for_winner_roll_nos,total_choices,txt3);
    %stored_index(r) = index(r);
    sorted_CGPA(r,2) = 0;  % So that when the same CGPA comes in the next iteration doesn't
    % take care of this student.
end

%  No_duplicate(end) = [];

Assigned_proj_roll_nos_fromCGPA = Assigned_proj_roll_nos;