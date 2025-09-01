"""
Figure out if the terminal has a light or dark background.

We consult environment variables:
- LC_DARK_BG
- COLORFGBG
- TERM

If LC_DARK_BG is set and it isn't 0 then we have a dark background
else a light background.

If LC_DARK_BG is not set but COLORFGBG is set and it is '0;15' then we have a dark background
and if it is '15;0' then a light background.

If none of the above work but TERM is set and the terminal understands
xterm sequences for retrieving foreground and background, we'll
set based on those colors. Failing that we'll set defaults
for spefic TERM values based on their default settings.


See https://github.com/rocky/shell-term-background for code
that works in POSIX shell.
"""

from os import environ
import sys

# from subprocess import check_output, check_call


def set_default_bg():
    """Get background from
    default values based on the TERM environment variable
    """
    term = environ.get("TERM", None)
    if term:
        if term.startswith("xterm") or term.startswith("eterm") or term == "dtterm":
            return False
    return True


def is_dark_rgb(r, g, b):
    """Pass as parameters R G B values in hex
    On return, variable is_dark_bg is set
    """

    def scale(v):
        return v * 16

    try:
        midpoint = int(environ.get("TERMINAL_COLOR_MIDPOINT", None))
    except Exception:
        midpoint = None
        pass
    if not midpoint:
        term = environ.get("TERM", None)
        # 16-bit values:
        #   117963 = (* .6 (+ 65535 65535 65535))
        # 8-bit values:
        #   382.5 = (* .5 (+ 255 255 255))
        if term and term == "xterm-256color":
            midpoint = 117963
        else:
            midpoint = 383

    # Each r,g or b are is scalledmulitplied by 16, e.g.
    # 0..15 -> 0..240
    if (scale(r) + scale(g) + scale(b)) < midpoint:
        return True
    else:
        return False


DARK_COLORFGBG_VALUES = ("0;15", "0;default;15")
LIGHT_COLORFGBG_VALUES = ("15;0", "15;default;0")


def is_dark_color_fg_bg():
    """Consult (environment) variables LC_DARK_BG and COLORFGB
    On return, variable is_dark_bg is set"""
    dark_bg = environ.get("LC_DARK_BG", None)
    if dark_bg is not None:
        return dark_bg != "0"
    color_fg_bg = environ.get("COLORFGBG", None)
    if color_fg_bg:
        if color_fg_bg in LIGHT_COLORFGBG_VALUES:
            return True
        elif color_fg_bg in DARK_COLORFGBG_VALUES:
            return False
    else:
        return True
    return None


# # From:
# # http://unix.stackexchange.com/questions/245378/common-environment-variable-to-set-dark-or-light-terminal-background/245381#245381
# # and:
# # https://bugzilla.gnome.org/show_bug.cgi?id=733423#c1
# #
# # User should set up RGB_fg and RGB_bg arrays
# def xterm_compatible_fg_bg():
#     # Issue command to get both foreground and
#     # background color
#     #                                           fg        bg
#     try:
#         check_call("stty -echo", shell=True)
#         output = check_output("echo -ne '\033]10;?\07\033]11;?07'", shell=True)
#     finally:
#         check_call("stty echo", shell=True)


#     # IFS=: read -t 0.1 -d $'\a' x fg
#     # IFS=: read -t 0.1 -d $'\a' x bg
#     #     output = check_output("stty echo")
#     # stty echo
#     # [[ -z $bg ]] && return 1
#     # typeset -p fg
#     # typeset -p bg
#     # IFS='/' read -ra RGB_fg <<< $fg
#     # IFS='/' read -ra RGB_bg <<< $bg
#     # typeset -p RGB_fg
#     # typeset -p RGB_bg
#     return None, None, None

# FIXME: go over and add
# From a comment left duthen in my StackOverflow answer cited above.
# def osx_get_terminal_fg_bg():
#     color_fg_bg = environ.get('COLORFGBG', None)
#     if color_fg_bg:
# 	method="COLORFGBG"
# 	dark_bg = is_dark_colorfgbg()
#     else:
# 	RGB_bg=($(osascript -e 'tell application "Terminal" to get the background color of the current settings of the selected tab of front window'))
# 	# typeset -p RGB_bg
# 	if ($? != 0):
#             return None
# 	TERMINAL_COLOR_MIDPOINT = 117963
# 	dark_bg = is_dark_rgb ${RGB_bg[@]}
# 	method="OSX osascript"
# 	success=1
#     return dark_bg


def is_dark_background():
    dark_bg = is_dark_color_fg_bg()
    if dark_bg is None:
        dark_bg = set_default_bg()
    # print("XXX ", dark_bg)
    return dark_bg


def main():
    """Show setting for terminal darkness evironment variables
      LC_DARK_BG and COLORFGBG, and check for consistency between the
      settings of these variables.
    """
    lc_dark_bg = environ.get("LC_DARK_BG")
    if lc_dark_bg == "0":
        lc_dark_bg_status = "light"
    elif lc_dark_bg is None:
        lc_dark_bg_status = "variable not set"
    else:
        lc_dark_bg_status = "dark"
    print("LC_DARK_BG: %s (%s)" % (lc_dark_bg, lc_dark_bg_status))

    color_fg_bg = environ.get("COLORFGBG")
    if color_fg_bg in LIGHT_COLORFGBG_VALUES:
        color_fg_bg_status = "light"
    elif color_fg_bg in DARK_COLORFGBG_VALUES:
        color_fg_bg_status = "dark"
    elif color_fg_bg is None:
        color_fg_bg_status = "variable not set"
    else:
        color_fg_bg_status = "?? %s % color_fg_bg"
    print("COLORFGBG: %s (%s)" % (color_fg_bg, color_fg_bg_status))

    # Check consistency
    if lc_dark_bg_status != color_fg_bg_status and not (
        lc_dark_bg_status == "variable not set"
        or color_fg_bg_status == "variable not set"
    ):
        print("Mismatched LC_DARK_BG and COLORFGBG; LC_DARK_BG takes precedence")
        sys.exit(1)
    else:
        print("LC_DARK_BG and COLORFGBG are compatible")
        no_color = environ.get("NO_COLOR", False)
        if no_color:
            print("NO_COLOR is set to %s. This may take precedence and colors turned off." % no_color)
        else:
            print("NO_COLOR is not set.")

    sys.exit(0)


if __name__ == "__main__":
    main()
