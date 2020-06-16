 clc;
% filename1 = 'students-choices';
% filename2 = 'prof_list-keywords.xlsx';
% filename3 = 'student gate scroes'

[file1,filepath1] = uigetfile({'*.*','Select the Excel file (.xlsx)'},...
    'please upload the excel file which contains student choices');
filename1 = fullfile(filepath1, file1);
[num,txt] = xlsread(filename1);


[file2,filepath2] = uigetfile({'*.*','Select the Excel file (.xlsx)'},...
   'please upload the excel file that containes proffesor list keyword' );
filename2 = fullfile(filepath2, file1);
[num2,txt2] = xlsread(filename2);


[file,filepath] = uigetfile({'*.*','Select the Excel file (.xlsx)'},...
    'please upload the excel file that containes name and roll no');
filename = fullfile(filepath, file);
[num_sort,txt_sort] = xlsread(filename);

[file3,filepath3] = uigetfile({'*.*','Select the Excel file (.xlsx)'},...
    'please upload the excel file which student gate scores');
filename3 = fullfile(filepath3, file3);
[num3,txt3] = xlsread(filename1);


for i = 1: length(Roll_nos_choices)
    if Roll_nos_choices(i) == Roll_nos_CGPA(i)
        
        sprintf('Roll no %.f ,matched in both files',Roll_nos_choices(i));
    else
        Error_Prone = sprintf('Info about Roll no %.f or %.f are missing in either one of the file',Roll_nos_choices(i),Roll_nos_CGPA(i))
        error('Error, exiting');
    end
end

original_proj_list = txt3;
txt_without_headings = txt(2:end,:);
sorted_txt = txt_without_headings(sort_index,:);


for i = 1: N_students-1
    
    for j = 2: total_choices
        
        if contains(sorted_txt(i,j),txt3(j-1,2))
            Assigned_proj_roll_nos = [txt3(j-1,2) sorted_Roll_nos(i)]
            txt3(j-1,2) = {'Assigned'};
            
            break
            
        end
        
    end
    
end



[original_proj_list txt3(:,2)]
