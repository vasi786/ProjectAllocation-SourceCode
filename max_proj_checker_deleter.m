function [sorted_txt,message_MAX_PROJS,tracking_max_projs,message_MAX_PROJS2,message_MAX_PROJS3] = ...
    max_proj_checker_deleter (proj_name,max_proj_checker,N_students,sorted_txt,proj_sent_no,BeforeOrAfter)

message_MAX_PROJS3 = [];
if BeforeOrAfter == "BeforeCond1" || BeforeOrAfter == "BeforeCond2"
    BeforeOrAfter = 'Before';
    extracondition = "Yes";
else
    BeforeOrAfter;
    extracondition = "No";
end

% [~,idx]=unique(  strcat(proj_name(:,1),proj_name(:,2)) , 'rows');
%  proj_name=proj_name(idx,:)


for u = 1 : size(proj_name,1)
    proj_name{u,1} = proj_name{u,1}(1:end-1);
end
%proj_name = Assigned_projs_rolls_with_gui_codes(:,1);

if proj_sent_no > 0
    disp('need to check')
end


for i = 1 : size(proj_name,1)
    
    proj_name(i);
    
    repeation = find(strncmpi(proj_name(i),proj_name,strlength(proj_name(i))));
    proj_occurence = length(repeation);
    
    checking_with_base =...
        find(strncmpi(proj_name(i),max_proj_checker(:,1),strlength(proj_name(i))));
    
    if str2double(max_proj_checker(checking_with_base,2)) == proj_occurence && BeforeOrAfter == "After"
        
        msg =  sprintf('Prof. '+string(proj_name{i}(1:end-4))+' Project Allotment Max Limit Reached');
        for m = 1: N_students
            extracted_txt = sorted_txt(m,:);
            extracted_txt(find(contains(extracted_txt,proj_name(i)))) = [];
            new_sorted_txt(m,:) = extracted_txt;
            clear extracted_txt
        end
        sorted_txt = new_sorted_txt;
        clear new_sorted_txt
        
    elseif str2double(max_proj_checker(checking_with_base,2)) - proj_occurence < 0 % This is a special case where the project is not assigned but came for checking what is the limit.
        
        msg =  sprintf('Prof. '+string(proj_name{i}(1:end-4))+' Project Allotment Max Limit Reached');
        for m = 1: N_students
            extracted_txt = sorted_txt(m,:);
            extracted_txt(find(contains(extracted_txt,proj_name(i)))) = [];
            new_sorted_txt(m,:) = extracted_txt;
            clear extracted_txt
        end
        sorted_txt = new_sorted_txt;
        clear new_sorted_txt
        
    end
    
    
    if str2double(max_proj_checker(checking_with_base,2))-proj_occurence > 0
        
        message_MAX_PROJS='Only'+string(str2double(max_proj_checker(checking_with_base,2)) - (proj_occurence))+'Left';
    else
        message_MAX_PROJS='NoneLeft';
    end
    
    if str2double(max_proj_checker(checking_with_base,2))-proj_occurence + proj_sent_no > 0 && extracondition == 'Yes'
        message_MAX_PROJS2 = 'Only'+string(str2double(max_proj_checker(checking_with_base,2))...
            - (proj_occurence) + proj_sent_no-1)+'Left'; % If projects are sent as an array
        message_MAX_PROJS3 = 'Only'+string(str2double(max_proj_checker(checking_with_base,2))...
            - (proj_occurence) + proj_sent_no -1)+'Left';
    elseif str2double(max_proj_checker(checking_with_base,2))-proj_occurence + proj_sent_no == 0 && BeforeOrAfter == "Before"
        message_MAX_PROJS2 = 'Only'+string(str2double(max_proj_checker(checking_with_base,2))...
            - (proj_occurence) + proj_sent_no)+'Left'; % If projects are sent as an array
        message_MAX_PROJS3 = 'Only'+string(str2double(max_proj_checker(checking_with_base,2))...
            - (proj_occurence) + proj_sent_no + 1)+'Left';
        
    elseif str2double(max_proj_checker(checking_with_base,2))-proj_occurence + proj_sent_no == 0 && BeforeOrAfter == "After"
        message_MAX_PROJS2 = 'NoneLeft'; % If projects are sent as an array
        message_MAX_PROJS3 = 'NoneLeft';
        
    elseif ...
            str2double(max_proj_checker(checking_with_base,2))-...
            proj_occurence + proj_sent_no >0 && BeforeOrAfter == "Before" && extracondition == 'No'
        message_MAX_PROJS2 = 'Only'+string(str2double(max_proj_checker(checking_with_base,2))...
            - (proj_occurence) + proj_sent_no)+'Left'; % If projects are sent as an array
        message_MAX_PROJS3 = 'Only'+string(str2double(max_proj_checker(checking_with_base,2))...
            - (proj_occurence) + proj_sent_no + 1)+'Left';
        
    elseif ...
            str2double(max_proj_checker(checking_with_base,2))-...
            proj_occurence + proj_sent_no >0 && BeforeOrAfter == "After" && extracondition == 'No'
        message_MAX_PROJS2 = 'Only'+string(str2double(max_proj_checker(checking_with_base,2))...
            - (proj_occurence) + proj_sent_no-1)+'Left'; % If projects are sent as an array
        message_MAX_PROJS3 = 'Only'+string(str2double(max_proj_checker(checking_with_base,2))...
            - (proj_occurence) + proj_sent_no )+'Left';
    end
    
    
    if length(message_MAX_PROJS3)<1
        msg = 'This can be due to improper closing of previous windows. Either use done or any other buttons to close. But do not press the close button on the top of the window to close a window.';
        error(msg);
    end
    tracking_max_projs(i,:) = [proj_name(i) message_MAX_PROJS3];
    %proj_name(
end


% if proj_name == ["NaN" "NaN"]
%     tracking_max_projs = [];
%     message_MAX_PROJS = [];
%     message_MAX_PROJS2 = [];
%     message_MAX_PROJS3=[];
% end
end