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


HTDOCS_dir_DESC ?= \
Directory containing web files
$(call PROJ_DeclareVar,HTDOCS_dir)
HTDOCS_dir_VALIDATE = Required
HTDOCS_dir = $(PROJ_dir)


HTDOCS_include_DESC ?= \
Names of other HTDOCS projects whose contents to include (list)
$(call PROJ_DeclareVar,HTDOCS_include)

PROJ_required += $(HTDOCS_include)


HTDOCS_exclude_DESC ?= \
Paths (or patterns with % wildcard) to exclude (unencoded list)
$(call PROJ_DeclareVar,HTDOCS_exclude)
HTDOCS_exclude += Makefile


HTDOCS_excludedirs_DESC ?= \
Subdirectories to exclude, relative to HTDOCS_dir (list)
$(call PROJ_DeclareVar,HTDOCS_excludedirs)
HTDOCS_excludedirs_DEFAULT = out


HTDOCS_files_DESC ?= \
(read-only) Web files, relative to HTDOCS_dir (list)
$(call PROJ_DeclareVar,HTDOCS_files)
HTDOCS_files = $(filter-out $(HTDOCS_exclude),$(call SYSTEM_FindFilesUnder,$(HTDOCS_dir),,$(HTDOCS_excludedirs)))


HTDOCS_dirs_DESC ?= \
(read-only) Web files, relative to HTDOCS_dir (list)
$(call PROJ_DeclareVar,HTDOCS_dirs)
HTDOCS_dirs = $(filter-out ./,$(sort $(dir $(HTDOCS_files))))


HTDOCS_files_abs_DESC ?= \
(read-only) Web files, absolute (list)
$(call PROJ_DeclareVar,HTDOCS_files_abs)
HTDOCS_files_abs = $(foreach f,$(HTDOCS_files),$(call MAKE_EncodeWord,$(HTDOCS_dir))/$(f))

