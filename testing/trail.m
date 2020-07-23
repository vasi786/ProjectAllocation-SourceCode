
clc;clear

first_choice = {'vimproj1','vimproj2','vimproj1','vimproj2','vimproj1','vimproj2','vimproj3,''vimproj1','vimproj1','vimproj1','vimproj3'}

for j = 1 : length(first_choice)
    
    comparision = strncmpi(first_choice{j},first_choice,strlength(first_choice{j}))
    
    if sum(comparision) > 2
        answer = questdlg('There is a clash in choices and CGPA, How do you like to continue?',...
            'Choices',...
            'Compare GATE Score','Do It Manually','Compare GATE Score');
        switch answer
            case 'Compare GATE Score'
                disp('Here comes the gate score function file')
            case 'Do it manually'
                disp ('display the roll nos and names of the clashing persons and ask user to do it manually');
        end
    elseif sum(comparision) == 2
        disp ('need to send it further down')
        
    else
        disp('direct assignment');
    
    end
end