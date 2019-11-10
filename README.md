These shell scripts, one for `bash`, one for `zsh`, and one for `ksh` try to determine if your terminal has dark or light background.

If you source this from a shell session it will set and export `COLORFGBG` to '0;15' for dark backgrounds and '15;0' for light backgrounds which is
a convention used by some programs. Since I find this a little arcane, the program also sets and exports `DARK_BG` to 1 for dark backgrounds and 0 for light.

If are not in a shell then runnning the program and parse the output; output will start either "Dark background", "Light background" or "Can't decide".

The heuristics it uses is to try to query the background color using an [xterm control sequence](https://www.talisman.org/~erlkonig/documents/xterm-color-queries/).

Many, but not all, terminals support this query. So as a fallback we query environment variable `COLORFGBG` and failing this we use some
defaults for some known terminals set from the `TERM` environment variable.

There is one other envirnoment variable and aspect worth mentioning. When we can get pixel intensities of red, blue, and green
values of the background, we can use that determine light and dark based the combined sum: zero values indicate an absense of a particular
color. However the upper value can change. On a `xterm-256color` or derivative of that, the highest intensity is `0xff` while on an
`xterm` or a deriviative of that (which is also not a derivative of `xterm-256color`) the highest intensity is `0xffff`.  The environment variable
`TERMINAL_COLOR_MIDPOINT` has what we think is the midpoint (grey) color value. For `xterm-256color` it is 383, while for `xterm` it is 117963.

You can set any of these environment variables to influence the output decision.

Many thanks to Thomas Dickey, Egmont Koblinger, and Gilles, for
explanations (and code!) via
[unix.stackexchange](http://unix.stackexchange.com/questions/245378/common-environment-variable-to-set-dark-or-light-terminal-background/245381#245381). Of
course bugs and lacuna in this code are mine.
