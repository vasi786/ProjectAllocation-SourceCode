

function [No_of_same_choice_students,Assigned_proj_roll_nos_fromCGPA,...
    No_duplicate,sorted_txt,txt3,message,stored_index,sorted_CGPA,Already_computed] ...
    = same_CGPA(sorted_CGPA,sorted_txt,sorted_Roll_nos,...
    txt3,N_students,total_choices,original_sorted_CGPA,...
    No_duplicate,stored_index,Student_no,Already_computed)

%%

message = 'NaN';


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
    
    if No_duplicate(i) > 0 && stored_index == 0
        sorted_CGPA(find(sorted_CGPA(:,2)==No_duplicate(i)),:) = [];
    elseif No_duplicate(i) > 0
        sorted_CGPA(find(sorted_CGPA(:,2)==No_duplicate(i)),:) = [];
        No_duplicate(end) = [];
        
    end
    
end

No_duplicate_new = min(unique(sorted_CGPA(:,2)));


No_duplicate = [No_duplicate;No_duplicate_new];

index = find(original_sorted_CGPA(:,2) == No_duplicate_new); % Gives you the correct index;

if stored_index ~= 0
    index(stored_index) = [];   % stored index is for the direct assignment which are having three first diffent choices
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
    
    k = 2;
    
    for j = 1: length(index)
        first_choice(j) = sorted_txt(index(j),k);
    end
    
    
    clear j
    
    for j = 1 : length(first_choice)
        
        comparision(j,:) = strncmpi(first_choice{j},first_choice,strlength(first_choice{j}));
        
        if sum(comparision) >= 2
            answer = questdlg('There is a clash in choices and CGPA, How do you like to continue?',...
                'Choices',...
                'Compare GATE Score','Do It Manually','Compare GATE Score');
            switch answer
                case 'Compare GATE Score'
                    disp('Here comes the gate score function file')
                    
                    for r = 1 : length(index)
                        
                        Rolls_for_gate(r)=sorted_Roll_nos(index(r));
                        first_choice_FGATE(r) = sorted_txt(index(r),2);
                        
                    end
                    clear r
                    [gate_winner,I] = GateScore_decision(Rolls_for_gate)
                    
                    winner_roll_nos = gate_winner(:,1);
                    
                    for r = 1: length(winner_roll_nos)
                        
                    proj_for_roll_no_gate = sorted_txt(index(r),2);  %  extra step do not consider this project. 
                    proj_for_winner_roll_nos = proj_for_roll_no_gate; % check I(r),:
                    Assigned_proj_roll_nos(r,:) = string([proj_for_winner_roll_nos winner_roll_nos(r)])
                    message = 'Gate_Direct_assignment';
                    sorted_txt = delproj(proj_for_winner_roll_nos,sorted_txt,N_students);
                    txt3 = assign(proj_for_winner_roll_nos,total_choices,txt3);
                    %stored_index(r) = index(r);
                    sorted_CGPA(r,2) = 0;  % So that when the same CGPA comes in the next iteration doesn't
                    % take care of this student.
                    end
                    
                  %  No_duplicate(end) = [];

                    Assigned_proj_roll_nos_fromCGPA = Assigned_proj_roll_nos;
                    break
                case 'Do It Manually'
                    disp ('display the roll nos and names of the clashing persons and ask user to do it manually');
                      
                    for s = 1 : length(index)
                        
                        Rolls_for_manual(s)=sorted_Roll_nos(index(s));
                        projs_for_manual(s) = sorted_txt(index(s),2);
                        
                    end
            end
            break
            
        elseif sum(comparision) == 1
            
            index(j) = find(comparision == 1)
            disp('direct assignment');
            Roll_no_direct_assignment = sorted_Roll_nos(index(j)+Student_no-1);
            proj_for_direct_assignment = sorted_txt(index(j)+Student_no-1,2);
            Assigned_proj_roll_nos(1,:) = string([proj_for_direct_assignment Roll_no_direct_assignment])
            Assigned_proj_roll_nos_fromCGPA = Assigned_proj_roll_nos;
            message = 'Direct_assignment';
            sorted_txt = delproj(proj_for_direct_assignment,sorted_txt,N_students);
            txt3 = assign(proj_for_direct_assignment,total_choices,txt3);
            stored_index = index(j);
            sorted_CGPA(index(j),2) = 0;  % So that when the same CGPA comes in the next iteration doesn't
            % take care of this student.
            No_duplicate(end) = [];
            
            break
            
        end
    end
    %%
    
    %%
    %%%%%%%% For double repetation only %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
elseif length(index) == 2   % Needed to be updated
    
    k = 2;
    for j = 1: 2
        first_choice(j) = sorted_txt(index(j),k);
    end
    
    k = 3;
    for j = 1: 2
        second_choice(j) = sorted_txt(index(j),k);
    end
    
    if isequal(first_choice(1),first_choice(2)) == 1 && ... % play with this.   %1
            isequal(second_choice(1),second_choice(2)) == 0                     %0
        disp('Go ahead')
        
        k = 2;
        for j = 1: length(index)
            choice(j) = sorted_txt(index(j),k);
            choice_for_comparing{j} = choice{j}(1:end-1);
            same_CGPA_Roll_nos(j) = sorted_Roll_nos(index(j));
            same_CGPA_project(j) = sorted_txt(index(j),k);
            k = k+1;
        end
        
        
        if isequal(choice_for_comparing(1),choice_for_comparing(2)) == 1
            disp('condition_1 success')
            for i = 1: length(txt3)
                txt3_for_same_CGPA_cond2{i} = txt3{i,2}(:,1:end-1);
                i;
            end
            %%
            if sum ( strcmp(choice_for_comparing{1},txt3_for_same_CGPA_cond2) ) >= 2  % >= 2
                
                for k = 1: 2
                    Assigned_proj_roll_nos(k,:) = string([same_CGPA_project(k) same_CGPA_Roll_nos(k)]);
                    sorted_txt = delproj(same_CGPA_project(k),sorted_txt,N_students);
                    stored_index = 0;
                end
                
                txt3 = assign(choice,total_choices,txt3);
                
            else
                answer = questdlg('There is a clash in choices and CGPA, How do you like to continue?',...
                    'Choices',...
                    'Compare GATE Score','Do It Manually','Compare GATE Score');
                switch answer
                    case 'Compare GATE Score'
                        disp('Here comes the gate score function file')
                        
                        for r = 1 : length(index)
                            
                            Rolls_for_gate(r)=sorted_Roll_nos(index(r));
                            first_choice_FGATE(r) = sorted_txt(index(r),2);
                            
                        end
                        clear r
                        [gate_winner] = GateScore_decision(Rolls_for_gate)
                        gate_msg = 'Opted_for_gate';
                        
                    case 'Do it manually'
                        disp ('display the roll nos and names of the clashing persons and ask user to do it manually');
                end
            end
            %
        end
    elseif isequal(first_choice(1),first_choice(2)) == 0    % This is for if first choices of two different students are different
        disp('wait')
        
        
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
        txt3 = assign(choice,total_choices,txt3);
        
    elseif  isequal(first_choice(1),first_choice(2)) == 1 && ...
            isequal(second_choice(1),second_choice(2)) == 1
        
        k = 2;
        for j = 1: length(index)
            choice(j) = sorted_txt(index(j),k);
            choice_for_comparing{j} = choice{j}(1:end-1);
            same_CGPA_Roll_nos(j) = sorted_Roll_nos(index(j));
            same_CGPA_project(j) = sorted_txt(index(j),k);
            k = k+1;
        end
        clear k;
        for k = 1: 2
            Assigned_proj_roll_nos(k,:) = string([same_CGPA_project(k) same_CGPA_Roll_nos(k)]);
            sorted_txt = delproj(same_CGPA_project(k),sorted_txt,N_students);
            stored_index = 0;
        end
        txt3 = assign(choice,total_choices,txt3);
        
        
    end
    clear choice
    clear choice_for_comparing
    clear same_CGPA_Roll_nos
    clear same_CGPA_project
    clear txt3_for_same_CGPA_cond2
    Assigned_proj_roll_nos_fromCGPA = Assigned_proj_roll_nos;
    % final_res{i} = Assigned_proj_roll_nos{:,1:2}; % need to write differently.
end


%
% final_res{:,1:}
%
% [original_proj_list(:,2) txt3(:,2)];










