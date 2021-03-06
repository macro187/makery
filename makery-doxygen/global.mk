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


ifeq ($(strip $(DOXYGEN_DOXYGEN)),)
DOXYGEN_DOXYGEN := $(call MAKE_Shell,which doxygen 2>&-)
endif


ifneq ($(SYSTEM_ISWINDOWS),)
ifeq ($(strip $(DOXYGEN_DOXYGEN)),)
DOXYGEN_ROOT := $(call SYSTEM_FindProgramFilesDir,doxygen)
DOXYGEN_DOXYGEN := $(if $(DOXYGEN_ROOT),$(call SYSTEM_FindFile,$(DOXYGEN_ROOT)/bin/doxygen.exe))
endif

endif


# Default value for preprocessor variables
#
DOXYGEN_DEFINE_DEFAULT := 1


# Generate doxygen docs for main project / all doxygen-enabled projects
#
.PHONY: doxygen doxygenall
doxygen doxygenall:
	$(MAKERY_TARGETHEADING)

