These scripts, one for `bash`, one for `zsh`, one for `ksh`, and a Python module try to determine if your terminal has dark or light background.

For the shell scripts, if you source this from a shell session it will set and export `COLORFGBG` to '0;15' for dark backgrounds and '15;0' for light backgrounds which is
a convention used by some programs. Since I find this a little arcane, the program also sets and exports `DARK_BG` to 1 for dark backgrounds and 0 for light.

If are not in a shell then runnning the program and parse the output; output will start either "Dark background", "Light background" or "Can't decide".

The heuristics it uses is to try to query the background color using an [xterm control sequence](https://www.talisman.org/~erlkonig/documents/xterm-color-queries/).

Many, but not all, terminals support this query. So as a fallback we query environment variable `COLORFGBG` and failing this we use some
defaults for some known terminals set from the `TERM` environment variable.

When we can get pixel intensities of red, blue, and green values of the background, we can use that determine light and dark based the combined sum: zero values indicate an absense of a particular color and compare that with the values of the foreground.

You can set any of these environment variables to influence the output decision.

Many thanks to Thomas Dickey, Egmont Koblinger, and Gilles, for
explanations (and code!) via
[unix.stackexchange](http://unix.stackexchange.com/questions/245378/common-environment-variable-to-set-dark-or-light-terminal-background/245381#245381). John Green had the idea to compare the foreground and background colors instead comparing the background against the midway gray color and implemented that change here.

Of course bugs and lacuna in this code are mine.
