function [Decisions_gui,msg_gui] = ManualProjectAllocation_2(Rolls,projs,messages_for_Manual_maxchecker_unique)
clc
msg = 'NaN';

messages_for_Manual_maxchecker_unique2(:,1) = 'Prof. ' + messages_for_Manual_maxchecker_unique(:,1);
messages_for_Manual_maxchecker_unique2(:,2) = messages_for_Manual_maxchecker_unique(:,2);
fig = uifigure('Name','Maximum Number of projects','Position',[480 400 560 300]);
u = uitable(fig,'Position',[20 20 500 250],'Data',messages_for_Manual_maxchecker_unique2);
set(u,'columnname',{'Name of the Professor','Maximum Number of projects available to allot'})


f = figure('Name','Manual Selection','NumberTitle','off','units','normalized','Color',[1 1 1]);

set(f, 'MenuBar', 'none');
f.WindowState = 'maximized';
f.Position = [100,100,1107,833];

%f = uifigure('Position',[300 50 1000 700]);

%
 %Rolls = {'184107102' ;'184107103';'184107104' ;'184107105' ;'184107106'; ...
     %'184107107' ;'184107108' ;'184107109' ;'184107110' ;'184107111' };
%
%projs = {'tamalproj2'; 'tamalproj3';'tamalproj4';'tamalproj5';'tamalproj6';...
     %'tamalproj7';'tamalproj8'; 'tamalproj9'; 'tamalproj10'; 'tamalproj11';};

%



M = 1;
text_field = uicontrol('style','text','string','Allot the projects based on the maximum no of projects available per professor.');
text_field.Position = [168 900 1300 42];
text_field.FontSize = 25;

for K = 1 : length(Rolls)

    LH(K) = uicontrol('Parent',f,'Style','pushbutton','string', string(Rolls(K,1)));
    LH(K).HorizontalAlignment = 'left';
    LH(K).FontSize = 12;
    LH(K).FontName = 'Helvetica';
    LH(K).BackgroundColor = [0.8 0.8 0.8];
    t = 870-K*60;  % vertical distance between the labels
    LH(K).Position =   [102 t 110 42] %[42 t 200 50];
    %Drop downs
    %u = 700-M*60;
    DD(M) = uicontrol('style','popup','string',projs(M,:));
    DD(M).FontSize = 13;
    DD(M).Position = [362 t-15 764 52] %[300 u 800 50];
    
    if M == size(projs,1)
        
        break
        
    end
    M = M + 1;
end

%
%
%


% uitable('Data',T{:,:},'ColumnName',T.Properties.VariableNames,...
%     'RowName',T.Properties.RowNames,'Units', 'Normalized', 'Position',[0.5 0.2 0.1 0.1]);



assignin('base','D',DD);

PB = uicontrol('Style', 'push', 'String', 'Confirm','CallBack',@(source,event) PushB(DD,Rolls));
PB.Position = [499 450 120 52];
%   global Decisions

    function Decisions = PushB(DD,Rolls)
        % data = guidata(gcbo)
        for K = 1: length(Rolls)
            sprojs = projs(K,:);
            Decisions(K) = sprojs(DD(K).Value);
        end
        
        uiresume(f)
        closereq
        close(fig)
        
        setappdata(0,'final',Decisions);
        
        
        if length(unique(Decisions))< length(Rolls)
            
            m = errordlg('Clash in user assigned choices. Make sure the choices are unique','Error');
            msg = 'Clash in user assigned choices. Make sure the choices are unique';
        end
        setappdata(0,'msg_gui',msg);
        
        % assignin("same_CGPA",'Decisions_gui',Decisions);
        % assignin("same_CGPA",'msg_gui',msg);
       

    end
%  delete uit;
uiwait(f);

        Decisions_gui = getappdata(0,'final');
        msg_gui = getappdata(0,'msg_gui');

        
  
             
            


end

