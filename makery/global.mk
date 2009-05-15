# ------------------------------------------------------------------------------
# Copyright (c) 2007 Ron MacNeil <macro187 AT users DOT sourceforge DOT net>
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
# Makery's location
# ------------------------------------------------------------------------------

ifndef MAKERY
$(error The MAKERY variable is not set, how did you include makery.mk?)
endif


# ------------------------------------------------------------------------------
# Global variable list
# ------------------------------------------------------------------------------

MAKERY_GLOBALS := $(MAKERY_GLOBALS)


# ------------------------------------------------------------------------------
# Debugging
# ------------------------------------------------------------------------------

MAKERY_DEBUG := $(strip $(MAKERY_DEBUG))
MAKERY_GLOBALS += MAKERY_DEBUG

ifneq ($(MAKERY_DEBUG),)
MAKERY_Debug = $(warning $(call MAKE_Message,$(1)))
else
MAKERY_Debug =
endif


# ------------------------------------------------------------------------------
# Function Tracing
# ------------------------------------------------------------------------------

MAKERY_TRACE ?= $(MAKERY_DEBUG)
MAKERY_GLOBALS += MAKERY_TRACE
ifneq ($(MAKERY_TRACE),)
MAKERY_Trace = $(warning $(call MAKE_Message,$(0)()))
MAKERY_Trace1 = $(warning $(call MAKE_Message,$(0)($(1))))
MAKERY_Trace2 = $(warning $(call MAKE_Message,$(0)($(1),$(2))))
else
MAKERY_Trace =
MAKERY_Trace1 =
MAKERY_Trace2 =
endif

