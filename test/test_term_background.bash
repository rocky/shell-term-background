#!/usr/bin/bash
# -*- shell-script -*-

cd $(dirname ${BASH_SOURCE[0]})
if ! source ../term-background.bash ; then
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

[[ $0 == ${BASH_SOURCE} ]] && . ./shunit2
