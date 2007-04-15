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


# ------------------------------------------------------------------------------
# Configs
# ------------------------------------------------------------------------------

$(call CONFIG_DeclareField,DOTNET_generation)
DOTNET_generation_DESC ?= .NET generation
DOTNET_generation_ALL = 20 11 10


$(call CONFIG_DeclareField,DOTNET_implementation)
DOTNET_implementation_DESC ?= .NET implementation
DOTNET_implementation_ALL = ms mono pnet

DOTNET_implementation_MASK_MSWINONLY = $(if $(OS_ISWINDOWS),,ms)
DOTNET_implementation_MASK_MSWINONLY_DESC ?= MS.NET only available on Windows
DOTNET_implementation_MASKS += MSWINONLY

DOTNET_implementation_MASK_NOTFOUND = $(if $(shell which mono),,mono)
DOTNET_implementation_MASK_NOTFOUND += $(if $(shell which ilrun),,pnet)
# TODO actually make sure ms is available if on windows
DOTNET_implementation_MASK_NOTFOUND_DESC ?= Not found on system
DOTNET_implementation_MASKS += NOTFOUND

DOTNET_implementation_MASK_PNETNO20 = \
$(if $(filter 20,$(DOTNET_generation)),pnet)
DOTNET_implementation_MASK_PNETNO20_DESC ?= PNet can not do .NET 2.0 (or newer)
DOTNET_implementation_MASKS += PNETNO20


# TODO DOTNET_version  (version of framework implementation)



# ------------------------------------------------------------------------------
# Vars
# ------------------------------------------------------------------------------

$(call PROJ_DeclareVar,DOTNET_exec)
DOTNET_exec_DESC ?= Program used to run .NET binaries
DOTNET_exec_DEFAULT = $(if $(filter $(DOTNET_implementation),mono),mono --debug)
DOTNET_exec_DEFAULT += $(if $(filter $(DOTNET_implementation),pnet),ilrun)


$(call PROJ_DeclareVar,DOTNET_namespace)
DOTNET_namespace_DESC ?= Projects root .NET namespace
DOTNET_namespace_DEFAULT = \
$(call MAKE_DecodeWord,$(notdir $(call MAKE_EncodeWord,$(PROJ_dir))))


# (EXPERIMENTAL)
# Source code preprocessor pipeline
#   To add a preprocessing step:
#   - YOURMOD_srcvarname := $(lastword $(DOTNET_srcs_pipeline))
#   - YOURMOD_srcs = $($(YOURMOD_srcvarname))
#   - YOURMOD_outfiles = ...
#   - DOTNET_srcs_pipeline += $(YOURMOD_outfiles)
#$(call PROJ_DeclareVar,DOTNET_srcs_pipeline)
#DOTNET_srcs_pipeline_DESC ?= \
#Names of srcs variables for each step of preprocessing pipeline (list)
#DOTNET_srcs_pipeline := DOTNET_srcs


#$(call PROJ_DeclareVar,DOTNET_srcs_final)
#DOTNET_srcs_final_DESC ?= Final preprocessed source code files (list)
#DOTNET_srcs_final_DEFAULT = $($(lastword $(DOTNET_srcs_pipeline)))


$(call PROJ_DeclareVar,DOTNET_resources)
DOTNET_resources_DESC ?= Resource files to embed into the output binary (list)


$(call PROJ_DeclareVar,DOTNET_libs)
DOTNET_libs_DESC ?= .NET libraries (.dll files) to link to (list)
# Include extension and, if not framework-provided, full path


$(call PROJ_DeclareVar,DOTNET_projlibs)
DOTNET_projlibs_DESC ?= \
Relative paths to .NET library projects to build and link to (list)
# Automatically added to PROJ_required for you


$(call PROJ_DeclareVar,DOTNET_projlibs_abs)
DOTNET_projlibs_abs_DESC ?= \
(read-only) Absolute paths to .NET library projects to build and link to (list)
DOTNET_projlibs_abs_DEFAULT = \
$(foreach proj,$(DOTNET_projlibs),$(call MAKE_EncodeWord,$(call SHELL_RelDirToAbs,$(call MAKE_DecodeWord,$(proj)),$(PROJ_dir))))

PROJ_required += $(DOTNET_projlibs_abs)


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
DOTNET_outdir_DEFAULT = $(OUTDIRS_base)/dotnet

# Tell OUTDIRS module to handle the output directory
OUTDIRS_all += $(call MAKE_EncodeWord,$(DOTNET_outdir))


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


# TODO config.xml support
# config.xml -> <bin_main>.config
# bin_all += ...


# TODO: Satellite assembly support?

