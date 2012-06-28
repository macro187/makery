# ------------------------------------------------------------------------------
# Copyright (c) 2012
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

DOTNET_LIB_dir_DESC := \
Directory where library files are located
$(call PROJ_DeclareVar,DOTNET_LIB_dir)
DOTNET_LIB_dir_DEFAULT =


DOTNET_LIB_primary_DESC := \
Library file, relative to DOTNET_LIB_dir
$(call PROJ_DeclareVar,DOTNET_LIB_primary)
DOTNET_LIB_primary_DEFAULT =


DOTNET_LIB_all_DESC := \
Library file plus related files, relative to DOTNET_LIB_dir (list)
$(call PROJ_DeclareVar,DOTNET_LIB_all)


DOTNET_LIB_all_abs_DESC := \
Absolute paths to DOTNET_LIB_all (list) (readonly)
$(call PROJ_DeclareVar,DOTNET_LIB_all_abs)
DOTNET_LIB_all_abs = \
$(foreach f,$(DOTNET_LIB_all),$(call MAKE_EncodeWord,$(DOTNET_LIB_dir))/$(f))


DOTNET_LIB_subdirs_DESC := \
Any subdirectories involved in DOTNET_LIB_all (read-only)
$(call PROJ_DeclareVar,DOTNET_LIB_subdirs)
DOTNET_LIB_subdirs = \
$(filter-out ./,$(dir $(DOTNET_LIB_all)))

