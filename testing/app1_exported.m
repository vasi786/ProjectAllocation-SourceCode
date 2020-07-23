classdef app1_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                  matlab.ui.Figure
        ProjectInfoDropDownLabel  matlab.ui.control.Label
        ProjectInfoDropDown       matlab.ui.control.DropDown
        LoadDataButton            matlab.ui.control.Button
        StudentInfoDropDownLabel  matlab.ui.control.Label
        StudentInfoDropDown       matlab.ui.control.DropDown
        RecommendationsLabel      matlab.ui.control.Label
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: LoadDataButton
        function LoadDataButtonPushed(app, event)
                 v = evalin("base");
              roll_nos = xlsread("name_CGPA_2.xlsx");
            app.ProjectInfoDropDown.Items = string(roll_nos(:,1));
            app.ProjectInfoDropDown.Items = original_proj_list;
             
            
            
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

            % Create ProjectInfoDropDownLabel
            app.ProjectInfoDropDownLabel = uilabel(app.UIFigure);
            app.ProjectInfoDropDownLabel.HorizontalAlignment = 'right';
            app.ProjectInfoDropDownLabel.Position = [381 319 66 22];
            app.ProjectInfoDropDownLabel.Text = 'Project Info';

            % Create ProjectInfoDropDown
            app.ProjectInfoDropDown = uidropdown(app.UIFigure);
            app.ProjectInfoDropDown.Items = {'project name '};
            app.ProjectInfoDropDown.Position = [462 319 100 22];
            app.ProjectInfoDropDown.Value = 'project name ';

            % Create LoadDataButton
            app.LoadDataButton = uibutton(app.UIFigure, 'push');
            app.LoadDataButton.ButtonPushedFcn = createCallbackFcn(app, @LoadDataButtonPushed, true);
            app.LoadDataButton.Position = [481 401 120 40];
            app.LoadDataButton.Text = 'Load Data';

            % Create StudentInfoDropDownLabel
            app.StudentInfoDropDownLabel = uilabel(app.UIFigure);
            app.StudentInfoDropDownLabel.HorizontalAlignment = 'right';
            app.StudentInfoDropDownLabel.Position = [97 319 70 22];
            app.StudentInfoDropDownLabel.Text = 'Student Info';

            % Create StudentInfoDropDown
            app.StudentInfoDropDown = uidropdown(app.UIFigure);
            app.StudentInfoDropDown.Items = {'Roll Number'};
            app.StudentInfoDropDown.Position = [182 319 100 22];
            app.StudentInfoDropDown.Value = 'Roll Number';

            % Create RecommendationsLabel
            app.RecommendationsLabel = uilabel(app.UIFigure);
            app.RecommendationsLabel.FontSize = 25;
            app.RecommendationsLabel.Position = [221 430 215 31];
            app.RecommendationsLabel.Text = 'Recommendations';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app1_exported

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