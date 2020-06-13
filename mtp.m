
[num,txt] = xlsread('Book 1.xlsx');  % importing the file

txt = string(txt(1,:));   % First row contains headings

button = 'NAME' 
button_2 = 'CGPA'   

for i = 1: length(txt)
    if contains(txt(i),button)
        disp(['The candidate name column is : (', num2str(i),')'])
    elseif contains (txt(i),button_2)
        disp(['The CGPA column is : (', num2str(i),')'])
    end
end

