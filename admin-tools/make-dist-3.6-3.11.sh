#!/bin/bash
PACKAGE=term-background
PYMODULE_NAME=term_background

# FIXME put some of the below in a common routine
function finish {
  cd $shell_term_background_owd
}

cd $(dirname ${BASH_SOURCE[0]})
shell_term_background_owd=$(pwd)
trap finish EXIT

if ! source ./pyenv-3.6-3.11-versions ; then
    exit $?
fi
if ! source ./setup-python-3.6.sh ; then
    exit $?
fi

cd ..
source $PYMODULE_NAME/version.py
if [[ ! -n $__version__ ]]; then
    echo "You need to set __version__ first"
    exit 1
fi
echo $__version__

for pyversion in $PYVERSIONS; do
    echo --- $pyversion ---
    if [[ ${pyversion:0:4} == "pypy" ]] ; then
	echo "$pyversion - PyPy does not get special packaging"
	continue
    fi
    if ! pyenv local $pyversion ; then
	exit $?
    fi
    # pip bdist_egg create too-general wheels. So
    # we narrow that by moving the generated wheel.

    # Pick out first two numbers of version, e.g. 3.5.1 -> 35
    first_two=$(echo $pyversion | cut -d'.' -f 1-2 | sed -e 's/\.//')
    rm -fr build
    python setup.py bdist_egg bdist_wheel
    if [[ $first_two =~ py* ]]; then
	if [[ $first_two =~ pypy* ]]; then
	    # For PyPy, remove the what is after the dash, e.g. pypy37-none-any.whl instead of pypy37-7-none-any.whl
	    first_two=${first_two%-*}
	fi
	mv -v dist/${PYMODULE_NAME}-$__version__-{py3,$first_two}-none-any.whl
    else
	mv -v dist/${PYMODULE_NAME}-$__version__-{py3,py$first_two}-none-any.whl
    fi
    echo === $pyversion ===
done

python ./setup.py sdist

tarball=dist/${PYMODULE_NAME}-${__version__}.tar.gz
if [[ -f $tarball ]]; then
    mv -v $tarball dist/${PYMODULE_NAME}_36-${__version__}.tar.gz
fi
finish
