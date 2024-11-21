function pomodoroTimer(Cycles, options)
% POMODOROTIMER pomodoroTimer(options) manages your work time.
%
%% ARGUMENTS
% - Cycles (4) : Number of work times taken before a long break
% - options: 
%     - WorkTime (25) : Minutes of a work time
%     - ShortBreakTime (5) : Minutes of a short break
%     - LongBreakTime (30) : Minutes of a long break
%
%% EXAMPLES
% One line examples:
%   >> % without arguments
%   >> pomodoroTimer
%   >> % with Cycle argument
%   >> pomodoroTimer(3)
%   >> % with options arguments
%   >> pomodoroTimer("WorkTime", 52, "ShortBreakTime", 17)
%   >> % Argument Combination
%   >> pomodoroTimer(3, "WorkTime", 52, "ShortBreakTime", 17)
%
%% WEBSITE
% GitHub : https://github.com/kimushun1101/pomodoro-timer

arguments
    Cycles (1,1) {mustBePositive, mustBeInteger} = 4;
    options.WorkTime (1,1) {mustBePositive, mustBeInteger} = 25;
    options.ShortBreakTime (1,1) {mustBePositive, mustBeInteger} = 5;
    options.LongBreakTime (1,1) {mustBePositive, mustBeInteger} = 30;
end

%% Status Definition
work.name = "Work";
work.duration = duration(string(options.WorkTime) + ":00", "InputFormat", "mm:ss");
work.color = "green";
work.sound = load("gong");

shortbreak.name = "Short break";
shortbreak.duration = duration(string(options.ShortBreakTime) + ":00", "InputFormat", "mm:ss");
shortbreak.color = "cyan";
shortbreak.sound = load("chirp");

longbreak.name = "Long break";
longbreak.duration = duration(string(options.LongBreakTime) + ":00", "InputFormat", "mm:ss");
longbreak.color = "blue";
longbreak.sound = load("handel");

% % For debug
% Cycles = 2;
% work.duration = duration("00:05", "InputFormat", "mm:ss");
% shortbreak.duration = duration("00:03", "InputFormat", "mm:ss");
% longbreak.duration = duration("00:10", "InputFormat", "mm:ss");

%% Handles setting
t = timer("ExecutionMode", "fixedRate", "TimerFcn", @updateTimer);
fig = uifigure("CloseRequestFcn", @closeRequest);
lbl = uilabel(fig, "HorizontalAlignment", "center");

%% Start operation
baseTime = datetime("now"); % Get a base time as the current time
currentStatus = longbreak;  % Initial status is "Long break"
currentCycle = Cycles;
switchStatus();             % Switch status to first "Work"
start(t);

    % Timer Callback: Update time display
    function updateTimer(~,~)
        remainingTime = currentStatus.duration - (datetime("now") - baseTime);
        if remainingTime > duration("00:00", "InputFormat", "mm:ss")
            lbl.Text = string(remainingTime, "mm:ss");
        else
            switchStatus()
        end
        % Adjust the size of the text to the size of the figure
        figWidth = fig.Position(3);
        figHeight = fig.Position(4);
        lbl.FontSize = min([figWidth*0.3, figHeight*0.7]); % Fit to "000:00"
        lbl.Position = [0 0 figWidth figHeight]; % Accommodate the new font size
    end

    % Switch Status: Update visual and execute action
    function switchStatus()
        if currentStatus.name == "Work"
            if currentCycle < Cycles
                currentStatus = shortbreak;
            else
                currentStatus = longbreak;
            end
        elseif currentStatus.name == "Short break"
            currentStatus = work;
            currentCycle = currentCycle + 1;
        elseif currentStatus.name == "Long break"
            currentStatus = work;
            currentCycle = 1;
        end
        % Update status display
        fig.Name = currentStatus.name + " : " + num2str(currentCycle) + "/" + num2str(Cycles);
        fig.Color = currentStatus.color;
        lbl.Text = string(currentStatus.duration, "mm:ss");
        focus(fig); % Bring the fig to the foreground
        % Sound an alert
        sound(currentStatus.sound.y, currentStatus.sound.Fs);
        % Update base time
        baseTime = datetime("now");
    end

    % Callback when closing the Figure: Stop timer and then close it
    function closeRequest(~,~)
        stop(t);
        delete(fig);
    end
end
