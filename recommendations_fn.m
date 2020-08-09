
function[N_students,txt,txt3,roll_and_CGPA,Roll_nos_GUI,Projnames_GUI] = ...
    recommendations_fn(Roll_nos_GUI,Projnames_GUI,txt3,...
    txt,N_students,roll_and_CGPA)



%Projnames_GUI = Projnames_GUI(cellfun(@(s)isempty(regexp(s,'Select a project')),Projnames_GUI));
%Roll_nos_GUI = Roll_nos_GUI(cellfun(@(s)isempty(regexp(s,'Select a roll number')),Roll_nos_GUI));


for i = 1 : length(Projnames_GUI)
    
    
    if isequal(Projnames_GUI(i),{'Select a project'}) == 0
        a = find(strcmpi(Projnames_GUI(i),txt3(:,1))==1);
        
        proj_code_name = txt3(a,2);
        
        txt3(a,2) = {'Assigned'};
        
        txt = removingproj (proj_code_name,txt,N_students);
        
    end
end

clear i




for i = 1: length(Roll_nos_GUI)
    Roll_nos_GUI(find(strcmpi(Roll_nos_GUI(i),{'Select a roll number'}))) = [];
    
    if isequal(Roll_nos_GUI(i),{'Select a roll number'}) == 0
        k = getindex(str2double(Roll_nos_GUI(i)),roll_and_CGPA(:,1));
        roll_and_CGPA(k,:) = [];
        txt(k,:) = [];
        N_students = N_students - 1;
    end
    
end
