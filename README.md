[![View pomodoro-timer on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://jp.mathworks.com/matlabcentral/fileexchange/176128-pomodoro-timer)

# pomodoro-timer
Pomodoro Timer running on MATLAB.

![pomodoro-timer](https://github.com/user-attachments/assets/fe588eeb-c508-492a-9543-27fda1f4de9d)


## Install
Open [Add-On Explorer](https://jp.mathworks.com/help/matlab/matlab_env/get-add-ons.html) on your MATLAB and Search `pomodoro-timer`, then `Add` -> `Add to MATLAB`.

## Usage
Execution can be performed without arguments.
The command is only `>> pomodoroTimer`.


### Option arguments
It can be executed with the following options (default values in parentheses).

- `WorkTime` (25) : Minutes of a work time.
- `ShortBreakTime` (5) : Minutes of a short break.
- `LongBreakTime` (15) : Minutes of a long break.
- `NumberOfShortBreak` (4) : Number of short breaks taken before a long break.

For example:
```
pomodoroTimer("WorkTime", 52, "ShortBreakTime", 17, "LongBreakTime", 60, "NumberOfShortBreak", 3)
```

## Uninstall

Execute the following command in your MATLAB command window.
```
matlab.addons.uninstall("pomodoro-timer")
```

## License
The MIT License
