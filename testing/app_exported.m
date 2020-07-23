classdef app_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                    matlab.ui.Figure
        LoadDataButton              matlab.ui.control.Button
        RecommendationsLabel        matlab.ui.control.Label
        StudentInfoDropDownLabel    matlab.ui.control.Label
        StudentInfoDropDown         matlab.ui.control.DropDown
        ProjectInfoDropDownLabel    matlab.ui.control.Label
        ProjectInfoDropDown         matlab.ui.control.DropDown
        DoneButton                  matlab.ui.control.Button
        StudentInfoDropDown_2Label  matlab.ui.control.Label
        StudentInfoDropDown_2       matlab.ui.control.DropDown
        ProjectInfoDropDown_2Label  matlab.ui.control.Label
        ProjectInfoDropDown_2       matlab.ui.control.DropDown
        StudentInfoDropDown_3Label  matlab.ui.control.Label
        StudentInfoDropDown_3       matlab.ui.control.DropDown
        ProjectInfoDropDown_3Label  matlab.ui.control.Label
        ProjectInfoDropDown_3       matlab.ui.control.DropDown
        StudentInfoDropDown_4Label  matlab.ui.control.Label
        StudentInfoDropDown_4       matlab.ui.control.DropDown
        ProjectInfoDropDown_4Label  matlab.ui.control.Label
        ProjectInfoDropDown_4       matlab.ui.control.DropDown
        StudentInfoDropDown_5Label  matlab.ui.control.Label
        StudentInfoDropDown_5       matlab.ui.control.DropDown
        ProjectInfoDropDown_5Label  matlab.ui.control.Label
        ProjectInfoDropDown_5       matlab.ui.control.DropDown
        Image                       matlab.ui.control.Image
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: LoadDataButton
        function LoadDataButtonPushed(app, event)
             v = evalin("base",'original_proj_list');
             v = ['none';v(:,1)];
              roll_nos = xlsread("name_CGPA_2.xlsx");
              roll_nos = ['none';string(roll_nos(:,1))];
              app.StudentInfoDropDown.Items = roll_nos;
              app.ProjectInfoDropDown.Items = v(:,1);
              app.StudentInfoDropDown_2.Items = roll_nos;
              app.ProjectInfoDropDown_2.Items = v(:,1);
               app.StudentInfoDropDown_3.Items = roll_nos;
              app.ProjectInfoDropDown_3.Items = v(:,1);
               app.StudentInfoDropDown_4.Items = roll_nos;
              app.ProjectInfoDropDown_4.Items = v(:,1);
               app.StudentInfoDropDown_5.Items = roll_nos;
              app.ProjectInfoDropDown_5.Items = v(:,1);
        end

        % Button pushed function: DoneButton
        function DoneButtonPushed(app, event)
            assignin('base','roll_no_GUI1',app.StudentInfoDropDown.Value);
            assignin('base','projname_GUI1',app.ProjectInfoDropDown.Value);
            assignin('base','roll_no_GUI2',app.StudentInfoDropDown_2.Value);
            assignin('base','projname_GUI2',app.ProjectInfoDropDown_2.Value);
            assignin('base','roll_no_GUI3',app.StudentInfoDropDown_3.Value);
            assignin('base','projname_GUI3',app.ProjectInfoDropDown_3.Value);
            assignin('base','roll_no_GUI4',app.StudentInfoDropDown_4.Value);
            assignin('base','projname_GUI4',app.ProjectInfoDropDown_4.Value);
            assignin('base','roll_no_GUI5',app.StudentInfoDropDown_5.Value);
            assignin('base','projname_GUI5',app.ProjectInfoDropDown_5.Value);
              %save guioutput
            closereq
        end

        % Image clicked function: Image
        function ImageClicked(app, event)
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create LoadDataButton
            app.LoadDataButton = uibutton(app.UIFigure, 'push');
            app.LoadDataButton.ButtonPushedFcn = createCallbackFcn(app, @LoadDataButtonPushed, true);
            app.LoadDataButton.Position = [470 371 141 47];
            app.LoadDataButton.Text = 'Load Data';

            % Create RecommendationsLabel
            app.RecommendationsLabel = uilabel(app.UIFigure);
            app.RecommendationsLabel.HorizontalAlignment = 'center';
            app.RecommendationsLabel.FontSize = 24;
            app.RecommendationsLabel.Position = [226 436 207 30];
            app.RecommendationsLabel.Text = 'Recommendations';

            % Create StudentInfoDropDownLabel
            app.StudentInfoDropDownLabel = uilabel(app.UIFigure);
            app.StudentInfoDropDownLabel.HorizontalAlignment = 'right';
            app.StudentInfoDropDownLabel.Position = [91 309 70 22];
            app.StudentInfoDropDownLabel.Text = 'Student Info';

            % Create StudentInfoDropDown
            app.StudentInfoDropDown = uidropdown(app.UIFigure);
            app.StudentInfoDropDown.Items = {'Roll number'};
            app.StudentInfoDropDown.Position = [176 309 100 22];
            app.StudentInfoDropDown.Value = 'Roll number';

            % Create ProjectInfoDropDownLabel
            app.ProjectInfoDropDownLabel = uilabel(app.UIFigure);
            app.ProjectInfoDropDownLabel.HorizontalAlignment = 'right';
            app.ProjectInfoDropDownLabel.Position = [391 309 66 22];
            app.ProjectInfoDropDownLabel.Text = 'Project Info';

            % Create ProjectInfoDropDown
            app.ProjectInfoDropDown = uidropdown(app.UIFigure);
            app.ProjectInfoDropDown.Items = {'project name'};
            app.ProjectInfoDropDown.Position = [472 309 100 22];
            app.ProjectInfoDropDown.Value = 'project name';

            % Create DoneButton
            app.DoneButton = uibutton(app.UIFigure, 'push');
            app.DoneButton.ButtonPushedFcn = createCallbackFcn(app, @DoneButtonPushed, true);
            app.DoneButton.Position = [271 31 135 45];
            app.DoneButton.Text = 'Done';

            % Create StudentInfoDropDown_2Label
            app.StudentInfoDropDown_2Label = uilabel(app.UIFigure);
            app.StudentInfoDropDown_2Label.HorizontalAlignment = 'right';
            app.StudentInfoDropDown_2Label.Position = [91 264 70 22];
            app.StudentInfoDropDown_2Label.Text = 'Student Info';

            % Create StudentInfoDropDown_2
            app.StudentInfoDropDown_2 = uidropdown(app.UIFigure);
            app.StudentInfoDropDown_2.Items = {'Roll number'};
            app.StudentInfoDropDown_2.Position = [176 264 100 22];
            app.StudentInfoDropDown_2.Value = 'Roll number';

            % Create ProjectInfoDropDown_2Label
            app.ProjectInfoDropDown_2Label = uilabel(app.UIFigure);
            app.ProjectInfoDropDown_2Label.HorizontalAlignment = 'right';
            app.ProjectInfoDropDown_2Label.Position = [395 264 66 22];
            app.ProjectInfoDropDown_2Label.Text = 'Project Info';

            % Create ProjectInfoDropDown_2
            app.ProjectInfoDropDown_2 = uidropdown(app.UIFigure);
            app.ProjectInfoDropDown_2.Items = {'project name'};
            app.ProjectInfoDropDown_2.Position = [476 264 100 22];
            app.ProjectInfoDropDown_2.Value = 'project name';

            % Create StudentInfoDropDown_3Label
            app.StudentInfoDropDown_3Label = uilabel(app.UIFigure);
            app.StudentInfoDropDown_3Label.HorizontalAlignment = 'right';
            app.StudentInfoDropDown_3Label.Position = [91 219 70 22];
            app.StudentInfoDropDown_3Label.Text = 'Student Info';

            % Create StudentInfoDropDown_3
            app.StudentInfoDropDown_3 = uidropdown(app.UIFigure);
            app.StudentInfoDropDown_3.Items = {'Roll number'};
            app.StudentInfoDropDown_3.Position = [176 219 100 22];
            app.StudentInfoDropDown_3.Value = 'Roll number';

            % Create ProjectInfoDropDown_3Label
            app.ProjectInfoDropDown_3Label = uilabel(app.UIFigure);
            app.ProjectInfoDropDown_3Label.HorizontalAlignment = 'right';
            app.ProjectInfoDropDown_3Label.Position = [395 219 66 22];
            app.ProjectInfoDropDown_3Label.Text = 'Project Info';

            % Create ProjectInfoDropDown_3
            app.ProjectInfoDropDown_3 = uidropdown(app.UIFigure);
            app.ProjectInfoDropDown_3.Items = {'project name'};
            app.ProjectInfoDropDown_3.Position = [476 219 100 22];
            app.ProjectInfoDropDown_3.Value = 'project name';

            % Create StudentInfoDropDown_4Label
            app.StudentInfoDropDown_4Label = uilabel(app.UIFigure);
            app.StudentInfoDropDown_4Label.HorizontalAlignment = 'right';
            app.StudentInfoDropDown_4Label.Position = [91 174 70 22];
            app.StudentInfoDropDown_4Label.Text = 'Student Info';

            % Create StudentInfoDropDown_4
            app.StudentInfoDropDown_4 = uidropdown(app.UIFigure);
            app.StudentInfoDropDown_4.Items = {'Roll number'};
            app.StudentInfoDropDown_4.Position = [176 174 100 22];
            app.StudentInfoDropDown_4.Value = 'Roll number';

            % Create ProjectInfoDropDown_4Label
            app.ProjectInfoDropDown_4Label = uilabel(app.UIFigure);
            app.ProjectInfoDropDown_4Label.HorizontalAlignment = 'right';
            app.ProjectInfoDropDown_4Label.Position = [395 174 66 22];
            app.ProjectInfoDropDown_4Label.Text = 'Project Info';

            % Create ProjectInfoDropDown_4
            app.ProjectInfoDropDown_4 = uidropdown(app.UIFigure);
            app.ProjectInfoDropDown_4.Items = {'project name'};
            app.ProjectInfoDropDown_4.Position = [476 174 100 22];
            app.ProjectInfoDropDown_4.Value = 'project name';

            % Create StudentInfoDropDown_5Label
            app.StudentInfoDropDown_5Label = uilabel(app.UIFigure);
            app.StudentInfoDropDown_5Label.HorizontalAlignment = 'right';
            app.StudentInfoDropDown_5Label.Position = [91 129 70 22];
            app.StudentInfoDropDown_5Label.Text = 'Student Info';

            % Create StudentInfoDropDown_5
            app.StudentInfoDropDown_5 = uidropdown(app.UIFigure);
            app.StudentInfoDropDown_5.Items = {'Roll number'};
            app.StudentInfoDropDown_5.Position = [176 129 100 22];
            app.StudentInfoDropDown_5.Value = 'Roll number';

            % Create ProjectInfoDropDown_5Label
            app.ProjectInfoDropDown_5Label = uilabel(app.UIFigure);
            app.ProjectInfoDropDown_5Label.HorizontalAlignment = 'right';
            app.ProjectInfoDropDown_5Label.Position = [395 129 66 22];
            app.ProjectInfoDropDown_5Label.Text = 'Project Info';

            % Create ProjectInfoDropDown_5
            app.ProjectInfoDropDown_5 = uidropdown(app.UIFigure);
            app.ProjectInfoDropDown_5.Items = {'project name'};
            app.ProjectInfoDropDown_5.Position = [476 129 100 22];
            app.ProjectInfoDropDown_5.Value = 'project name';

            % Create Image
            app.Image = uiimage(app.UIFigure);
            app.Image.ImageClickedFcn = createCallbackFcn(app, @ImageClicked, true);
            app.Image.Position = [31 351 100 100];
            app.Image.ImageSource = 'iitg.png';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end