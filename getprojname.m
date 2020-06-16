function [project_Name] = getprojname(project_Keyword,txt3)
% function supplies project name for project keyword
% Note: txt3 should be loaded in memory for succesfull operation
  for i=1:length(txt3)
      if strcmpi(project_Keyword,txt3(i,2))
          project_Name = txt3(i,1)
      end
  end
end
