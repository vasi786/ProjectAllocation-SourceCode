
function [Assigned_proj_roll_nos_fromCGPA,sorted_txt,txt3,sorted_CGPA] = ...
    manual_selection_2(index,sorted_Roll_nos,sorted_txt,txt3,N_students,total_choices,...
    sorted_CGPA,projs_max_checker_2,max_proj_checker,proj_sent_no)


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

% for rows = 1 : size(projs_for_manual,1)
%     for col = 1:size(projs_for_manual,2)
%         projs_for_manual_maxing{rows,col} = projs_for_manual{rows,col}(1:end-5)
%     end
% end

projs_for_manual_maxing = unique(projs_for_manual);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:length(projs_for_manual_maxing)
    %projs_for_manual2 = projs_for_manual(i,:);
    projs_max_checker_3 = [projs_max_checker_2;[projs_for_manual_maxing(i) Rolls_for_manual(1)]]; % Roll number is dummy. It is
    % not necessary for the function file max_proj_checker_deleter
    BeforeOrAfter = 'Before';
    [~,~,~,~,message_MAX_PROJS3] =...
        max_proj_checker_deleter (projs_max_checker_3,max_proj_checker,N_students,sorted_txt,0,BeforeOrAfter);
    message_MAX_PROJS3 = sscanf(message_MAX_PROJS3,'Only%dLeft');
    messages_for_Manual_maxchecker(i,1:2) = [ projs_for_manual_maxing{i}(1:end-5) string(message_MAX_PROJS3)];
end

clear i;
%%%%%%%%%%%GETTING UNIQUE ROWS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[~,idx]=unique(  strcat(messages_for_Manual_maxchecker(:,1), 'rows'));
messages_for_Manual_maxchecker_unique = messages_for_Manual_maxchecker(idx,:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
msg_gui = 'jfdsljfsldj';

Opt.Interpreter = 'tex';
Opt.WindowStyle = 'modal';

waitfor(msgbox("\fontsize{14} Select the projects from the drop down. Make sure to follow the maximum number of projects per professor which is displayed in the table",'Warning','warn',Opt))
[Decisions_gui,msg_gui] =  ManualProjectAllocation_2(Rolls_for_manual',fullprojs,messages_for_Manual_maxchecker_unique);

while strcmpi(msg_gui,'jfdsljfsldj') == 1
    pause(1)
end

if strcmpi(msg_gui,'Clash in user assigned choices. Make sure the choices are unique') == 1
    msg = 'Clash in user assigned choices. Make sure the choices are unique';
    error(msg)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CHECKING MAX PROJ CRITERIA
for i = 1:length(Decisions_gui)
    projs_index = find(strcmpi(txt3(:,1),Decisions_gui(i)));
    projs_keyword(i) = txt3(projs_index,2);
    proj_prof_names{i} = projs_keyword{i}(1:end-5);
end
[uniqueS,~,idx] = unique(proj_prof_names,'stable');
count = hist(idx,unique(idx));

for i = 1:size(uniqueS,2)
    max_number = str2double(messages_for_Manual_maxchecker_unique...
        (find(strcmpi(uniqueS(i),messages_for_Manual_maxchecker_unique)),2));
    
    if count(i) > max_number
        
        Opt.Interpreter = 'tex';
        Opt.WindowStyle = 'modal';
        
        waitfor(msgbox("\fontsize{14} Prof. " + uniqueS(i) +...
            " has only one project left according to the \bfMax Project per Professor Criteria\rm. Try alloting again ",...
            'Error','error',Opt));
        
        errordlg('Allotment stopped since the Max Project per Professor Criteria did not met')
        error('Allotment stopped since the Max Project per Professor Criteria did not met');
        
    else
        disp('Allotment done properly as per MPpC')
    end
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
