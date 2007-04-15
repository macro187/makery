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


$(call PROJ_DeclareVar,SRCS_FIND_dir)
SRCS_FIND_dir_DESC ?= Directory to find source code files in
SRCS_FIND_dir_VALIDATE ?= Required
SRCS_FIND_dir_DEFAULT = $(PROJ_dir)


$(call PROJ_DeclareVar,SRCS_FIND_extension)
SRCS_FIND_extension_DESC ?= Filename extension of source code files to find
SRCS_FIND_extension_VALIDATE ?= Required


$(call PROJ_DeclareVar,SRCS_FIND_recursive)
SRCS_FIND_recursive_DESC ?= Search for source code files recursively?
SRCS_FIND_recursive_DEFAULT = \
$(call not,$(call seq,$(SRCS_FIND_dir),$(PROJ_dir)))


$(call PROJ_DeclareVar,SRCS_FIND_exclude)
SRCS_FIND_exclude_DESC ?= Pattern of source code files to filter-out


$(call PROJ_DeclareVar,SRCS_FIND_files)
SRCS_FIND_files_DESC ?= Located source code files (list) (read-only)

SRCS_FIND_files = \
$(filter-out $(SRCS_FIND_exclude), \
$(shell \
find $(call SHELL_Escape,$(SRCS_FIND_dir))$(if $(SRCS_FIND_recursive),, -maxdepth 1) -type f -name \*.$(SRCS_FIND_extension)\
| $(SHELL_CLEANPATH) \
| $(SHELL_ENCODEWORD) \
) \
)

