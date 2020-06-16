clc;clear
assigning_project_codes,Sorting_CGPA,mtp

No_duplicates = max(sorted_CGPA(:,2));

for i = 1: No_duplicates
    
    index = find(sorted_CGPA(:,2) == i);
    
    if length(index) == 2   % Needed to be updated
        k = 1;
        for j = 1: length(index)
            choice(j) = sorted_txt(index(j),k);
        end
        if isequal(choice(1),choice(2)) == 1
            disp('Go ahead')
            
            
            k = 2;
            for j = 1: length(index)
                choice(j) = sorted_txt(index(j),k);
                choice_for_comparing{j} = choice{j}(1:end-1)
                same_CGPA_Roll_nos(j) = sorted_Roll_nos(index(j));
                same_CGPA_project(j) = txt(j+1,index(j)+1);
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
                    end
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
            end
        else
            disp('wait')
            k = 2;
            for j = 1: length(index)
                choice(j) = sorted_txt(index(j),k); 
                
            end
        end
        
    end
end
