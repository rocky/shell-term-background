#!/bin/bash
PYTHON_VERSION=3.6
pyenv local $PYTHON_VERSION

git checkout python-3.6-to-3.11 && git pull && pyenv local $PYTHON_VERSION
