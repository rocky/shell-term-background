#!/bin/bash
PYTHON_VERSION=3.0

python_termbackground_owd=$(pwd)
bs=${BASH_SOURCE[0]}
if [[ $0 == $bs ]] ; then
    echo "This script should be *sourced* rather than run directly through bash"
    exit 1
fi

mydir=$(dirname $bs)
fulldir=$(readlink -f $mydir)
cd $fulldir/..

cd $python_termbackground_owd
git checkout python-3.0-to-3.2
rm -v */.python-version 2>/dev/null || true
