# A GNU Makefile to run various tasks - compatibility for us old-timers.

# Note: This makefile include remake-style target comments.
# These comments before the targets start with #:
# remake --tasks to shows the targets and the comments

GIT2CL ?= admin-tools/git2cl
PYTHON ?= python3
PIP ?= pip3
RM  ?= rm

# The output is stored in the ZSH_PATH variable.

SHELLS =

BASH_PATH := $(shell command -v bash)
ifneq ($(strip $(BASH_PATH)),)
    SHELLS += $(BASH_PATH)
endif

ZSH_PATH := $(shell command -v zsh)
ifneq ($(strip $(ZSH_PATH)),)
    SHELLS += $(ZSH_PATH)
endif

KSH_PATH := $(shell command -v ksh)
ifneq ($(strip $(KSH_PATH)),)
    SHELLS += $(KSH_PATH)
endif

.PHONY: \
   all \
   build \
   check \
   clean develop \
   dist \
   doc \
   python-check \
   pytest \
   rmChangeLog \
   sdist \
   shunit2-check \
   test

#: Default target - same as "develop"
all: develop

#: build everything needed to install
build:
	$(PYTHON) ./setup.py build

#: Set up to run from the source tree
develop:
	$(PIP) install -e .

#: Install Python term-background
install:
	$(PYTHON) setup.py install

#: Run all check (Python and Shell)
check: python-check shunit2-check

#: Run Python tests. You can set environment variable "o" for pytest options
python-check:
	$(PYTHON) -m pytest test $o

#: Run Shell tests. You can set environment variable "o" for pytest options
shunit2-check:
	@for shell in $(SHELLS); do \
	shell_basename=$${shell##*/}; \
        $$shell test/*.$${shell_basename} $o; \
	done

# Check StructuredText long description formatting
check-rst:
	$(PYTHON) setup.py --long-description | ./rst2html.py > term-background.html

#: Remove derived files
clean:

#: Remove ChangeLog
rmChangeLog:
	$(RM) ChangeLog || true

#: Create source tarball
sdist: check-rst
	$(PYTHON) ./setup.py sdist

#: Create a ChangeLog from git via git log and git2cl
ChangeLog: rmChangeLog
	git log --pretty --numstat --summary | $(GIT2CL) >$@
