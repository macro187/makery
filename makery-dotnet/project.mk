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


DOTNET_type_DESC ?= \
Type of assembly to produce
$(call PROJ_DeclareVar,DOTNET_type)
DOTNET_type_OPTIONS = lib exe


DOTNET_mingeneration_DESC ?= \
Minimum .NET generation
$(call PROJ_DeclareVar,DOTNET_mingeneration)
DOTNET_mingeneration_DEFAULT = \
$(lastword $(sort $(DOTNETFRAMEWORK_generation_OPTIONS)))


DOTNET_maxgeneration_DESC ?= \
Maximum .NET generation
$(call PROJ_DeclareVar,DOTNET_maxgeneration)
DOTNET_maxgeneration_DEFAULT = \
$(lastword $(sort $(DOTNETFRAMEWORK_generation_OPTIONS)))


DOTNET_debug_DESC ?= \
Enable debug compiler option(s)?
$(call PROJ_DeclareVar,DOTNET_debug)
DOTNET_debug_OPTIONS = 1 0


DOTNET_optimize_DESC ?= \
Enable compiler optimizations?
$(call PROJ_DeclareVar,DOTNET_optimize)
DOTNET_optimize_OPTIONS = 1 0
DOTNET_optimize_DEFAULT = $(if $(filter 1,$(DOTNET_debug)),0,1)


DOTNET_resources_DESC ?= \
(append-only) Resource files to embed into the output assembly (list)
$(call PROJ_DeclareVar,DOTNET_resources)


DOTNET_namespace_DESC ?= \
Root .NET namespace
$(call PROJ_DeclareVar,DOTNET_namespace)
DOTNET_namespace_DEFAULT = $(PROJ_name)


DOTNET_name_DESC ?= \
Assembly filename without extension
$(call PROJ_DeclareVar,DOTNET_name)
DOTNET_name_DEFAULT = $(DOTNET_namespace)


DOTNET_ext_DESC ?= \
(read-only) Assembly filename extension
$(call PROJ_DeclareVar,DOTNET_ext)
DOTNET_ext_DEFAULT = $(if $(filter exe,$(DOTNET_type)),exe,dll)


DOTNET_filename_DESC ?= \
(read-only) Assembly filename
$(call PROJ_DeclareVar,DOTNET_filename)
DOTNET_filename = $(DOTNET_name).$(DOTNET_ext)


DOTNETASSEMBLY_primary = $(DOTNET_filename)

