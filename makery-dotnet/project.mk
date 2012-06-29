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


# ------------------------------------------------------------------------------
# Configs
# ------------------------------------------------------------------------------

$(call CONFIG_DeclareField,DOTNET_implementation)
DOTNET_implementation_DESC ?= .NET implementation
DOTNET_implementation_ALL = $(DOTNET_FRAMEWORKS)
DOTNET_implementation_VALIDATE = Required

DOTNET_implementation_MASK_MSNOTFOUND = \
$(if $(strip $(foreach gen,$(DOTNET_GENERATIONS),$(DOTNET_MS_$(gen)_FRAMEWORKDIR))),,ms)
DOTNET_implementation_MASK_MSNOTFOUND_DESC ?= Microsoft .NET not found
DOTNET_implementation_MASKS += MSNOTFOUND

DOTNET_implementation_MASK_MONONOTFOUND = $(if $(DOTNET_MONO),,mono)
DOTNET_implementation_MASK_MONONOTFOUND_DESC ?= Mono not found
DOTNET_implementation_MASKS += MONONOTFOUND

DOTNET_implementation_MASK_PNETNOTFOUND = $(if $(DOTNET_ILRUN),,pnet)
DOTNET_implementation_MASK_PNETNOTFOUND_DESC ?= Portable.NET not found
DOTNET_implementation_MASKS += PNETNOTFOUND


$(call CONFIG_DeclareField,DOTNET_generation)
DOTNET_generation_DESC ?= .NET generation
DOTNET_generation_ALL = $(DOTNET_GENERATIONS)
DOTNET_generation_VALIDATE = Required Min|$(DOTNET_required_generation)

DOTNET_generation_MASK_NOCOMPILER = \
$(foreach gen,$(DOTNET_GENERATIONS),$(if $(DOTNET_$(call uc,$(DOTNET_implementation))_$(gen)_COMPILER_CS),,$(gen)))
DOTNET_generation_MASK_NOCOMPILER_DESC ?= \
No compiler for framework/generation found
DOTNET_generation_MASKS += NOCOMPILER


$(call CONFIG_DeclareField,DOTNET_debug)
DOTNET_debug_DESC ?= Enable debug compilation, execution, etc? (debug|nodebug)
DOTNET_debug_ALL = debug nodebug
DOTNET_debug_VALIDATE = Required


$(call CONFIG_DeclareField,DOTNET_optimize)
DOTNET_optimize_DESC ?= \
Enable optimized compilation, execution, etc? (optimize|nooptimize)
#DOTNET_optimize_ALL = optimize nooptimize
DOTNET_optimize_ALL = $(if $(filter debug,$(DOTNET_debug)),nooptimize optimize,optimize nooptimize)
DOTNET_optimize_VALIDATE = Required



# ------------------------------------------------------------------------------
# Vars
# ------------------------------------------------------------------------------

$(call PROJ_DeclareVar,DOTNET_required_generation)
DOTNET_required_generation_DESC ?= Minimum .NET generation this project requires
DOTNET_required_generation_DEFAULT = $(firstword $(DOTNET_generation_ALL))

$(call PROJ_DeclareVar,DOTNET_exec)
DOTNET_exec_DESC ?= Program used to run .NET binaries
DOTNET_exec_DEFAULT = \
$(if $(filter $(DOTNET_implementation),mono),$(DOTNET_MONO) $(if $(filter debug,$(DOTNET_debug)),--debug) $(if $(filter optimize,$(DOTNET_optimize)),--optimize=all))
DOTNET_exec_DEFAULT += \
$(if $(filter $(DOTNET_implementation),pnet),$(DOTNET_ILRUN))


$(call PROJ_DeclareVar,DOTNET_namespace)
DOTNET_namespace_DESC ?= Projects root .NET namespace
DOTNET_namespace_DEFAULT = \
$(PROJ_name)


$(call PROJ_DeclareVar,DOTNET_resources)
DOTNET_resources_DESC ?= Resource files to embed into the output binary (list)


DOTNET_gaclibs_DESC ?= \
(append-only) Filenames (including .dll extension) .NET libraries required from the GAC (list)
$(call PROJ_DeclareVar,DOTNET_gaclibs)


$(call PROJ_DeclareVar,DOTNET_projlibs)
DOTNET_projlibs_DESC ?= \
(append-only) Names of required .NET library projects (list)

PROJ_required += $(DOTNET_projlibs)


DOTNET_librefs_DESC ?= \
(internal) Libraries to reference when compiling (list)
$(call PROJ_DeclareTargetVar,DOTNET_librefs)
DOTNET_librefs = \
$(sort $(DOTNET_gaclibs) $(call PROJ_GetMultiRecursive,DOTNET_gaclibs,DOTNET_projlibs)) $(sort $(call PROJ_GetVarRecursive,DOTNET_BIN_primary_abs,DOTNET_projlibs))


$(call PROJ_DeclareVar,DOTNET_outbase)
DOTNET_outbase_DESC ?= Output binary filename base
DOTNET_outbase_DEFAULT = $(DOTNET_namespace)


$(call PROJ_DeclareVar,DOTNET_outtype)
DOTNET_outtype_DESC ?= Output binary type (lib|exe)
DOTNET_outtype_DEFAULT = lib


$(call PROJ_DeclareVar,DOTNET_outext)
DOTNET_outext_DESC ?= (read-only) Output binary filename extension
DOTNET_outext_DEFAULT = $(if $(filter exe,$(DOTNET_outtype)),exe,dll)


$(call PROJ_DeclareVar,DOTNET_outdir)
DOTNET_outdir_DESC ?= Directory to put output binary file(s) in
DOTNET_outdir_DEFAULT = $(OUT_base)/dotnet

# Tell OUT module to handle the output directory
OUT_all += $(call MAKE_EncodeWord,$(DOTNET_outdir))


$(call PROJ_DeclareVar,DOTNET_outbase_abs)
DOTNET_outbase_abs_DESC ?= (read-only) Final output binary path+filename, no extension
DOTNET_outbase_abs_DEFAULT = $(DOTNET_outdir)/$(DOTNET_outbase)


$(call PROJ_DeclareVar,DOTNET_outfiles)
DOTNET_outfiles_DESC ?= (append-only) Output binary and associated files (list)


$(call PROJ_DeclareVar,DOTNET_outfiles_main)
DOTNET_outfiles_main_DESC ?= (read-only) Primary output binary file
DOTNET_outfiles_main_DEFAULT = \
$(DOTNET_outbase_abs).$(DOTNET_outext)

DOTNET_outfiles += $(call MAKE_EncodeWord,$(DOTNET_outfiles_main))


# Provide dotnet-bin
#
DOTNET_BIN_dir = $(DOTNET_outdir)
DOTNET_BIN_primary = $(call MAKE_DecodeWord,$(notdir $(call MAKE_EncodeWord,$(DOTNET_outfiles_main))))
DOTNET_BIN_all += $(notdir $(DOTNET_outfiles))


# TODO config.xml support
# config.xml -> <bin_main>.config
# bin_all += ...


# TODO: Satellite assembly support?

