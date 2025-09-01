#!/usr/bin/zsh
# -*- shell-script -*-

PS4='(%x:%I): [%?] zsh+'
cd $(dirname ${0:A})

if ! source ../term-background.zsh ; then
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

SHUNIT_PARENT=$0
. ./shunit2
