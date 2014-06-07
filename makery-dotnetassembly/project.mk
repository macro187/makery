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

DOTNETASSEMBLY_dir_DESC := \
Directory where assembly and associated files are located
$(call PROJ_DeclareVar,DOTNETASSEMBLY_dir)
DOTNETASSEMBLY_dir_DEFAULT =


DOTNETASSEMBLY_all_DESC := \
Binary plus related files, relative to DOTNETASSEMBLY_dir (list)
$(call PROJ_DeclareVar,DOTNETASSEMBLY_all)


DOTNETASSEMBLY_all_abs_DESC := \
(read-only) Absolute paths to DOTNETASSEMBLY_all (list)
$(call PROJ_DeclareVar,DOTNETASSEMBLY_all_abs)
DOTNETASSEMBLY_all_abs = \
$(foreach f,$(DOTNETASSEMBLY_all),$(call MAKE_EncodeWord,$(DOTNETASSEMBLY_dir))/$(f))


DOTNETASSEMBLY_primary_DESC := \
Primary assembly file (.exe or .dll), relative to DOTNETASSEMBLY_dir
$(call PROJ_DeclareVar,DOTNETASSEMBLY_primary)
DOTNETASSEMBLY_primary_DEFAULT =

DOTNETASSEMBLY_all += $(DOTNETASSEMBLY_primary)


DOTNETASSEMBLY_primary_abs_DESC := \
(read-only) Absolute path to DOTNETASSEMBLY_primary
$(call PROJ_DeclareVar,DOTNETASSEMBLY_primary_abs)
DOTNETASSEMBLY_primary_abs = $(DOTNETASSEMBLY_dir)/$(DOTNETASSEMBLY_primary)


DOTNETASSEMBLY_subdirs_DESC := \
(read-only) Any subdirectories involved in DOTNETASSEMBLY_all
$(call PROJ_DeclareVar,DOTNETASSEMBLY_subdirs)
DOTNETASSEMBLY_subdirs = \
$(filter-out ./,$(dir $(DOTNETASSEMBLY_all)))

