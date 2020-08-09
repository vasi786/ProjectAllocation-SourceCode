function [Decisions_gui,msg_gui] = ManualProjectAllocation(Rolls,projs)
clc
msg = 'NaN';

f = figure('Name','Manual Selection','NumberTitle','off','units','normalized','Color',[1 1 1]);

set(f, 'MenuBar', 'none');
f.WindowState = 'maximized';
f.Position = [100,100,1107,833];

%f.Position = [300 50 1000 700];
%f = uifigure('Position',[300 50 1000 700]);

%
% Rolls = {'184107102' ;'184107103';'184107104' ;'184107105' ;'184107106' ...
   %  '184107107' ;'184107108' ;'184107109' ;'184107110' ;'184107111' ;};
%
%projs = {'tamalproj2'; 'tamalproj3';'tamalproj4';'tamalproj5';'tamalproj6'...
   %  'tamalproj7';'tamalproj8'; 'tamalproj9'; 'tamalproj10'; 'tamalproj11';'kjdslk';};

%
% fig = uifigure;
% uit = uitable(fig,'Data',projs);


M = 1;

text_field = uicontrol('style','text','string','Manually Allocate The Projects');
text_field.Position = [168 900 900 42];
text_field.FontSize = 25;

for K = 1 : length(Rolls)

    LH(K) = uicontrol('Parent',f,'Style','pushbutton','string', string(Rolls(K,1)));
    LH(K).HorizontalAlignment = 'left';
    LH(K).FontSize = 12;
    LH(K).FontName = 'Helvetica';
    t = 870-K*60;  % vertical distance between the labels
    LH(K).Position =   [102 t 110 42]; %[42 t 200 50];
    %Drop downs
    %u = 700-M*60;
    DD(M) = uicontrol('style','popup','string',projs(M,:));
    DD(M).FontSize = 13;
    DD(M).Position = [362 t-15 764 52]; %[300 u 800 50];
    
    if M == size(projs,1)
        
        break
        
    end
    M = M + 1;
end


% LastName = projs;
% Age = [38;43;38;40;49];
% Height = [71;69;64;67;64];
% Weight = [176;163;131;133;119];
% T = table(projs,'RowNames',Rolls);
%
%
%


% uitable('Data',T{:,:},'ColumnName',T.Properties.VariableNames,...
%     'RowName',T.Properties.RowNames,'Units', 'Normalized', 'Position',[0.5 0.2 0.1 0.1]);



assignin('base','D',DD);

PB = uicontrol('Style', 'push', 'String', 'Confirm','CallBack',@(source,event) PushB(DD,Rolls));
PB.Position = [499 650 120 52];
PB.FontSize = 13;
PB.FontName = 'Helvetica';

%   global Decisions

    function Decisions = PushB(DD,Rolls)
        % data = guidata(gcbo)
        for K = 1: length(Rolls)
            sprojs = projs(K,:);
            Decisions(K) = sprojs(DD(K).Value);
        end
        
        uiresume(f)
        closereq
        
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

