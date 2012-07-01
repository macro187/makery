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
# Compiler
# ------------------------------------------------------------------------------

$(call PROJ_DeclareVar,DOTNET_CS_compiler)
DOTNET_CS_compiler_DESC ?= Csharp compiler to use
DOTNET_CS_compiler_VALIDATE = Required

DOTNET_CS_compiler_DEFAULT = \
$(DOTNET_$(call uc,$(DOTNET_implementation))_$(DOTNET_generation)_COMPILER_CS)



# ------------------------------------------------------------------------------
# Compilation Options
# ------------------------------------------------------------------------------

$(call PROJ_DeclareVar,DOTNET_CS_defines)
DOTNET_CS_defines_DESC ?= Preprocessor variables to define (list)


# Enable DEBUG define if we're in debug mode
DOTNET_CS_defines += $(if $(filter 1,$(DOTNET_debug)),DEBUG)


$(call PROJ_DeclareVar,DOTNET_CS_trace)
DOTNET_CS_trace_DESC ?= Define TRACE preprocessor var? (0|1)
DOTNET_CS_trace_DEFAULT = 1

DOTNET_CS_defines += $(if $(filter 1,$(DOTNET_CS_trace)),TRACE)


$(call PROJ_DeclareVar,DOTNET_CS_checked)
DOTNET_CS_checked_DESC ?= Enable runtime arithmetic bounds checking? (0|1)
DOTNET_CS_checked_DEFAULT = 1


$(call PROJ_DeclareVar,DOTNET_CS_warn)
DOTNET_CS_warn_DESC ?= Compiler warning level (0-4)
DOTNET_CS_warn_DEFAULT = 4


$(call PROJ_DeclareVar,DOTNET_CS_werror)
DOTNET_CS_werror_DESC ?= Treat compiler warnings as errors? (0|1)
DOTNET_CS_werror_DEFAULT = 1


$(call PROJ_DeclareVar,DOTNET_CS_nostdlib)
DOTNET_CS_nostdlib_DESC ?= Do not reference mscorlib.dll? (0|1)
DOTNET_CS_nostdlib_DEFAULT = 0



# ------------------------------------------------------------------------------
# .NET framework information C# preprocessor constants
#
# So code can adapt to the .NET implementation, generation, etc. in use.
# ------------------------------------------------------------------------------

#
# Implementation
#
# Format: DOTNET_implementation in all-caps (eg. "MS", "MONO", etc.)
#
# See DOTNET_FRAMEWORKS for a full list
#
DOTNET_CS_defines += \
$(call uc,$(DOTNET_implementation))


#
# Generation
#
# Format: DOTNET<XX>
#
# Constants for all generations <= the one in use are defined
#
# See DOTNET_GENERATIONS for a full list
#
DOTNET_CS_defines += \
$(if $(DOTNET_generation),$(foreach gen,$(DOTNET_GENERATIONS),$(if $(call gte,$(DOTNET_generation),$(gen)),DOTNET$(gen))))



# Debug info output file
$(call PROJ_DeclareVar,DOTNET_CS_out_debug)
DOTNET_CS_out_debug_DESC ?= (read-only) Debug information output file
DOTNET_CS_out_debug = \
$(if $(filter mono,$(DOTNET_implementation)),$(if $(filter 1,$(DOTNET_debug)),$(DOTNET_outfiles_main).mdb))$(if $(filter ms,$(DOTNET_implementation)),$(if $(filter 1,$(DOTNET_debug)),$(DOTNET_outbase_abs).pdb))

DOTNET_outfiles += $(call MAKE_EncodeWord,$(DOTNET_CS_out_debug))


# C# language version
$(call PROJ_DeclareVar,DOTNET_CS_version)
DOTNET_CS_version_DESC ?= (read-only) Version of CSharp language in effect
DOTNET_CS_version = $(DOTNET_$(DOTNET_generation)_CSVERSION)


# C# language version compiler switch(es)
$(call PROJ_DeclareVar,DOTNET_CS_versionswitches)
DOTNET_CS_versionswitches_DESC ?= \
(read-only) Compiler switches to set the CSharp language version
DOTNET_CS_versionswitches = \
$(DOTNET_$(call uc,$(DOTNET_implementation))_CSVERSION_$(DOTNET_CS_version)_SWITCHES)


# Look for .cs source files
SRCS_FIND_extension = cs


# Hook up to makery-dotnet-bin
#
DOTNET_BIN_dir = $(DOTNET_outdir)
DOTNET_BIN_primary = $(call MAKE_DecodeWord,$(notdir $(call MAKE_EncodeWord,$(DOTNET_outfiles_main))))
DOTNET_BIN_all += $(notdir $(DOTNET_outfiles))


# Hook up to Doxygen
DOXYGEN_srcs += $(SRCS_files)
DOXYGEN_depends += $(call MAKE_EncodeWord,$(DOTNET_outfiles_main))
DOXYGEN_defines += $(DOTNET_CS_defines)
DOXYGEN_tagprojects += $(DOTNET_projlibs)

