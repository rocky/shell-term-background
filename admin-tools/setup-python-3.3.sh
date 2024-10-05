#!/bin/bash
PYTHON_VERSION=3.3
pyenv local $PYTHON_VERSION

git checkout python-3.3-to-3.5 && git pull && pyenv local $PYTHON_VERSION
