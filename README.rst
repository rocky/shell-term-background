|Pypi Installs| |Supported Python Versions|

The Python module contained is part of a broader set of scripts

For the shell scripts, if you source this from a shell session, it will set and export ``COLORFGBG`` to ``0;15`` for dark backgrounds and ``15;0`` for light backgrounds, which is
a convention used by some programs. Since I find this a little arcane, the program also sets and exports ``LC_DARK_BG`` to 1 for dark backgrounds and 0 for light. The ``LC_`` (locale) assists in some ssh configurations, which often will let environment variables with that prefix get passed along and set to a remote ssh session.

From Python, you can call ``term_background.is_dark_background()`` which returns a ``True`` if we think the background is dark.

To see if your environment variables are color consistent, run:

.. code::

    $ python -m term_background


The heuristics used is to try to query the background color using an `xterm control sequence <https://www.talisman.org/~erlkonig/documents/xterm-color-queries/>`_.

Many, but not all, terminals support this query. So as a fallback, we query the environment variable ``COLORFGBG``, and failing this, we use some defaults for some known terminals set from the ``TERM`` environment variable. MacOS has its way of querying characteristics, so we use that too if you are running on that OS.

When we can get pixel intensities of red, blue, and green values of the background, we can use that to determine light and dark based on the combined sum: zero values indicate an absence of a particular color, and compare that with the values of the foreground.

You can set any of these environment variables to influence the output decision.

Many thanks to Thomas Dickey, Egmont Koblinger, and Gilles, for explanations (and code!) via `unix.stackexchange <http://unix.stackexchange.com/questions/245378/common-environment-variable-to-set-dark-or-light-terminal-background/245381#245381>`_. John Green had the idea to compare the foreground and background colors instead of comparing the background against the midway gray color and implemented that change here.

Of course, the bugs and lacunae in this code are mine.

.. |Pypi Installs| image:: https://pepy.tech/badge/term-background
.. |Supported Python Versions| image:: https://img.shields.io/pypi/pyversions/term-background.svg
.. |packagestatus| image:: https://repology.org/badge/vertical-allrepos/python:term-background.svg :target: https://repology.org/project/python:term-background/versions
