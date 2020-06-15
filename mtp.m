clc
for i = 1: length(Roll_nos_choices)
    if Roll_nos_choices(i) == Roll_nos_CGPA(i)
        sprintf('Roll no %.f ,matched in both files',Roll_nos_choices(i));
    else
        Warning = sprintf('Info about Roll no %.f or %.f are missing in either one of the file',Roll_nos_choices(i),Roll_nos_CGPA(i))
        error('Error, exiting');
    end
end
