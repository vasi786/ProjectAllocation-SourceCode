function ManualProjectAllocation(IM)

f = figure;
f.Position = [300 50 1000 700];
% IM = {'R1' 'P1';'R2' 'P2';'R3' 'P3';'R4' 'P4';'R5' 'P5'...
%     ;'R6' 'P6';'R7' 'P7';'R8' 'P8';'R9' 'P9';'R10' 'P10';};

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