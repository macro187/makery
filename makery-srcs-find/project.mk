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


SRCS_FIND_dir_DESC := \
Directory to find source code files in
$(call PROJ_DeclareVar,SRCS_FIND_dir)
SRCS_FIND_dir_VALIDATE = Required
SRCS_FIND_dir_DEFAULT = $(PROJ_dir)


SRCS_FIND_extension_DESC := \
Filename extension of source code files to find
$(call PROJ_DeclareVar,SRCS_FIND_extension)
SRCS_FIND_extension_VALIDATE = Required


SRCS_FIND_exclude_DESC := \
Paths (or patterns with % wildcard) to exclude (unencoded list)
$(call PROJ_DeclareVar,SRCS_FIND_exclude)
SRCS_FIND_exclude += Makefile


SRCS_FIND_excludedirs_DESC := \
Subdirectories to exclude from search (list)
$(call PROJ_DeclareVar,SRCS_FIND_excludedirs)
SRCS_FIND_excludedirs += out


SRCS_FIND_rel_DESC := \
(read-only) Located source code files, relative to _dir (list)
$(call PROJ_DeclareVar,SRCS_FIND_rel)
SRCS_FIND_rel = \
$(filter-out $(SRCS_FIND_exclude),$(call SYSTEM_FindFiles,$(SRCS_FIND_dir),$(SRCS_FIND_extension),$(SRCS_FIND_excludedirs)))


SRCS_FIND_files_DESC := \
(read-only) Located source code files (list)
$(call PROJ_DeclareVar,SRCS_FIND_files)
SRCS_FIND_files = \
$(foreach f,$(SRCS_FIND_rel),$(call MAKE_EncodeWord,$(SRCS_FIND_dir))/$(f))


SRCS_FIND_preq_DESC := \
(read-only) Prerequisite version(s) of _files (list)
$(call PROJ_DeclareVar,SRCS_FIND_preq)
SRCS_FIND_preq = $(SRCS_FIND_files)


#
# Hook up to srcs-preprocess
#
SRCS_PREPROCESS_pipeline := srcs-find $(SRCS_PREPROCESS_pipeline)

$(call PROJ_DeclareVar,SRCS_FIND_ppdir)
SRCS_FIND_ppdir = $(SRCS_FIND_dir)

$(call PROJ_DeclareVar,SRCS_FIND_ppfiles)
SRCS_FIND_ppfiles = $(SRCS_FIND_rel)

$(call PROJ_DeclareVar,SRCS_FIND_pppreqs)
SRCS_FIND_pppreqs = $(SRCS_FIND_preq)

