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


ifeq ($(strip $(GRAPHVIZ_DOT)),)
GRAPHVIZ_DOT := $(call MAKE_Shell,which dot 2>&-)
endif


ifneq ($(SYSTEM_ISWINDOWS),)
ifeq ($(strip $(GRAPHVIZ_DOT)),)
GRAPHVIZ_ROOT := $(call SYSTEM_FindProgramFilesDir,Graphviz[0-9].[0-9][0-9])
GRAPHVIZ_BIN := $(if $(GRAPHVIZ_ROOT),$(call SYSTEM_FindDir,$(GRAPHVIZ_ROOT)/bin))
GRAPHVIZ_DOT := $(if $(GRAPHVIZ_BIN),$(call SYSTEM_FindFile,$(GRAPHVIZ_BIN)/dot.exe))
endif
endif

