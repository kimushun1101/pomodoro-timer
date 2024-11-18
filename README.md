[![View pomodoro-timer on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://jp.mathworks.com/matlabcentral/fileexchange/)

# pomodoro-timer
Pomodoro Timer running on MATLAB.

## Installation
Open [Add-On Explorer](https://jp.mathworks.com/help/matlab/matlab_env/get-add-ons.html) on your MATLAB and Search `pomodoro timer`, then `Add` -> `Add to MATLAB`.

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

## License
The MIT License
