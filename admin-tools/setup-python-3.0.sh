#!/bin/bash
PYTHON_VERSION=3.0
pyenv local $PYTHON_VERSION

git checkout python-3.0-to-3.2 && git pull && pyenv local $PYTHON_VERSION
