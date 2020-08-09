function [Assigned_proj_roll_nos,sorted_txt,stored_index,txt3,sorted_CGPA,message]...
    =condition1(index,sorted_txt,sorted_Roll_nos,txt3,N_students,total_choices,sorted_CGPA,max_proj_checker,Assigned_proj_roll_with_gui)


delproj = @removingproj; % [sorted_txt] = removingproj(same_CGPA_project,sorted_txt,N_students)
assign = @assignment;

k = 2;

for j = 1: length(index)
    choice(j) = sorted_txt(index(j),k);
    choice_max_proj_checker(j) = sorted_txt(index(j),2);
    choice_for_comparing{j} = choice{j}(1:end-1);
    same_CGPA_Roll_nos(j) = sorted_Roll_nos(index(j));
    same_CGPA_project(j) = sorted_txt(index(j),k);
    k = k+1;
end



if  isequal(choice_for_comparing(1),choice_for_comparing(2)) == 1
    
    proj_max_checker = [Assigned_proj_roll_with_gui; [choice(1) string(same_CGPA_Roll_nos(1))]];
    
    no_of_projs_sent_for_verification = size(choice,2);
    %prev_sorted_txt = sorted_txt;
    
    BeforeOrAfter = 'BeforeCond1';
    [~,~,~,message_MAX_PROJS2,~] =...
        max_proj_checker_deleter (proj_max_checker,max_proj_checker,N_students,sorted_txt,no_of_projs_sent_for_verification,BeforeOrAfter);
    
end

%message_MAX_PROJS2 = "Only1Left" % Testing purposes only
%
% How_many_left = sscanf(message_MAX_PROJS2,'Only%dLeft');
%
% Deciding_factor = no_of_projs_sent_for_verification - How_many_left;


if isequal(choice_for_comparing(1),choice_for_comparing(2)) == 1 ...
        &&  message_MAX_PROJS2 == "Only1Left"
    
    prof_name = choice_max_proj_checker{1}(1:end-5)
    
    Opt.Interpreter = 'tex';
    Opt.WindowStyle = 'modal';
    waitfor(msgbox("\fontsize{14} Prof. " + prof_name + " has only one project left according to the \bfMax Project per Professor Criteria\rm",...
        'Warning','warn',Opt));
    
    %create msgbox
    
    
    Opt.Interpreter = 'tex';
    Opt.WindowStyle = 'modal';
    
    answer = questdlg('\fontsize{14}There is a clash in choices and CGPA, How do you like to continue?',...
        'Choices',...
        'Compare GATE Score','Do It Manually',struct('Default','','Interpreter','tex'));
    
    
    
    switch answer
        
        
        %             case 'Compare GATE Score'
        %                 % disp('Here comes the gate score function file')
        %                 %%%%%%%%%%%%%%%%%%%%%%%%%%%GATE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %                 [Assigned_proj_roll_nos,sorted_txt,txt3,sorted_CGPA,message]...
        %                     = gate_allocation (index,sorted_Roll_nos,sorted_txt,txt3,N_students,total_choices,sorted_CGPA);
        %
        %                 stored_index = 0;
        
        case 'Do It Manually'
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MANUALSELECTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            % while true
            
            [Assigned_proj_roll_nos,sorted_txt,txt3,sorted_CGPA] = ...
                manual_selection(index,sorted_Roll_nos,sorted_txt,txt3,N_students,total_choices,sorted_CGPA);
            
            stored_index = 0;
            message='Manual Selection as per Max project criteria';
            
            for i = 1:length(Assigned_proj_roll_nos)
                Assigned_proj_rolls_checking{i,1} = Assigned_proj_roll_nos{i,1}(1:end-1);
            end
            clear i;
            [~,idx]=unique(  strcat(Assigned_proj_rolls_checking(:,1), 'rows'))
            Assigned_proj_rolls_checking_unique=Assigned_proj_rolls_checking(idx,:);
            if size(Assigned_proj_rolls_checking_unique,1) == size(Assigned_proj_rolls_checking,1)
                disp('Assignment done as per the condition (MPpPC)')
            else
                Opt.Interpreter = 'tex';
                Opt.WindowStyle = 'modal';
                
                waitfor(msgbox("\fontsize{14} Prof. " + prof_name +...
                    " has only one project left according to the \bfMax Project per Professor Criteria\rm. Try alloting again ",...
                    'Error','error',Opt));
                
                errordlg('Allotment stopped since the Max Project per Professor Criteria did not met')
                error('Allotment stopped since the Max Project per Professor Criteria did not met');
            end
            %  end
    end
    
    
    
    
elseif isequal(choice_for_comparing(1),choice_for_comparing(2)) == 1 ...
        %% Checking whether the first choice and second choice of two or more students are Under the same professor.
    disp('condition_1 success')
    for i = 1: length(txt3)
        txt3_for_same_CGPA_cond2{i} = txt3{i,2}(:,1:end-1);
        i;
    end
    %%
    if sum ( strcmp(choice_for_comparing{1},txt3_for_same_CGPA_cond2) ) >= 2 % >= 2  & If the first choices are under same prof, then need to say if that many projects actually exists to allot.
        % For this case, there are more than two projects to allot to two or more people
        for k = 1: 2
            Assigned_proj_roll_nos(k,:) = string([same_CGPA_project(k) same_CGPA_Roll_nos(k)]);
            sorted_txt = delproj(same_CGPA_project(k),sorted_txt,N_students);
            stored_index = 0;
        end
        
        %%% HERE
        txt3 = assign(choice,total_choices,txt3);
        message='normal';
        
    else                                                                        % If not then user or gate score should decide
        
        
        Opt.Interpreter = 'tex';
        Opt.WindowStyle = 'modal';
        
        answer = questdlg('\fontsize{14}There is a clash in choices and CGPA, How do you like to continue?',...
            'Choices',...
            'Compare GATE Score','Do It Manually',struct('Default','','Interpreter','tex'));
        
        switch answer
            case 'Compare GATE Score'
                % disp('Here comes the gate score function file')
                %%%%%%%%%%%%%%%%%%%%%%%%%%%GATE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                [Assigned_proj_roll_nos,sorted_txt,txt3,sorted_CGPA,message]...
                    = gate_allocation (index,sorted_Roll_nos,sorted_txt,txt3,N_students,total_choices,sorted_CGPA);
                
                stored_index = 0;
                
            case 'Do It Manually'
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MANUALSELECTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                [Assigned_proj_roll_nos,sorted_txt,txt3,sorted_CGPA] = ...
                    manual_selection(index,sorted_Roll_nos,sorted_txt,txt3,N_students,total_choices,sorted_CGPA);
                
                stored_index = 0;
                message='Manual Selection';
                
        end
        
    end
elseif isequal(choice_for_comparing(1),choice_for_comparing(2)) == 0  % If the first choice of first student
    %and second choice of second student are different, then user need to
    %specify whom to give priority.
    
    
    Opt.Interpreter = 'tex';
    Opt.WindowStyle = 'modal';
    
    answer = questdlg('\fontsize{14}There is a clash in choices and CGPA, How do you like to continue?',...
        'Choices',...
        'Compare GATE Score','Do It Manually',struct('Default','','Interpreter','tex'));
    
    switch answer
        case 'Compare GATE Score'
            % disp('Here comes the gate score function file')
            %%%%%%%%%%%%%%%%%%%%%%%%%%%GATE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            [Assigned_proj_roll_nos,sorted_txt,txt3,sorted_CGPA,message]...
                = gate_allocation (index,sorted_Roll_nos,sorted_txt,txt3,N_students,total_choices,sorted_CGPA);
            
            stored_index = 0;
            
        case 'Do It Manually'
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MANUALSELECTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            [Assigned_proj_roll_nos,sorted_txt,txt3,sorted_CGPA] = ...
                manual_selection(index,sorted_Roll_nos,sorted_txt,txt3,N_students,total_choices,sorted_CGPA);
            
            stored_index = 0;
            message='Manual Selection';
            
    end
    %
end
end