#!/usr/bin/env python

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
