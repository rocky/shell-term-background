This bash shell script tries to determine if your terminal has dark or light background.

If you source this from a shell session it will set and export COLORFGBG to
'0;15' for dark backgrounds and '15;0' for light backgrounds which is
a convention used by some programs. Since I find this a little arcane,
the program also sets and exports `DARK_BG` to 1 for dark backgrounds and 0 for light.

If are not in a shell then runnning the program and parse the output;
output will start either "Dark background", "Light background" or
"Can't decide".

THe heuristics it uses is to try to query the background color using
an [xterm control sequence](https://www.talisman.org/~erlkonig/documents/xterm-color-queries/)

Many, but not all, terminal support this query. So as a fallback we
query environment variable `COLORFGBG` and failing this we use some
defaults for some known terminals.

Many thanks to Thomas Dickey, Egmont Koblinger, and Gilles, for
explanations (and code!) via
[unix.stackexchange](ttp://unix.stackexchange.com/questions/245378/common-environment-variable-to-set-dark-or-light-terminal-background/245381#245381). Of
course bugs, lacuna, in this code are mine.
