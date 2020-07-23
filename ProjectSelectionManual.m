function ProjectSelectionManual(IM) 
% IM = {'RollNo1' 'Project1';'RollNo2' 'Project2';'RollNo3' 'Project3'};
% Create UIFigure
UIFigure = uifigure;
UIFigure.Position = [100 100 640 480];
UIFigure.Name = 'UI Figure';

% % Create ManualProjectAllocationPanel
ManualProjectAllocationPanel = uipanel(UIFigure);
ManualProjectAllocationPanel.ForegroundColor = [1 0.4118 0.1608];
ManualProjectAllocationPanel.BorderType = 'none';
ManualProjectAllocationPanel.TitlePosition = 'centertop';
ManualProjectAllocationPanel.Title = 'Manual Project Allocation';
ManualProjectAllocationPanel.BackgroundColor = [0.0588 0.149 0.149];
ManualProjectAllocationPanel.FontName = 'Arimo';
ManualProjectAllocationPanel.FontWeight = 'bold';
ManualProjectAllocationPanel.FontSize = 15;
ManualProjectAllocationPanel.Position = [23 178 579 231];

% Create DD1Label
DD1Label = uilabel(ManualProjectAllocationPanel);
DD1Label.BackgroundColor = [0.0588 0.149 0.149];
DD1Label.HorizontalAlignment = 'right';
DD1Label.FontColor = [1 1 1];
DD1Label.Position = [42 159 75 22];
DD1Label.Text = IM(1,1);

% Create DD1
DD1 = uidropdown(ManualProjectAllocationPanel);
DD1.Items = IM(:,2);
DD1.FontColor = [1 1 1];
DD1.BackgroundColor = [0.0588 0.149 0.149];
DD1.Position = [150 159 100 22];



% Create DD2Label
DD2Label = uilabel(ManualProjectAllocationPanel);
DD2Label.BackgroundColor = [0.0588 0.149 0.149];
DD2Label.HorizontalAlignment = 'right';
DD2Label.FontColor = [1 1 1];
DD2Label.Position = [43 105 75 22];
DD2Label.Text = IM(2,1);

% Create DD2
DD2 = uidropdown(ManualProjectAllocationPanel);
DD2.Items = IM(:,2);
DD2.FontColor = [1 1 1];
DD2.BackgroundColor = [0.0588 0.149 0.149];
DD2.Position = [150 105 100 22];

% Create DD3Label
DD3Label = uilabel(ManualProjectAllocationPanel);
DD3Label.BackgroundColor = [0.0588 0.149 0.149];
DD3Label.HorizontalAlignment = 'right';
DD3Label.FontColor = [1 1 1];
DD3Label.Position = [44 53 75 22];
DD3Label.Text = IM(3,1);

% Create DD3
DD3 = uidropdown(ManualProjectAllocationPanel);
DD3.Items = IM(:,2);
DD3.FontColor = [1 1 1];
DD3.BackgroundColor = [0.0588 0.149 0.149];
DD3.Position = [150 53 100 22];
% Create Button
Button = uibutton(UIFigure, 'push');
Button.ButtonPushedFcn = @(Button,event) ButtonPushed(DD1,DD2,DD3,UIFigure);
Button.Position = [299 293 100 22];

function ButtonPushed(DD1,DD2,DD3,UIFigure)
% global IM;
decisions = {
        DD1.Value,
        DD2.Value,
        DD3.Value
        };    
assignin('base','Decisions_gui',decisions);
closereq
end
uiwait(UIFigure) % execution waits until figure is closed
end