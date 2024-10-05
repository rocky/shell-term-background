#!/bin/bash
PYTHON_VERSION=3.0
pyenv local $PYTHON_VERSION

git checkout python-2.4-to-2.7 && git pull && pyenv local $PYTHON_VERSION
