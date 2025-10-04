#!/usr/bin/bash
# -*- shell-script -*-

test_term_owd=$(pwd)
bs=${BASH_SOURCE[0]}
mydir=$(dirname $bs)
fulldir=$(readlink -f $mydir)
cd $fulldir/..
if ! source ./term-background.bash ; then
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

. ./test/shunit2
