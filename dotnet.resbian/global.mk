# ------------------------------------------------------------------------------
# Copyright (c) 2007, 2008, 2009, 2010, 2011
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


DOTNET_RESBIAN_PROJ := $(call PROJ_Locate,Com.Halfdecent.Resbian)
DOTNET_RESBIAN_PROJ_DESC := Location of the Resbian project
MAKERY_GLOBALS += DOTNET_RESBIAN_PROJ


# Get list of srcs for given culture
# $1 - culture
DOTNET_RESBIAN_GetFilesC = \
$(if $(filter .,$(1)),$(foreach f,$(DOTNET_RESBIAN_srcs),$(if $(findstring /,$(f)),,$(f))),$(filter $(1)/%,$(DOTNET_RESBIAN_srcs)))


# Get list of types for given culture
# $1 - culture
DOTNET_RESBIAN_GetTypes = \
$(sort $(foreach f,$(call DOTNET_RESBIAN_GetFilesC,$(1)),$(firstword $(subst __, ,$(notdir $(f))))))


# Get list of srcs for given culture and type
# $1 - culture
# $2 - type
DOTNET_RESBIAN_GetFilesCT = \
$(foreach f,$(call DOTNET_RESBIAN_GetFilesC,$(1)),$(if $(filter $(2)__%,$(notdir $(f))),$(call MAKE_EncodeWord,$(DOTNET_RESBIAN_srcdir))/$(f)))


# Generate outfile name for given culture and type
# $1 - culture
# $2 - type
DOTNET_RESBIAN_GetOutfile = \
$(DOTNET_RESBIAN_outdir)/$(DOTNET_namespace)$(if $(DOTNET_namespace),.)$(2).$(if $(filter .,$(1)),,$(1).)resources

