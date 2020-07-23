
function[N_students,txt,txt3,roll_and_CGPA] = ...
    recommendations_fn(Roll_nos_GUI,Projnames_GUI,txt3,...
    txt,N_students,roll_and_CGPA)




for i = 1 : length(Projnames_GUI)
    
    if isequal(Projnames_GUI(i),{'Select'}) == 0
        a = find(strcmpi(Projnames_GUI(i),txt3(:,1))==1);
        
        proj_code_name = txt3(a,2);
        
        txt3(a,2) = {'Assigned'};
        
        txt = removingproj (proj_code_name,txt,N_students);
   
    end
end

clear i

for i = 1: length(Roll_nos_GUI)
    if isequal(Roll_nos_GUI(i),{'Select'}) == 0
        k = getindex(str2double(Roll_nos_GUI(i)),roll_and_CGPA(:,1));
        roll_and_CGPA(k,:) = [];
        txt(k,:) = [];
        N_students = N_students - 1;
    end
    
end
