
function [Assigned_proj_roll_nos_fromCGPA,sorted_txt,txt3,sorted_CGPA] = ...
    manual_selection(index,sorted_Roll_nos,sorted_txt,txt3,N_students,total_choices,sorted_CGPA)


delproj = @removingproj; % [sorted_txt] = removingproj(same_CGPA_project,sorted_txt,N_students)
assign = @assignment;


if size(sorted_txt,2) > 2+length(index) - 1
    
    for s = 1 : length(index)
        
        Rolls_for_manual(s)=(sorted_Roll_nos(index(s)));
        projs_for_manual(s,:)= sorted_txt(index(s),2:2+length(index));
        
    end
else
    for s = 1 : length(index)
        
        Rolls_for_manual(s)=(sorted_Roll_nos(index(s)));
        projs_for_manual(s,:)= sorted_txt(index(s),2:end);
    end
    
end

for i = 1: size(projs_for_manual,1)
    for j = 1:size(projs_for_manual,2)
        fullprojs_index = find(strcmpi(txt3(:,2),projs_for_manual(i,j)));
        fullprojs(i,j) = txt3(fullprojs_index,1);
    end
end



msg_gui = 'jfdsljfsldj';

[Decisions_gui,msg_gui] =  ManualProjectAllocation(Rolls_for_manual',fullprojs);

while strcmpi(msg_gui,'jfdsljfsldj') == 1
    pause(1)
end

if strcmpi(msg_gui,'Clash in user assigned choices. Make sure the choices are unique') == 1
    msg = 'Clash in user assigned choices. Make sure the choices are unique';
    error(msg)
end


for i = 1:length(Decisions_gui)
    projs_index = find(strcmpi(txt3(:,1),Decisions_gui(i)));
    projs_keyword(i) = txt3(projs_index,2);
    sorted_txt = delproj(projs_keyword(i),sorted_txt,N_students);
    txt3 = assign(projs_keyword(i),total_choices,txt3);
    Assigned_proj_roll_nos(i,:) = string([projs_keyword(i) Rolls_for_manual(i)]);
    sorted_CGPA(i,2) = 0;
end

Assigned_proj_roll_nos_fromCGPA = Assigned_proj_roll_nos;


end
