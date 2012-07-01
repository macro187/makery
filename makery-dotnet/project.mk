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


#
# TODO config.xml support
# config.xml -> <bin_main>.config
# bin_all += ...
#
# TODO: AL and satellite assembly support?
#


# ------------------------------------------------------------------------------
# Variables relevant to both running and building .NET assemblies
# ------------------------------------------------------------------------------

DOTNET_implementation_DESC ?= \
.NET implementation to use
$(call PROJ_DeclareVar,DOTNET_implementation)
DOTNET_implementation_VALIDATE = Required
DOTNET_implementation_OPTIONS = $(DOTNET_FRAMEWORKS)

# Mask unavailable implementations
DOTNET_implementation_MASK += \
$(if $(strip $(foreach gen,$(DOTNET_GENERATIONS),$(DOTNET_MS_$(gen)_FRAMEWORKDIR))),,ms)
DOTNET_implementation_MASK += $(if $(DOTNET_MONO),,mono)
DOTNET_implementation_MASK += $(if $(DOTNET_ILRUN),,pnet)


DOTNET_generation_DESC ?= \
.NET generation to use
$(call PROJ_DeclareVar,DOTNET_generation)
DOTNET_generation_OPTIONS = $(DOTNET_GENERATIONS)
DOTNET_generation_VALIDATE = Required Min|$(DOTNET_required_generation)

# Mask generations based on availability of C# compilers XXX
DOTNET_generation_MASK = \
$(foreach gen,$(DOTNET_GENERATIONS),$(if $(DOTNET_$(call uc,$(DOTNET_implementation))_$(gen)_COMPILER_CS),,$(gen)))


DOTNET_debug_DESC ?= \
Enable debug compilation, execution, etc?
$(call PROJ_DeclareVar,DOTNET_debug)
DOTNET_debug_OPTIONS = 1 0


DOTNET_optimize_DESC ?= \
Enable optimized compilation, execution, etc?
$(call PROJ_DeclareVar,DOTNET_optimize)
DOTNET_optimize_OPTIONS = $(if $(filter 1,$(DOTNET_debug)),0 1,1 0)


DOTNET_required_generation_DESC ?= \
Minimum .NET generation the project requires
$(call PROJ_DeclareVar,DOTNET_required_generation)
DOTNET_required_generation_DEFAULT = $(firstword $(DOTNET_generation_OPTIONS))


DOTNET_exec_DESC ?= \
(read-only) Program used to run .NET binaries
$(call PROJ_DeclareVar,DOTNET_exec)
DOTNET_exec = \
$(if $(filter $(DOTNET_implementation),mono),$(DOTNET_MONO) $(if $(filter 1,$(DOTNET_debug)),--debug) $(if $(filter 1,$(DOTNET_optimize)),--optimize=all))
DOTNET_exec += \
$(if $(filter $(DOTNET_implementation),pnet),$(DOTNET_ILRUN))



# ------------------------------------------------------------------------------
# Variables relevant only to building .NET assemblies
# ------------------------------------------------------------------------------

DOTNET_namespace_DESC ?= \
Projects root .NET namespace
$(call PROJ_DeclareVar,DOTNET_namespace)
DOTNET_namespace_DEFAULT = $(PROJ_name)


DOTNET_gaclibs_DESC ?= \
(append-only) Filenames (including .dll extension) of .NET libraries required from the GAC (list)
$(call PROJ_DeclareVar,DOTNET_gaclibs)


DOTNET_projlibs_DESC ?= \
(append-only) Names of required .NET library projects (list)
$(call PROJ_DeclareVar,DOTNET_projlibs)

# Pull required library projects into the build
PROJ_required += $(DOTNET_projlibs)


DOTNET_resources_DESC ?= \
(append-only) Resource files to embed into the output binary (list)
$(call PROJ_DeclareVar,DOTNET_resources)


DOTNET_librefs_DESC ?= \
(read-only) Libraries to reference when compiling (list)
$(call PROJ_DeclareTargetVar,DOTNET_librefs)
DOTNET_librefs = \
$(sort $(DOTNET_gaclibs) $(call PROJ_GetMultiRecursive,DOTNET_gaclibs,DOTNET_projlibs)) $(sort $(call PROJ_GetVarRecursive,DOTNET_BIN_primary_abs,DOTNET_projlibs))


DOTNET_outbase_DESC ?= \
Output binary filename base
$(call PROJ_DeclareVar,DOTNET_outbase)
DOTNET_outbase_DEFAULT = $(DOTNET_namespace)


DOTNET_outtype_DESC ?= \
Output binary type
$(call PROJ_DeclareVar,DOTNET_outtype)
DOTNET_outtype_OPTIONS = lib exe


DOTNET_outext_DESC ?= \
(read-only) Output binary filename extension
$(call PROJ_DeclareVar,DOTNET_outext)
DOTNET_outext_DEFAULT = $(if $(filter exe,$(DOTNET_outtype)),exe,dll)


DOTNET_outdir_DESC ?= \
Directory to put output binary file(s) in
$(call PROJ_DeclareVar,DOTNET_outdir)
DOTNET_outdir_DEFAULT = $(OUT_base)/dotnet

# Tell OUT module to handle the output directory
OUT_all += $(call MAKE_EncodeWord,$(DOTNET_outdir))


DOTNET_outbase_abs_DESC ?= \
(read-only) Final output binary path+filename, no extension
$(call PROJ_DeclareVar,DOTNET_outbase_abs)
DOTNET_outbase_abs = $(DOTNET_outdir)/$(DOTNET_outbase)


DOTNET_outfiles_DESC ?= \
(append-only) Output binary and associated files (list)
$(call PROJ_DeclareVar,DOTNET_outfiles)


DOTNET_outfiles_main_DESC ?= \
(read-only) The primary output binary file
$(call PROJ_DeclareVar,DOTNET_outfiles_main)
DOTNET_outfiles_main = $(DOTNET_outbase_abs).$(DOTNET_outext)

DOTNET_outfiles += $(call MAKE_EncodeWord,$(DOTNET_outfiles_main))

