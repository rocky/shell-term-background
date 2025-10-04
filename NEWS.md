1.0.5
-----

Oct 4, 2025

* Incorporate CLI_THEME and contour terminal
* Fix COLORFGBG sense in Python script on one place

1.0.4
-----

Sept 18, 2025

Remove form hex number conversions. Assum osascript and others now work in decimal not hex.
If this is wrong, we'll have to adjust in the future.

Thanks to Bruce Lucas for reporting and testing on MacOS with zsh.

Start POSIX shell testing using `shunit`.

1.0.3
-----

Sept 1, 2025

Adjust MacOS terminal detection, especially in `zsh` and `ksh`.

Report on `NO_COLOR` presence in main Python program.

Support up to Python 3.13 (which needs new pyproject.toml packaging).

1.0.2
-----

Split out Python code into git branches to support older Python.
Master now can use newer Python idioms like f-strings, and
newer packaging uses pyproject.toml


1.0.1
-----

Administrivia - Python being its usual quirky self.

1.0.0
-----

Release the Python portion as a package.

Some bugs in the Python code were fixed, and a test was added.
