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

DOTNET_BIN_dir_DESC := \
Directory where binary and associated files are located
$(call PROJ_DeclareVar,DOTNET_BIN_dir)
DOTNET_BIN_dir_DEFAULT =


DOTNET_BIN_primary_DESC := \
Binary (.exe or .dll), relative to DOTNET_BIN_dir
$(call PROJ_DeclareVar,DOTNET_BIN_primary)
DOTNET_BIN_primary_DEFAULT =


DOTNET_BIN_all_DESC := \
Binary plus related files, relative to DOTNET_BIN_dir (list)
$(call PROJ_DeclareVar,DOTNET_BIN_all)


DOTNET_BIN_primary_abs_DESC := \
(read-only) Absolute path to DOTNET_BIN_primary
$(call PROJ_DeclareVar,DOTNET_BIN_primary_abs)
DOTNET_BIN_primary_abs = $(DOTNET_BIN_dir)/$(DOTNET_BIN_primary)


DOTNET_BIN_all_abs_DESC := \
(read-only) Absolute paths to DOTNET_BIN_all (list)
$(call PROJ_DeclareVar,DOTNET_BIN_all_abs)
DOTNET_BIN_all_abs = \
$(foreach f,$(DOTNET_BIN_all),$(call MAKE_EncodeWord,$(DOTNET_BIN_dir))/$(f))


DOTNET_BIN_subdirs_DESC := \
(read-only) Any subdirectories involved in DOTNET_BIN_all
$(call PROJ_DeclareVar,DOTNET_BIN_subdirs)
DOTNET_BIN_subdirs = \
$(filter-out ./,$(dir $(DOTNET_BIN_all)))

