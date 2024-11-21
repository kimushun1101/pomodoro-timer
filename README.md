[![View pomodoro-timer on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://jp.mathworks.com/matlabcentral/fileexchange/176183-pomodoro-timer)

# pomodoro-timer
Pomodoro Timer running on MATLAB.

The Pomodoro Technique is a time management method.
Users set the number of cycles, and each cycle consists of a 25 minutes work followed by a 5 minutes short break.
In the last cycle, instead of a short break, take a 30 minutes longer break.

This timer displays the current status and the time remaining.
A sound notification alerts the user when the timer switches each status.

![pomodoro-timer](https://github.com/user-attachments/assets/571f4d8d-efc2-4056-895e-bb81c102cbc5)

## Install
Open [Add-On Explorer](https://jp.mathworks.com/help/matlab/matlab_env/get-add-ons.html) on your MATLAB and Search `pomodoro-timer`, then `Add` -> `Add to MATLAB`.

## Usage
Execution can be performed without arguments.
The command is only `>> pomodoroTimer`.

The default number of cycles is `4`.
To change it, simply give the desired number as an argument.
```
pomodoroTimer(3)
```

### Option arguments
It can be executed with the following options (default values in parentheses).

- `WorkTime` (25) : Minutes of a work time.
- `ShortBreakTime` (5) : Minutes of a short break.
- `LongBreakTime` (15) : Minutes of a long break.

For example:
```
pomodoroTimer(3, "WorkTime", 52, "ShortBreakTime", 17, "LongBreakTime", 60)
```

## Uninstall
Execute the following command.
```
matlab.addons.uninstall("pomodoro-timer")
```

## License
The MIT License
