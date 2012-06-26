# ------------------------------------------------------------------------------
# Copyright (c) 2007, 2008, 2009, 2010, 2011, 2012
# Ron MacNeil <macro@hotmail.com>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Global Makery settings
# ------------------------------------------------------------------------------

MAKERY_DESC := \
Location of Makery
ifndef MAKERY
$(error The MAKERY variable is not set, how did you include makery.mk?)
endif
MAKERY_GLOBALS += MAKERY


MAKERYDEBUG_DESC := \
Print debug information?
override MAKERYDEBUG := $(strip $(MAKERYDEBUG))
MAKERY_GLOBALS += MAKERYDEBUG


MAKERYTRACE_DESC := \
Print function trace information?
override MAKERYTRACE := $(strip $(MAKERYTRACE))
MAKERY_GLOBALS += MAKERYTRACE


MAKERYPATH_DESC := \
Paths that PROJ_Locate() searches for projects in (list)
override MAKERYPATH := \
$(subst $(MAKE_CHAR_COLON_ENCODED), ,$(call MAKE_EncodeWord,$(MAKERYPATH)))
MAKERY_GLOBALS += MAKERYPATH

override MAKERYPATH += $(call MAKE_EncodeWord,$(MAKERY))


MAKERYOUT_DESC := \
Absolute path to out-of-tree root output directory, or blank to build in-tree
override MAKERYOUT := $(strip $(MAKERYOUT))
MAKERY_GLOBALS += MAKERYOUT


# ------------------------------------------------------------------------------
# Global variable list
# ------------------------------------------------------------------------------

MAKERY_GLOBALS := $(MAKERY_GLOBALS)



# ------------------------------------------------------------------------------
# Messages
# ------------------------------------------------------------------------------

# Produce a heading message
#
# $1 - Heading
#
MAKERY_Heading = \
===> $(1)


# Shell command(s), for use in rules, to print a heading for the current target
#
ifndef MAKERYDEBUG
define MAKERY_TARGETHEADING
	@echo ===\> Building \'$@\'
endef
else
define MAKERY_TARGETHEADING
	@echo ===\> Building \'$@\'
	@echo [debug] Newer prerequisites: \'$?\'
endef
endif



# ------------------------------------------------------------------------------
# Debugging
# ------------------------------------------------------------------------------

ifdef MAKERYDEBUG
MAKERY_Debug = $(info [DEBUG] $(1))
else
MAKERY_Debug =
endif



# ------------------------------------------------------------------------------
# Tracing
# ------------------------------------------------------------------------------

ifdef MAKERYTRACE
MAKERY_TRACE = $(info [trace] $(0)())
MAKERY_TRACE1 = $(info [trace] $(0)($(1)))
MAKERY_TRACE2 = $(info [trace] $(0)($(1),$(2)))
MAKERY_TRACE3 = $(info [trace] $(0)($(1),$(2),$(3)))
else
MAKERY_TRACE =
MAKERY_TRACE1 =
MAKERY_TRACE2 =
MAKERY_TRACE3 =
endif

ifdef MAKERYTRACE
MAKERY_TRACEBEGIN = $(info [trace begin] $(0)())
MAKERY_TRACEBEGIN1 = $(info [trace begin] $(0)($(1)))
MAKERY_TRACEBEGIN2 = $(info [trace begin] $(0)($(1),$(2)))
MAKERY_TRACEBEGIN3 = $(info [trace begin] $(0)($(1),$(2),$(3)))
else
MAKERY_TRACEBEGIN =
MAKERY_TRACEBEGIN1 =
MAKERY_TRACEBEGIN2 =
MAKERY_TRACEBEGIN3 =
endif

ifdef MAKERYTRACE
MAKERY_TRACEEND = $(info [trace end  ] $(0)())
MAKERY_TRACEEND1 = $(info [trace end  ] $(0)($(1)))
MAKERY_TRACEEND2 = $(info [trace end  ] $(0)($(1),$(2)))
MAKERY_TRACEEND3 = $(info [trace end  ] $(0)($(1),$(2),$(3)))
else
MAKERY_TRACEEND =
MAKERY_TRACEEND1 =
MAKERY_TRACEEND2 =
MAKERY_TRACEEND3 =
endif

