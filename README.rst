|Pypi Installs| |Supported Python Versions|

The Python module contained is part of a broader set of scripts.

For the shell scripts, if you source this from a shell session, it will set and export ``COLORFGBG`` to ``0;15`` for dark backgrounds and ``15;0`` for light backgrounds, which is
a convention used by some programs. Since I find this a little arcane, the program also sets and exports ``LC_DARK_BG`` to 1 for dark backgrounds and 0 for light. The ``LC_`` (locale) assists in some SSH configurations, which often will let environment variables with that prefix get passed along and set to a remote SSH session.

From Python, you can call ``term_background.is_dark_background()`` which returns a ``True`` if we think the background is dark.

To see if your environment variables are color consistent, run:

.. code::

    $ python -m term_background


The heuristics used are to try to query the background color using an `xterm control sequence <https://www.talisman.org/~erlkonig/documents/xterm-color-queries/>`_.

Many, but not all, terminals support this query. So as a fallback, we query the environment variable ``COLORFGBG``, and failing this, we use some defaults for some known terminals set from the ``TERM`` environment variable. MacOS has its way of querying characteristics, so we use that too if you are running on that OS.

If either `NO_COLOR <https://no-color.org/>`_ or `CLI_THEME <https://wiki.tau.garden/cli-theme/>`_ are set, this is noted.

When we can get pixel intensities of red, blue, and green values of the background, we can use that to determine light and dark based on the combined sum: zero values indicate an absence of a particular color, and we can compare that with the values of the foreground.

You can set any of these environment variables to influence the output decision.

Many thanks to Thomas Dickey, Egmont Koblinger, and Gilles, for explanations (and code!) via `unix.stackexchange <http://unix.stackexchange.com/questions/245378/common-environment-variable-to-set-dark-or-light-terminal-background/245381#245381>`_. John Green had the idea to compare the foreground and background colors instead of comparing the background against the midway gray color and implemented that change here.

Of course, the bugs and lacunae in this code are mine.

Installation
------------

*If you are using Python 3.11 or later*, you can install from PyPI using the name ``term_background``::

    pip install term_background

*For Python releases before 3.11*, do not install using PyPI, but instead install using a file in the `GitHub Releases section <https://github.com/rocky/python-term_background/releases>`_. Older Python used to use `easy_install <https://python101.pythonlibrary.org/chapter29_pip.html#using-easy-install>`_. But this is no longer supported in PyPi or newer Python versions. And vice versa, *poetry* nor *pip*, (the newer ways) are not supported on older Pythons.

If the Python version you are running term_background is between Python 2.4 through 2.7, use a tarball called term_background_24-*x.y.z*.tar.gz.

If the Python version you are running term_background is between Python 3.0 through 3.2, use a tarball called term_background_30-*x.y.z*.tar.gz.

If the Python version you are running term_background is between Python 3.3 through 3.5, use a tarball called term_background_33-*x.y.z*.tar.gz.

If the Python version you are running term_background is between Python 3.6 through 3.11, use a tarball called term_background_36-*x.y.z*.tar.gz.

If the Python version you are running term_background is 3.11 or later, use a file called term_background-*x.y.z*.tar.gz.

You can also try eggs or wheels that have the same version designation, e.g., term_background-*x.y.z*-py39-none-any.whl for a Python 3.9 installation. *However, note that the version without the designation means Python 3.11 or greater*.

Similarly, a tarball with or without the underscore *xx*,  e.g., term_background_36-*x.y.z*.tar.gz. works only from Python 3.11 or greater.

Rationale for using Git Branches
++++++++++++++++++++++++++++++++

It is currently impossible (if not impractical) to have one Python source code of this complexity and with this many features that can run both Python 2.7 and Python 3.13+. The languages have drifted so much, and packaging is vastly different. In fact, the packaging practice for Python 3.11+ is incompatible with Python 2.7 (and before back to Python 2.4), which favored "easy_install".


.. |Pypi Installs| image:: https://pepy.tech/badge/term-background
.. |Supported Python Versions| image:: https://img.shields.io/pypi/pyversions/term-background.svg
.. |packagestatus| image:: https://repology.org/badge/vertical-allrepos/python:term-background.svg :target: https://repology.org/project/python:term-background/versions
