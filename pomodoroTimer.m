function pomodoroTimer(options)
% POMODOROTIMER pomodoroTimer(options) manages your working time
%
%% ARGUMENTS
% options: 
% - WorkTime (25) : Minutes of a work time.
% - ShortBreakTime (5) : Minutes of a short break.
% - LongBreakTime (15) : Minutes of a long break.
% - NumberOfShortBreak (4) : Number of short breaks taken before a long break.
%
%% EXAMPLES
% One line examples:
%   >> % without arguments
%   >> pomodoroTimer
%   >> % with arguments
%   >> pomodoroTimer("WorkTime", 52, "ShortBreakTime", 17)
%
%% WEBSITE
% GitHub : https://github.com/kimushun1101/pomodoro-timer

arguments
    options.WorkTime (1,1) {mustBePositive} = 25;
    options.ShortBreakTime (1,1) {mustBePositive} = 5;
    options.LongBreakTime (1,1) {mustBePositive} = 15;
    options.NumberOfShortBreak (1,1) {mustBePositive} = 4;
end

%% Status Definition
working.name = "Working";
working.duration = duration(string(options.WorkTime) + ":00", "InputFormat", "mm:ss");
working.color = "green";
working.sound = load("gong");

shortbreak.name = "Short break";
shortbreak.duration = duration(string(options.ShortBreakTime) + ":00", "InputFormat", "mm:ss");
shortbreak.color = "cyan";
shortbreak.sound = load("chirp");

longbreak.name = "Long break";
longbreak.duration = duration(string(options.LongBreakTime) + ":00", "InputFormat", "mm:ss");
longbreak.color = "blue";
longbreak.sound = load("handel");

CountBreak = 0;

% % For debug
% options.NumberOfShortBreak = 2;
% working.duration = duration("00:05", "InputFormat", "mm:ss");
% shortbreak.duration = duration("00:03", "InputFormat", "mm:ss");
% longbreak.duration = duration("00:10", "InputFormat", "mm:ss");

%% Handles setting
t = timer("ExecutionMode", "fixedRate", "TimerFcn", @updateTimer);
fig = uifigure("CloseRequestFcn", @closeRequest);
lbl = uilabel(fig, "HorizontalAlignment", "center");

%% Start operation
baseTime = datetime("now"); % Get a base time as the current time
currentStatus = longbreak;  % Initial status is "Long break"
switchStatus();             % Switch status into "Working"
start(t);

    % Timer Callback: Update time display
    function updateTimer(~,~)
        remainingTime = currentStatus.duration - (datetime("now") - baseTime);
        if remainingTime > duration("00:00", "InputFormat", "mm:ss")
            lbl.Text = string(remainingTime, "mm:ss");
        else
            switchStatus()
        end
        % Adjust the size of the text to the size of the figure.
        figWidth = fig.Position(3);
        figHeight = fig.Position(4);
        lbl.FontSize = min([figWidth*0.3, figHeight*0.7]); % Fit to "000:00"
        lbl.Position = [0 0 figWidth figHeight]; % Accommodate the new font size.
    end

    % Switch Status: Update visual and execute action
    function switchStatus()
        if currentStatus.name == "Working"
            if CountBreak < options.NumberOfShortBreak
                currentStatus = shortbreak;
                CountBreak = CountBreak + 1;
            else
                currentStatus = longbreak;
                CountBreak = 0;
            end
        else
            currentStatus = working;
        end
        % Update status display
        fig.Name = currentStatus.name;
        fig.Color = currentStatus.color;
        lbl.Text = string(currentStatus.duration, "mm:ss");
        focus(fig); % Bring the fig to the foreground 
        % Sound an alert
        sound(currentStatus.sound.y, currentStatus.sound.Fs);
        % Update base time
        baseTime = datetime("now");
    end

    % Callback when closing the Figure: Stop timer and then close it.
    function closeRequest(~,~)
        stop(t);
        delete(fig);
    end
end
