# ------------------------------------------------------------------------------
# Copyright (c) 2007, 2008, 2009, 2010, 2011
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
# Doxygen Makery module directory
# ------------------------------------------------------------------------------

DOXYGEN_MAKERY_MODULE_DIR := $(call MODULES_Locate,doxygen)
# TODO If blank we've got a problem



# ------------------------------------------------------------------------------
# Doxygen executable
# ------------------------------------------------------------------------------

ifndef DOXYGEN_DOXYGEN
DOXYGEN_DOXYGEN := $(shell which doxygen 2>&-)
endif

ifndef DOXYGEN_DOT
DOXYGEN_DOT := $(shell which dot 2>&-)
endif



# ------------------------------------------------------------------------------
# Default value for preprocessor variables
# ------------------------------------------------------------------------------

DOXYGEN_DEFINE_DEFAULT := 1



# ------------------------------------------------------------------------------
# Global targets
# ------------------------------------------------------------------------------

# Generate doxygen docs for main project / all doxygen-enabled projects
.PHONY: doxygen doxygenall
doxygen doxygenall:
	$(SYSTEM_SHELL_TARGETHEADING)

