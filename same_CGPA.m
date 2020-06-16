clc;clear
assigning_project_codes,Sorting_CGPA,mtp

No_duplicates = max(sorted_CGPA(:,2));


assign = @assignment;
delproj = @removingproj;

for i = 1: No_duplicates
    
    sprintf('Number of duplicates of 2 matching CGPAs are %f',No_duplicates)
    index = find(sorted_CGPA(:,2) == i);
    
    if length(index) == 2   % Needed to be updated
        k = 2;
        for j = 1: 2
            choice(j) = sorted_txt(index(j),k);
        end
        if isequal(choice(1),choice(2)) == 1     % play with this.
            disp('Go ahead')
            
            
            k = 2;
            for j = 1: length(index)
                choice(j) = sorted_txt(index(j),k);
                choice_for_comparing{j} = choice{j}(1:end-1)
                same_CGPA_Roll_nos(j) = sorted_Roll_nos(index(j));
                same_CGPA_project(j) = sorted_txt(j,index(j)+1);
                k = k+1;
            end
            
            
            if isequal(choice_for_comparing(1),choice_for_comparing(2)) == 1
                disp('condition_1 success')
                for i = 1: length(txt3)
                    txt3_for_same_CGPA_cond2{i} = txt3{i,2}(:,1:end-1);
                    i
                end
                
                if sum ( strcmp(choice_for_comparing{1},txt3_for_same_CGPA_cond2) ) >= 2
                    
                    for k = 1: 2
                        Assigned_proj_roll_nos{k} = [same_CGPA_project(k) same_CGPA_Roll_nos(k)]
                        sorted_txt = delproj(same_CGPA_project(k),sorted_txt,N_students);
                    end
                    
                    txt3 = assign(choice,total_choices,txt3)
                end
            end
        else    % This is for if first choices of two different students are different,
            disp('wait')
            k = 2;
            for j = 1: length(index)
                choice(j) = sorted_txt(index(j),k);
                same_CGPA_Roll_nos(j) = sorted_Roll_nos(index(j));
                same_CGPA_project(j) = sorted_txt(index(j),2); % Lot of confusion, everytime name of the student
                %is coming in the middle, better if we take name from
                %txt matrix
            end
            for k = 1: 2
                Assigned_proj_roll_nos{k} = [same_CGPA_project(k) same_CGPA_Roll_nos(k)]
                        sorted_txt = delproj(same_CGPA_project(k),sorted_txt,N_students);
            end
            txt3 = assign(choice,total_choices,txt3)
        end
        
    end
    clear choice
    clear choice_for_comparing
    clear same_CGPA_Roll_nos
    clear same_CGPA_project
    clear txt3_for_same_CGPA_cond2
    Assigned_proj_roll_nos{:,1:2}
end

[original_proj_list(:,2) txt3(:,2)];

%%%%% Function file for removing projects when they are assigned %%%%%
function[sorted_txt] = removingproj (same_CGPA_project,sorted_txt,N_students)

for i = 1:N_students-1
    extracted_txt = sorted_txt(i,:);
    extracted_txt(strcmp(extracted_txt,same_CGPA_project)) = []
    new_sorted_txt(i,:) = extracted_txt;
    clear extracted_txt
end
sorted_txt = new_sorted_txt
end

%%%%%% Function file for assigning "Assigned " to txt3;

    function[txt3] = assignment(choice,total_choices,txt3)
        m = 1;
        for r = 1: total_choices
            
            if contains(choice(m),txt3(r,2))
                txt3(r,2) = {'Assigned'};
                r = 1;
                m = m + 1;
                if m > length(choice)
                    break
                end
            end
            
        end
    end




