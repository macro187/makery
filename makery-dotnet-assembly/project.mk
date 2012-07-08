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

DOTNET_ASSEMBLY_dir_DESC := \
Directory where assembly and associated files are located
$(call PROJ_DeclareVar,DOTNET_ASSEMBLY_dir)
DOTNET_ASSEMBLY_dir_DEFAULT =


DOTNET_ASSEMBLY_primary_DESC := \
Primary assembly file (.exe or .dll), relative to DOTNET_ASSEMBLY_dir
$(call PROJ_DeclareVar,DOTNET_ASSEMBLY_primary)
DOTNET_ASSEMBLY_primary_DEFAULT =


DOTNET_ASSEMBLY_all_DESC := \
Binary plus related files, relative to DOTNET_ASSEMBLY_dir (list)
$(call PROJ_DeclareVar,DOTNET_ASSEMBLY_all)


DOTNET_ASSEMBLY_primary_abs_DESC := \
(read-only) Absolute path to DOTNET_ASSEMBLY_primary
$(call PROJ_DeclareVar,DOTNET_ASSEMBLY_primary_abs)
DOTNET_ASSEMBLY_primary_abs = $(DOTNET_ASSEMBLY_dir)/$(DOTNET_ASSEMBLY_primary)


DOTNET_ASSEMBLY_all_abs_DESC := \
(read-only) Absolute paths to DOTNET_ASSEMBLY_all (list)
$(call PROJ_DeclareVar,DOTNET_ASSEMBLY_all_abs)
DOTNET_ASSEMBLY_all_abs = \
$(foreach f,$(DOTNET_ASSEMBLY_all),$(call MAKE_EncodeWord,$(DOTNET_ASSEMBLY_dir))/$(f))


DOTNET_ASSEMBLY_subdirs_DESC := \
(read-only) Any subdirectories involved in DOTNET_ASSEMBLY_all
$(call PROJ_DeclareVar,DOTNET_ASSEMBLY_subdirs)
DOTNET_ASSEMBLY_subdirs = \
$(filter-out ./,$(dir $(DOTNET_ASSEMBLY_all)))

