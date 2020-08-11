
function [Assigned_proj_roll_nos_fromCGPA,sorted_txt,txt3,sorted_CGPA,message] = ...
    gate_allocation_2 (index,sorted_Roll_nos,sorted_txt,txt3,N_students,...
    total_choices,sorted_CGPA,projs_max_checker_1,max_proj_checker,proj_sent_no)



delproj = @removingproj; % [sorted_txt] = removingproj(same_CGPA_project,sorted_txt,N_students)
assign = @assignment;


for r = 1 : length(index)
    
    Rolls_for_gate(r)=sorted_Roll_nos(index(r));
    first_choice_FGATE(r) = sorted_txt(index(r),2);
    
end


clear r
[gate_winner,I] = GateScore_decision(Rolls_for_gate);

winner_roll_nos = gate_winner(:,1);

for r = 1:length(winner_roll_nos)
    proj_for_roll_no_gate(r) = sorted_txt(index(r),2)
end

for i = 1:length(winner_roll_nos)
    
    projs_max_checker_2 = [projs_max_checker_1;[proj_for_roll_no_gate(i) winner_roll_nos(i)]];
    BeforeOrAfter = 'Before'
    [~,~,~,~,message_MAX_PROJS3] =...
        max_proj_checker_deleter (projs_max_checker_2,max_proj_checker,N_students,sorted_txt,1,BeforeOrAfter);
    message_MAX_PROJS3 = sscanf(message_MAX_PROJS3,'Only%dLeft')
    messages_for_gate_maxchecker(i,1:2) = [ proj_for_roll_no_gate{i}(1:end-5) string(message_MAX_PROJS3)];
end

clear i;
%%%%%%%%%%%GETTING UNIQUE ROWS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[~,idx]=unique(  strcat(messages_for_gate_maxchecker(:,1), 'rows'));
messages_for_gate_maxchecker_unique = messages_for_gate_maxchecker(idx,:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if str2double(messages_for_gate_maxchecker_unique(:,2)) >= 1   %>=1  % Atleast One project should be open to allot through gate scores
    
    for r = 1: length(winner_roll_nos)
        
          %  extra step do not consider this project.
        
        while true
            proj_for_roll_no_gate = sorted_txt(index(r),2);
            BeforeOrAfter = 'Before';
            proj_for_winner_roll_nos = proj_for_roll_no_gate; % check I(r),:
            proj_for_winner_roll_nos_checking = [projs_max_checker_1;[proj_for_winner_roll_nos winner_roll_nos(r)]]; 
            proj_sent_no = 0;
            [sorted_txt,~,~,~,message_MAX_PROJS3] =...
                max_proj_checker_deleter (proj_for_winner_roll_nos_checking,max_proj_checker,N_students,sorted_txt,proj_sent_no,BeforeOrAfter);
            
            if  message_MAX_PROJS3 ~= 'NoneLeft'
                break
            end
        end
        
        
        
        Assigned_proj_roll_nos(r,:) = string([proj_for_winner_roll_nos winner_roll_nos(r)]);
        message = 'Gate_Direct_assignment';
        sorted_txt = delproj(proj_for_winner_roll_nos,sorted_txt,N_students);
        txt3 = assign(proj_for_winner_roll_nos,total_choices,txt3);
        %stored_index(r) = index(r);
        sorted_CGPA(r,2) = 0;  % So that when the same CGPA comes in the next iteration doesn't
        % take care of this student.
        projs_max_checker_3 = [projs_max_checker_1;Assigned_proj_roll_nos];
        BeforeOrAfter = 'After';
        [sorted_txt,~,~,~,~] =...
            max_proj_checker_deleter (projs_max_checker_3,max_proj_checker,N_students,sorted_txt,0,BeforeOrAfter);
    end
else
    
    disp(' calling Manual allocation and be aware that one of the projects under a professor is not at all availabe. Allocate with caution.')
    NotToAllocate_index = find(str2double(messages_for_gate_maxchecker_unique(:,2)) == 0);
    prof_name = messages_for_gate_maxchecker_unique(NotToAllocate_index,1);
    
    
    Opt.Interpreter = 'tex';
    Opt.WindowStyle = 'modal';
    waitfor(msgbox("\fontsize{12} Prof. " + prof_name + " has zero projects left according to the \bfMax Project per Professor Criteria\rm, Please allot other Professor's projects",...
        'Warning','warn',Opt));
    
    
    
    [Assigned_proj_roll_nos,sorted_txt,txt3,sorted_CGPA] = ...
        manual_selection_2(index,sorted_Roll_nos,sorted_txt,txt3,N_students,total_choices,...
        sorted_CGPA,projs_max_checker_2,max_proj_checker,proj_sent_no)
    
    
    %     [Assigned_proj_roll_nos,sorted_txt,txt3,sorted_CGPA] = ...
    %     manual_selection(index,sorted_Roll_nos,sorted_txt,txt3,N_students,total_choices,sorted_CGPA,original_proj_list)
    
end


%  No_duplicate(end) = [];

Assigned_proj_roll_nos_fromCGPA = Assigned_proj_roll_nos;