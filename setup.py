#!/usr/bin/env python
"""
  Check that the Python version running this is compatible with this installation medium.
"""

import sys
from setuptools import find_packages, setup
from __pkginfo__ import (
    __version__,
    author,
    author_email,
    classifiers,
    long_description,
    py_modules,
    short_desc,
    url,
)

major = sys.version_info[0]
minor = sys.version_info[1]

if (major, minor) >= (3, 11):
    sys.stderr.write("Please install from PyPIn")
    sys.exit(1)
if major == 3 and 6 <= minor <= 10:
    sys.stderr.write("Please install using term_background_36-x.y.z.tar.gz from https://github.com/rocky/shell-term-background/releases\n")
    sys.exit(1)
elif major == 3 and 3 <= minor <= 5:
    sys.stderr.write("Please install using term_background_33-x.y.z.tar.gz from https://github.com/rocky/shell-term-background/releases\n")
    sys.exit(1)
if major == 3 and 0 <= minor <= 2:
    sys.stderr.write("Please install using term_background_30-x.y.z.tar.gz from https://github.com/rocky/shell-term-background/releases\n")
    sys.exit(1)

setup(
    name="term-background",
    version=__version__,
    author=author,
    author_email=author_email,
    classifiers=classifiers,
    description=short_desc,
    long_description=long_description,
    long_description_content_type="text/x-rst",
    packages=find_packages(),
    py_modules = py_modules,
    url=url
)
