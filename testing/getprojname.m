function [project_Name] = getprojname(project_Keyword,original_proj_list)
% function supplies project name for project keyword
% Note: txt3 should be loaded in memory for succesfull operation
  for i=1:length(original_proj_list)
      if strcmpi(project_Keyword,original_proj_list(i,2))
          project_Name = original_proj_list(i,1);
      end
  end
end