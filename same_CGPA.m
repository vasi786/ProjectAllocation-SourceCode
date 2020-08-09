

function [No_of_same_choice_students,Assigned_proj_roll_nos_fromCGPA,...
    No_duplicate,sorted_txt,txt3,message,stored_index,sorted_CGPA,...
    Already_computed,No_DA,previous_No_duplicate_new,previous_No_duplicate_DA] ...
    = same_CGPA(sorted_CGPA,sorted_txt,sorted_Roll_nos,...
    txt3,N_students,total_choices,original_sorted_CGPA,...
    No_duplicate,stored_index,Student_no,Already_computed,...
    No_DA,previous_No_duplicate_new,previous_No_duplicate_DA,Assigned_proj_roll_with_gui,max_proj_checker)

%%

cond1 = 1;
cond2 = 1;
cond3 = 1;
previous_diff_index = [NaN NaN];
previous_sum_comparisions = 0;
proj_sent_no = 0;
message = 'NaN';


Assigned_proj_roll_nos_GFFF=["NaN" "NaN"];
Assigned_proj_roll_nos_ManualFF=["NaN" "NaN"];
Assigned_proj_roll_nos_cond1ff=["NaN" "NaN"];
Assigned_proj_roll_nos_cond2ff=["NaN" "NaN"];
Assigned_proj_roll_nos_cond3ff=["NaN" "NaN"];
Assigned_proj_roll_nos_fromCGPA_DA=["NaN" "NaN"];



GF1 = 0;
MA = 0;

Already_computed(1:length(unique(Already_computed))) = unique(Already_computed);

Already_computed2 = unique(Already_computed);

j = 1;

for i = 1 : length(Already_computed)
    
    
    if isequal(Already_computed(i), Already_computed2(j)) == 0
        non_clashing_index3 = find(sorted_CGPA(:,2)== Already_computed2(j))
        j = j +1;
        
    elseif isequal(Already_computed2(j),0) == 1 && i == 1
        non_clashing_index = find(sorted_CGPA(:,2)== Already_computed2(j)); % Need to tell if it comes
        %the second time. Need to neglect the first comparision.
        j = j+1;
        
    end
    
    if i > 1
        non_clashing_index = cat(1,non_clashing_index,non_clashing_index3);
    end
    
    if j > length(Already_computed2)
        break
    end
    
    
end

clear i
clear j

%
sorted_CGPA(non_clashing_index,:) = [];

%%

for i = 1:length(No_duplicate)
    
    if No_duplicate(i) > 0 && stored_index == 0  % If stored index is
        %nothing that means we can directly delete the No_duplicate items
        sorted_CGPA(find(sorted_CGPA(:,2)==No_duplicate(i)),:) = [];
        
    elseif No_duplicate(i) > 0
        
        % For the case of stored index other than zero, that means
        % previously it entered Line 227, "Direct Assignment", for that
        % case only one project is assigned and others are left. To
        % consider the others, No_duplicate shouldn't include the previous
        % number.
        
        if No_duplicate(i) ~= previous_No_duplicate_DA
            sorted_CGPA(find(sorted_CGPA(:,2)==No_duplicate(i)),:) = [];
        end
        
        if No_duplicate(i) == previous_No_duplicate_DA
            No_duplicate(end) = []; % If stored_index is something then the last thing should be removed
            break
        end
        %
        
    end
    
end

No_duplicate_new = min(unique(sorted_CGPA(:,2)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This part is written for restarting No_DA(number of direct assignments
% done) if we are dealing with another set of same_CGPA.

if previous_No_duplicate_new == No_duplicate_new
    
    No_DA;
    stored_index;
    previous_No_duplicate_DA
else
    No_DA =0;
    stored_index = 0;
    previous_No_duplicate_DA = NaN;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
No_duplicate = [No_duplicate;No_duplicate_new];

index = find(original_sorted_CGPA(:,2) == No_duplicate_new); % Gives you the correct index;

if stored_index ~= 0
    index(1:No_DA) = [];   % stored index is for the direct assignment
    %which are having three first diffent choices
    % But this direct assignment is not done in one step it is done in many
    % steps it depends on how many are they similiar. Let's say index 4 5
    % and 6 are having same choice in the first run it will assign for
    % index 4 and to remove this 4 in the second run we need to remove it.
    % So it cannot be assigned again. and No_duplicate(end) = [] is also
    % for this same reason. If this is not done, the second time the
    % function file doesn't recognize the rest two. To make the the second
    % column, 4th one's zero, that is why this line is added.
    % "sorted_CGPA(index(j),2) = 0;"
end

delproj = @removingproj; % [sorted_txt] = removingproj(same_CGPA_project,sorted_txt,N_students)
assign = @assignment;
recommend = @recommendations_fn;
%%
No_of_same_choice_students = length(index);

if length(index) > 2
    
    
    
    %%%%%%% MAX PROJ CHECKING IS NECESSARY AFTER EACH step since everything
    %%%%%%% is involved in a loop and update should happen after each
    %%%%%%% allotment.
    
    k = 2;
    
    for j = 1: length(index)
        first_choice(j) = sorted_txt(index(j),k);
    end
    
    
    clear j
    
    for j = 1 : length(first_choice)
        
        real_comparision(j,:) = strncmpi(first_choice{j},first_choice,strlength(first_choice{j}));
    end
    same_choice_student_no = size(real_comparision,2);
    
    diff_index = NaN*ones(same_choice_student_no,1);
    previous_diff_index = NaN*ones(same_choice_student_no,1);
    for i = 1:same_choice_student_no
        comparision = real_comparision(i,:);
        
        if size(real_comparision,1) > 5
            disp('Manual Waiting')
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if sum(comparision) > 2
            
            sum_comparisions = sum(comparision);
            diff_index_1 = index(find(comparision==1));
            
            
            
            if sum(ismember(previous_diff_index,diff_index(i))) == 0  
                
                
                previous_diff_index = [previous_diff_index;diff_index_1];                
                
                Opt.Interpreter = 'tex';
                Opt.WindowStyle = 'modal';
                
                answer = questdlg('\fontsize{14}There is a clash in choices and CGPA, How do you like to continue?',...
                    'Choices',...
                    'Compare GATE Score','Do It Manually',struct('Default','','Interpreter','tex'));
                switch answer
                    case 'Compare GATE Score'
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        Assigned_proj_roll_nos_fromCGPA_max_checker_gate2 = ...
                            [Assigned_proj_roll_nos_fromCGPA_DA;Assigned_proj_roll_nos_GFFF;...
                            Assigned_proj_roll_nos_ManualFF;Assigned_proj_roll_nos_cond1ff;...
                            Assigned_proj_roll_nos_cond2ff;Assigned_proj_roll_nos_cond3ff];
                        
                        Assigned_proj_roll_nos_fromCGPA_max_checker_gate2...
                            (strcmp(Assigned_proj_roll_nos_fromCGPA_max_checker_gate2(:,1),"NaN"),:) = [];
                        
                        projs_max_checker_gate2 = [Assigned_proj_roll_with_gui; Assigned_proj_roll_nos_fromCGPA_max_checker_gate2];
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        
                        % disp('Here comes the gate score function file')
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%GATE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        [Assigned_proj_roll_nos_GF,sorted_txt,txt3,sorted_CGPA,message]...
                            = gate_allocation_2(diff_index_1,sorted_Roll_nos,sorted_txt,txt3,N_students,...
                            total_choices,sorted_CGPA,projs_max_checker_gate2,max_proj_checker,proj_sent_no);
                        
                        stored_index = 0;
                        
                        GF1 = GF1 + 1;
                        
                        Assigned_proj_roll_nos_GFF(1:length(diff_index_1),:) = Assigned_proj_roll_nos_GF;
                        
                        if GF1 == 1
                            Assigned_proj_roll_nos_GFFF = Assigned_proj_roll_nos_GFF;
                        end
                        
                        if GF1 > 1
                            Assigned_proj_roll_nos_GFFF = [Assigned_proj_roll_nos_GFFF;Assigned_proj_roll_nos_GF];  % Final
                        end
                        
                        clear Assigned_proj_roll_nos_GF
                        clear Assigned_proj_roll_nos_GFF
                        
                        %%%%%%%%%%%CHECKING AGAIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        Assigned_proj_roll_nos_fromCGPA_max_checker_gate2After = ...
                            [Assigned_proj_roll_nos_fromCGPA_DA;Assigned_proj_roll_nos_GFFF;...
                            Assigned_proj_roll_nos_ManualFF;Assigned_proj_roll_nos_cond1ff;...
                            Assigned_proj_roll_nos_cond2ff;Assigned_proj_roll_nos_cond3ff];
                        
                        Assigned_proj_roll_nos_fromCGPA_max_checker_gate2After...
                            (strcmp(Assigned_proj_roll_nos_fromCGPA_max_checker_gate2After(:,1),"NaN"),:) = [];
                        
                        projs_max_checker_gate2After = [Assigned_proj_roll_with_gui; Assigned_proj_roll_nos_fromCGPA_max_checker_gate2After];
                        BeforeOrAfter = 'After'
                        [sorted_txt,~,tracking_max_projs,~,~] = ...
                            max_proj_checker_deleter (projs_max_checker_gate2After,max_proj_checker,N_students,sorted_txt,proj_sent_no,BeforeOrAfter);
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        
                        
                        
                    case 'Do It Manually'
                        
                        %%
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MANUALSELECTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        
                        
                        Assigned_proj_roll_nos_fromCGPA_max_checker_manual2 = ...
                            [Assigned_proj_roll_nos_fromCGPA_DA;Assigned_proj_roll_nos_GFFF;...
                            Assigned_proj_roll_nos_ManualFF;Assigned_proj_roll_nos_cond1ff;...
                            Assigned_proj_roll_nos_cond2ff;Assigned_proj_roll_nos_cond3ff];
                        
                        Assigned_proj_roll_nos_fromCGPA_max_checker_manual2...
                            (strcmp(Assigned_proj_roll_nos_fromCGPA_max_checker_manual2(:,1),"NaN"),:) = [];
                        
                        projs_max_checker_manual2 = [Assigned_proj_roll_with_gui; Assigned_proj_roll_nos_fromCGPA_max_checker_manual2];
                        
                        
                        
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        
                        
                        % CALLING THE MANUAL APP
                        
                        
                        [Assigned_proj_roll_nos_Manual,sorted_txt,txt3,sorted_CGPA] = ...
                            manual_selection_2(diff_index_1,sorted_Roll_nos,sorted_txt,txt3,N_students,total_choices,...
                            sorted_CGPA,projs_max_checker_manual2,max_proj_checker,proj_sent_no);
                        
                        stored_index = 0;
                        
                        MA = MA + 1;
                        
                        Assigned_proj_roll_nos_ManualF(1:length(diff_index_1),:) = Assigned_proj_roll_nos_Manual;
                        
                        if MA == 1
                            Assigned_proj_roll_nos_ManualFF = Assigned_proj_roll_nos_ManualF;
                        end
                        
                        if MA > 1
                            Assigned_proj_roll_nos_ManualFF = [Assigned_proj_roll_nos_ManualFF;Assigned_proj_roll_nos_ManualF]; % Final
                        end
                        
                        clear Assigned_proj_roll_nos_Manual
                        clear Assigned_proj_roll_nos_ManualF
                        
                        
                        Assigned_proj_roll_nos_fromCGPA_max_checker_manual2After = ...
                            [Assigned_proj_roll_nos_fromCGPA_DA;Assigned_proj_roll_nos_GFFF;...
                            Assigned_proj_roll_nos_ManualFF;Assigned_proj_roll_nos_cond1ff;...
                            Assigned_proj_roll_nos_cond2ff;Assigned_proj_roll_nos_cond3ff];
                        
                        Assigned_proj_roll_nos_fromCGPA_max_checker_manual2After...
                            (strcmp(Assigned_proj_roll_nos_fromCGPA_max_checker_manual2After(:,1),"NaN"),:) = [];
                        
                        projs_max_checker_manual2After = [Assigned_proj_roll_with_gui; Assigned_proj_roll_nos_fromCGPA_max_checker_manual2After];
                        BeforeOrAfter = 'After'
                        [sorted_txt,~,tracking_max_projs,~,~] = ...
                            max_proj_checker_deleter (projs_max_checker_manual2After,max_proj_checker,N_students,sorted_txt,proj_sent_no,BeforeOrAfter);
                        
                        %%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%% END OF MANUAL SELECTION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        
                end
                
                
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%
        elseif sum(comparision) == 1
            diff_index_DA = index(i);

            if sum(ismember(previous_diff_index,diff_index_DA)) == 0  
                previous_diff_index = [previous_diff_index;index(i)];
            No_DA = No_DA+1;  % To keep track of how many times we entered here.
              j = 1;
            another_index = find(comparision == 1);
            disp('direct assignment');
            
            Roll_no_direct_assignment = sorted_Roll_nos(index(i)); %sorted_Roll_nos(index(j)+Student_no-1)
            
            
            Assigned_proj_roll_nos_fromCGPA_max_checker_DA_BEFORE = ...
                [Assigned_proj_roll_nos_fromCGPA_DA;Assigned_proj_roll_nos_GFFF;...
                Assigned_proj_roll_nos_ManualFF;Assigned_proj_roll_nos_cond1ff;...
                Assigned_proj_roll_nos_cond2ff;Assigned_proj_roll_nos_cond3ff];
            
            Assigned_proj_roll_nos_fromCGPA_max_checker_DA_BEFORE...
                (strcmp(Assigned_proj_roll_nos_fromCGPA_max_checker_DA_BEFORE(:,1),"NaN"),:) = [];
            
            while true
                
                BeforeOrAfter = 'Before';
                
                proj_for_direct_assignment = sorted_txt(index(i),2);
                
                projs_max_checker_DA_BEFORE = [Assigned_proj_roll_with_gui;Assigned_proj_roll_nos_fromCGPA_max_checker_DA_BEFORE; [ proj_for_direct_assignment Roll_no_direct_assignment]];
                
                [sorted_txt,~,~,~,message_MAX_PROJS3] =...
                    max_proj_checker_deleter (projs_max_checker_DA_BEFORE,max_proj_checker,N_students,sorted_txt,proj_sent_no,BeforeOrAfter);
                
                if  message_MAX_PROJS3 ~= 'NoneLeft'
                    break
                end
                
            end
            
            Assigned_proj_roll_nos_DA(No_DA,:) = string([proj_for_direct_assignment Roll_no_direct_assignment])
            Assigned_proj_roll_nos_fromCGPA_DA(No_DA,:) = Assigned_proj_roll_nos_DA(No_DA,:);
            message = 'Direct_assignment';
            sorted_txt = delproj(proj_for_direct_assignment,sorted_txt,N_students);
            txt3 = assign(proj_for_direct_assignment,total_choices,txt3);
            %stored_index = No_duplicate_new;
            sorted_CGPA(another_index,2) = 0; % So that when the same CGPA comes in the next iteration doesn't
            % take care of this student.
            % No_duplicate(end) = [];
            previous_No_duplicate_new = No_duplicate_new;
            previous_No_duplicate_DA = No_duplicate_new;  % DA = Direct Assignment
            
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MAX PROJ CHECKING%%%%%%%%%%%%
            
            Assigned_proj_roll_nos_fromCGPA_max_checker = ...
                [Assigned_proj_roll_nos_fromCGPA_DA;Assigned_proj_roll_nos_GFFF;...
                Assigned_proj_roll_nos_ManualFF;Assigned_proj_roll_nos_cond1ff;...
                Assigned_proj_roll_nos_cond2ff;Assigned_proj_roll_nos_cond3ff];
            
            Assigned_proj_roll_nos_fromCGPA_max_checker...
                (strcmp(Assigned_proj_roll_nos_fromCGPA_max_checker(:,1),"NaN"),:) = [];
            
            projs_max_checker = [Assigned_proj_roll_with_gui; Assigned_proj_roll_nos_fromCGPA_max_checker];
            previous_size_of_sorted_txt = size(sorted_txt);
            BeforeOrAfter = 'After';
            [sorted_txt,~,~,~,~] =...
                max_proj_checker_deleter (projs_max_checker,max_proj_checker,N_students,sorted_txt,proj_sent_no,BeforeOrAfter);
            size_of_sorted_txt = size(sorted_txt);
            
            %     if sum(previous_size_of_sorted_txt) ~= sum(size_of_sorted_txt)
            %         disp('wait one second')
            %        % return
            %     end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%
        elseif sum(comparision) ==2
            
            diff_index_2 = index(find(comparision==1));  %diff_index is for passing only
            %certain indexes to the following functions.
            
            if sum(ismember(previous_diff_index,diff_index_2)) == 0  
                previous_diff_index = [previous_diff_index;diff_index_2];

                clear first_choice
                
                k = 2;
                for j = 1: 2
                    first_choice(j) = sorted_txt(diff_index_2(j),k);
                end
                
                k = 3;
                for j = 1: 2
                    second_choice(j) = sorted_txt(diff_index_2(j),k);
                end
                
                
                
                %%%%%%%%%%%%%%%%%%%%%%%%%CONDITIONS START HERE%%%%%%%%%%%%%%%
                if isequal(first_choice(1),first_choice(2)) == 1 && ... % play with this.   %1
                        isequal(second_choice(1),second_choice(2)) == 0                     %0       % First choice is same but second choice is different
                    disp('Go to Condition1')
                    
                    [Assigned_proj_roll_nos_cond1,sorted_txt,stored_index,txt3,sorted_CGPA,message]...
                        =condition1(diff_index_2,sorted_txt,sorted_Roll_nos,txt3,...
                        N_students,total_choices,sorted_CGPA,max_proj_checker,Assigned_proj_roll_with_gui);
                    
                    cond1 = cond1 + 1;
                    
                    
                    Assigned_proj_roll_nos_cond1ff = [Assigned_proj_roll_nos_cond1ff;Assigned_proj_roll_nos_cond1] % Final
                    
                    clear Assigned_proj_roll_nos_cond1
                    
                    
                    
                    
                    Assigned_proj_roll_nos_fromCGPA_max_checker_cond1After = ...
                        [Assigned_proj_roll_nos_fromCGPA_DA;Assigned_proj_roll_nos_GFFF;...
                        Assigned_proj_roll_nos_ManualFF;Assigned_proj_roll_nos_cond1ff;...
                        Assigned_proj_roll_nos_cond2ff;Assigned_proj_roll_nos_cond3ff];
                    
                    Assigned_proj_roll_nos_fromCGPA_max_checker_cond1After...
                        (strcmp(Assigned_proj_roll_nos_fromCGPA_max_checker_cond1After(:,1),"NaN"),:) = [];
                    
                    projs_max_checker_cond1After = [Assigned_proj_roll_with_gui; Assigned_proj_roll_nos_fromCGPA_max_checker_cond1After];
                    BeforeOrAfter = 'After'
                    [sorted_txt,~,tracking_max_projs,~,~] = ...
                        max_proj_checker_deleter (projs_max_checker_cond1After,max_proj_checker,N_students,sorted_txt,proj_sent_no,BeforeOrAfter);
                    
                    
                    
                    
                    
                elseif isequal(first_choice(1),first_choice(2)) == 0    % This is for if first choices of two different students are different
                    disp('Go to Condition2')
                    
                    [Assigned_proj_roll_nos_cond2,sorted_txt,stored_index,txt3]...
                        = condition2(diff_index_2,sorted_txt,sorted_Roll_nos,N_students,total_choices,txt3);
                    
                    cond2 = cond2 + 1;
                    
                    
                    Assigned_proj_roll_nos_cond2ff = [Assigned_proj_roll_nos_cond2ff;Assigned_proj_roll_nos_cond2];  % Final
                    clear Assigned_proj_roll_nos_cond2
                    
                    
                    
                    Assigned_proj_roll_nos_fromCGPA_max_checker_cond2After = ...
                        [Assigned_proj_roll_nos_fromCGPA_DA;Assigned_proj_roll_nos_GFFF;...
                        Assigned_proj_roll_nos_ManualFF;Assigned_proj_roll_nos_cond1ff;...
                        Assigned_proj_roll_nos_cond2ff;Assigned_proj_roll_nos_cond3ff];
                    
                    Assigned_proj_roll_nos_fromCGPA_max_checker_cond2After...
                        (strcmp(Assigned_proj_roll_nos_fromCGPA_max_checker_cond2After(:,1),"NaN"),:) = [];
                    
                    projs_max_checker_cond2After = [Assigned_proj_roll_with_gui; Assigned_proj_roll_nos_fromCGPA_max_checker_cond2After];
                    BeforeOrAfter = 'After'
                    [sorted_txt,~,tracking_max_projs,~,~] = ...
                        max_proj_checker_deleter (projs_max_checker_cond2After,max_proj_checker,N_students,sorted_txt,proj_sent_no,BeforeOrAfter);
                    
                    
                    
                    
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    
                elseif  isequal(first_choice(1),first_choice(2)) == 1 && ...            % If both first and second choices are same
                        isequal(second_choice(1),second_choice(2)) == 1
                    disp('Go to Condition3')
                    [Assigned_proj_roll_nos_cond3,sorted_txt,stored_index,txt3,sorted_CGPA,message]...
                        = condition3(diff_index_2,sorted_txt,sorted_Roll_nos,txt3,N_students,total_choices,sorted_CGPA,max_proj_checker,Assigned_proj_roll_with_gui);
                    
                    cond3 = cond3 + 1;
                    
                    Assigned_proj_roll_nos_cond3ff = [Assigned_proj_roll_nos_cond3ff;Assigned_proj_roll_nos_cond3];  % Final
                    clear Assigned_proj_roll_nos_cond3
                    
                    
                    
                    
                    
                    
                    Assigned_proj_roll_nos_fromCGPA_max_checker_cond3After = ...
                        [Assigned_proj_roll_nos_fromCGPA_DA;Assigned_proj_roll_nos_GFFF;...
                        Assigned_proj_roll_nos_ManualFF;Assigned_proj_roll_nos_cond1ff;...
                        Assigned_proj_roll_nos_cond2ff;Assigned_proj_roll_nos_cond3ff];
                    
                    Assigned_proj_roll_nos_fromCGPA_max_checker_cond3After...
                        (strcmp(Assigned_proj_roll_nos_fromCGPA_max_checker_cond3After(:,1),"NaN"),:) = [];
                    
                    projs_max_checker_cond3After = [Assigned_proj_roll_with_gui; Assigned_proj_roll_nos_fromCGPA_max_checker_cond3After];
                    BeforeOrAfter = 'After';
                    [sorted_txt,~,tracking_max_projs,~,~] = ...
                        max_proj_checker_deleter (projs_max_checker_cond3After,max_proj_checker,N_students,sorted_txt,proj_sent_no,BeforeOrAfter);
                    
                    
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    
                    
                end
            end
        end
    end
    
    previous_No_duplicate_new = No_duplicate_new;
    
    clear choice
    clear choice_for_comparing
    clear same_CGPA_Roll_nos
    clear same_CGPA_project
    clear txt3_for_same_CGPA_cond2
    Assigned_proj_roll_nos_fromCGPA = ...
        [Assigned_proj_roll_nos_fromCGPA_DA;Assigned_proj_roll_nos_GFFF;...
        Assigned_proj_roll_nos_ManualFF;Assigned_proj_roll_nos_cond1ff;...
        Assigned_proj_roll_nos_cond2ff;Assigned_proj_roll_nos_cond3ff];
    
    Assigned_proj_roll_nos_fromCGPA(strcmp(Assigned_proj_roll_nos_fromCGPA(:,1),"NaN"),:) = [];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%
    
    %%
    %%%%%%%% For double repetation only %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
elseif length(index) == 2
    clear first_choice
    k = 2;
    for j = 1: 2
        first_choice(j) = sorted_txt(index(j),k);
    end
    
    k = 3;
    for j = 1: 2
        second_choice(j) = sorted_txt(index(j),k);
    end
    
    %%%%%%%%%%%%%%%%%%%CONDITIONS START HERE%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%% MAX PROJ CHECKING IS NOT NECESSARY HERE SINCE After this allotment It will directly go into the mtp.m (main file) where the checking is done for sure.
    
    if isequal(first_choice(1),first_choice(2)) == 1 && ... % play with this.   %1
            isequal(second_choice(1),second_choice(2)) == 0                     %0       % First choice is same but second choice is different
        disp('Go to Condition1')
        
        [Assigned_proj_roll_nos,sorted_txt,stored_index,txt3,sorted_CGPA,message]...
            =condition1(index,sorted_txt,sorted_Roll_nos,txt3,N_students,total_choices,sorted_CGPA,max_proj_checker,Assigned_proj_roll_with_gui);
        
        
        
        
    elseif isequal(first_choice(1),first_choice(2)) == 0    % This is for if first choices of two different students are different
        disp('Go to Condition2')
        
        [Assigned_proj_roll_nos,sorted_txt,stored_index,txt3]...
            = condition2(index,sorted_txt,sorted_Roll_nos,N_students,total_choices,txt3);
        
        
        
    elseif  isequal(first_choice(1),first_choice(2)) == 1 && ...            % If both first and second choices are same
            isequal(second_choice(1),second_choice(2)) == 1
        disp('Go to Condition3')
        [Assigned_proj_roll_nos,sorted_txt,stored_index,txt3,sorted_CGPA,message]...
            = condition3(index,sorted_txt,sorted_Roll_nos,txt3,N_students,total_choices,sorted_CGPA,max_proj_checker,Assigned_proj_roll_with_gui);
        
        
        
    end
    
    previous_No_duplicate_new = No_duplicate_new;
    
    clear choice
    clear choice_for_comparing
    clear same_CGPA_Roll_nos
    clear same_CGPA_project
    clear txt3_for_same_CGPA_cond2
    Assigned_proj_roll_nos_fromCGPA = Assigned_proj_roll_nos;
end
% final_res{i} = Assigned_proj_roll_nos{:,1:2}; % need to write differently.
end



%
% final_res{:,1:}
%
% [original_proj_list(:,2) txt3(:,2)];










