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


ALLSUBDIRS_subdirs_DESC := \
All subdirectories
$(call PROJ_DeclareVar,ALLSUBDIRS_subdirs)
ALLSUBDIRS_subdirs = $(call SYSTEM_FindDirs,$(PROJ_dir)/*)


ALLSUBDIRS_projsubdirs_DESC := \
All subdirectories containing a Makefile
$(call PROJ_DeclareVar,ALLSUBDIRS_projsubdirs)
ALLSUBDIRS_projsubdirs = \
$(foreach d,$(ALLSUBDIRS_subdirs),$(if $(wildcard $(call MAKE_DecodeWord,$(d))/Makefile),$(d),))


PROJ_required += $(notdir $(ALLSUBDIRS_projsubdirs))

