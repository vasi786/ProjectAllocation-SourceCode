
function[N_students,sorted_txt,txt3] = recommendations_fn(Roll_nos_GUI,Projnames_GUI,txt3,sorted_txt,N_students,IA)


for i = 1 : length(Projnames_GUI)
    
    if isequal(Projnames_GUI(i),{'Select'}) == 0
        a = find(strcmpi(Projnames_GUI(1),txt3(:,1))==1);
        
        proj_code_name = txt3(a,2);
        
        txt3(a,2) = {'Assigned'};
        
        [sorted_txt] = removingproj (proj_code_name,sorted_txt,N_students);
    else 
        break
    end
end

clear i

for i = 1: length(Roll_nos_GUI)
    if isequal(str2double(Roll_nos_GUI(1)),{'Select'}) == 0
        k = getindex(str2double(Roll_nos_GUI(i)),IA);
        sorted_txt(k,:) = [];
        N_students = N_students - 1;
    end
end