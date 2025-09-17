#!/usr/bin/ksh
# -*- shell-script -*-

PS4='(${.sh.file}:${LINENO}): ${.sh.fun} - [${.sh.subshell}]'
mydir=$(dirname ${.sh.file})
fulldir=$(readlink -f $mydir)
cd $fulldir/..

if ! source ./term-background.ksh ; then
    exit $?
fi

test_osascript_handling()
{

    typeset -a RGB_bg=(65535, 65535, 65535)
    is_dark_rgb_from_bg "${RGB_bg[@]}"
    assertEquals 0 $is_dark_bg

    typeset -a RGB_bg=(0, 0, 0)
    is_dark_rgb_from_bg "${RGB_bg[@]}"
    assertEquals 1 $is_dark_bg
}

cd $fulldir
SHUNIT_PARENT=$0
. ./shunit2
