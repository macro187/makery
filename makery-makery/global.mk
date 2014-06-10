# ------------------------------------------------------------------------------
# Copyright (c) Ron MacNeil <macro@hotmail.com>
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
$(subst $(MAKE_CHAR_COLON_TOKEN), ,$(call MAKE_EncodeWord,$(MAKERYPATH)))
MAKERY_GLOBALS += MAKERYPATH

override MAKERYPATH := $(call MAKE_EncodeWord,$(MAKERY)) $(MAKERYPATH)


MAKERYOUT_DESC := \
Absolute path to out-of-tree root output directory, or blank to build in-tree
override MAKERYOUT := $(strip $(MAKERYOUT))
MAKERY_GLOBALS += MAKERYOUT


MAKERYIGNORECACHE_DESC := \
Ignore cached variables?
override MAKERYIGNORECACHE := $(strip $(MAKERYIGNORECACHE))
MAKERY_GLOBALS += MAKERYIGNORECACHE


# Global variable list
#
MAKERY_GLOBALS := $(MAKERY_GLOBALS)


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


ifdef MAKERYDEBUG
MAKERY_Debug = $(info [debug] $(1))
else
MAKERY_Debug =
endif


ifdef MAKERYTRACE
MAKERY_TraceBegin = $(info [begin] $(1))
MAKERY_TRACEBEGIN = $(call MAKERY_TraceBegin,$(0)())
MAKERY_TRACEBEGIN1 = $(call MAKERY_TraceBegin,$(0)($(1)))
MAKERY_TRACEBEGIN2 = $(call MAKERY_TraceBegin,$(0)($(1),$(2)))
MAKERY_TRACEBEGIN3 = $(call MAKERY_TraceBegin,$(0)($(1),$(2),$(3)))
else
MAKERY_TraceBegin =
MAKERY_TRACEBEGIN =
MAKERY_TRACEBEGIN1 =
MAKERY_TRACEBEGIN2 =
MAKERY_TRACEBEGIN3 =
endif

ifdef MAKERYTRACE
MAKERY_TraceEnd = $(info [end]   $(1))
MAKERY_TRACEEND = $(call MAKERY_TraceEnd,$(0)())
MAKERY_TRACEEND1 = $(call MAKERY_TraceEnd,$(0)($(1)))
MAKERY_TRACEEND2 = $(call MAKERY_TraceEnd,$(0)($(1),$(2)))
MAKERY_TRACEEND3 = $(call MAKERY_TraceEnd,$(0)($(1),$(2),$(3)))
else
MAKERY_TraceEnd =
MAKERY_TRACEEND =
MAKERY_TRACEEND1 =
MAKERY_TRACEEND2 =
MAKERY_TRACEEND3 =
endif

