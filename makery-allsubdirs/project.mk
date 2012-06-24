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


$(call PROJ_DeclareVar,ALLSUBDIRS_subdirs)
ALLSUBDIRS_subdirs_DESC ?= All subdirectories
ALLSUBDIRS_subdirs = \
$(shell cd $(call SYSTEM_ShellEscape,$(PROJ_dir)) && find * -maxdepth 0 -type d | $(SYSTEM_SHELL_ENCODEWORD))


$(call PROJ_DeclareVar,ALLSUBDIRS_projsubdirs)
ALLSUBDIRS_projsubdirs_DESC ?= Subdirectories containing a Makefile
ALLSUBDIRS_projsubdirs = \
$(foreach d,$(ALLSUBDIRS_subdirs),$(if $(shell test -e $(call SYSTEM_ShellEscape,$(PROJ_dir)/$(call MAKE_DecodeWord,$(d))/Makefile) && echo yes),$(d)))


# Pull in all project subdirectories
PROJ_required += $(ALLSUBDIRS_projsubdirs)

