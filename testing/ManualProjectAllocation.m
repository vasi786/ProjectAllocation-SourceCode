function ManualProjectAllocation(IM)

f = figure;
f.Position = [300 50 1000 700];
 IM = {'184107102' 'tamalproj2';'184107103' 'tamalproj3';'184107104' 'tamalproj4';'184107105' 'tamalproj5';'184107106' 'tamalproj6'...
     ;'184107107' 'tamalproj7';'184107108' 'tamalproj8';'184107109' 'tamalproj9';'184107110' 'tamalproj10';'184107111' 'tamalproj11';};

for K = 1 : length(IM)
    LH(K) = uicontrol('Parent',f,'Style', 'text', 'String', IM(K,1));
    LH(K).HorizontalAlignment = 'left';
    LH(K).FontSize = 12;
    LH(K).FontName = 'Serif';
    t = 700-K*60;  % vertical distance between the labels
    LH(K).Position = [42 t 200 50];
    %Drop downs
    DD(K) = uicontrol('style','popup','string',IM(:,2));
    DD(K).Position = [300 t 500 50];
end

assignin('base','D',DD);
PB = uicontrol('Style', 'push', 'String', 'Confirm','CallBack', @(source,event) PushB(DD,IM));
PB.Position = [499 50 100 22];

    function PushB(DD,IM)
        % data = guidata(gcbo)
        for K = 1: length(IM)
            Decisions(K) = IM(DD(K).Value,2);
        end
        assignin('base','Decisions_gui',Decisions);
        closereq
    end
end 
