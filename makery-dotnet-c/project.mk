# ------------------------------------------------------------------------------
# Copyright (c) 2007, 2008, 2009, 2010, 2011, 2012
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


# Only pnet can do C, and pnet only implements .NET 1.1
DOTNET_implementation_MASK_CONLYPNET = $(filter-out pnet,$(DOTNET_implementation_ALL))
DOTNET_implementation_MASK_CONLYPNET_DESC ?= Only pnet can do C
DOTNET_implementation_MASKS += CONLYPNET

DOTNET_generation_MASK_PNET11ONLY = \
$(foreach g,$(DOTNET_generation_ALL),$(if $(call gt,$(g),11),$(g)))
DOTNET_generation_MASK_PNET11ONLY_DESC ?= Pnet currently only does .NET 1.1
DOTNET_generation_MASKS += PNET11ONLY


$(call PROJ_DeclareVar,DOTNET_C_defines)
DOTNET_C_defines_DESC ?= Preprocessor variables to define (list)


DOTNET_C_defines += $(if $(filter 1,$(DOTNET_debug)),DEBUG)


$(call PROJ_DeclareVar,DOTNET_C_checked)
DOTNET_C_checked_DESC ?= Enable runtime arithmetic bounds checking? (0|1)
DOTNET_C_checked_DEFAULT = 1


$(call PROJ_DeclareVar,DOTNET_C_warn)
DOTNET_C_warn_DESC ?= Compiler warning level (0-4)
DOTNET_C_warn_DEFAULT = 4


$(call PROJ_DeclareVar,DOTNET_C_werror)
DOTNET_C_werror_DESC ?= Treat compiler warnings as errors? (0|1)
DOTNET_C_werror_DEFAULT = 1


# Hook up srcs-find
# TODO Move somewhere else?
SRCS_FIND_extension = c
SRCS_files = $(SRCS_FIND_files)
SRCS_files_preq = $(SRCS_FIND_files)

