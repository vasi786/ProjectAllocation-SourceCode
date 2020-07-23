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