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


# CSharp-specific DOTNET_srcs override
DOTNET_srcs_DEFAULT = \
$(if $(DOTNET_srcdir_abs), \
$(filter-out $(DOTNET_excludesrcs), \
$(shell \
find $(call SHELL_Escape,$(DOTNET_srcdir_abs)) -type f -name \*.cs \
| $(SHELL_CLEANPATH) \
| $(SHELL_ENCODEWORD) \
) \
) \
)


$(call PROJ_DeclareVar,DOTNET_CS_defines)
DOTNET_CS_defines_DESC ?= Preprocessor variables to define (list)


$(call PROJ_DeclareVar,DOTNET_CS_debug)
DOTNET_CS_debug_DESC ?= \
Enable debug info compilation and DEBUG preprocessor var? (0|1)
DOTNET_CS_debug_DEFAULT = 1

DOTNET_CS_defines += $(if $(DOTNET_CS_debug),DEBUG)


$(call PROJ_DeclareVar,DOTNET_CS_trace)
DOTNET_CS_trace_DESC ?= Define TRACE preprocessor var? (0|1)
DOTNET_CS_trace_DEFAULT = 1

DOTNET_CS_defines += $(if $(DOTNET_CS_trace),TRACE)


$(call PROJ_DeclareVar,DOTNET_CS_checked)
DOTNET_CS_checked_DESC ?= Enable runtime arithmetic bounds checking? (0|1)
DOTNET_CS_checked_DEFAULT = 1


$(call PROJ_DeclareVar,DOTNET_CS_warn)
DOTNET_CS_warn_DESC ?= Compiler warning level (0-4)
DOTNET_CS_warn_DEFAULT = 4


$(call PROJ_DeclareVar,DOTNET_CS_werror)
DOTNET_CS_werror_DESC ?= Treat compiler warnings as errors? (0|1)
DOTNET_CS_werror_DEFAULT = 1


$(call PROJ_DeclareVar,DOTNET_CS_out_debug)
DOTNET_CS_out_debug_DESC ?= (read-only) Debug information output file
DOTNET_CS_out_debug = \
$(if $(filter mono,$(DOTNET_implementation)),$(if $(DOTNET_srcs_final),$(if $(filter 1,$(DOTNET_CS_debug)),$(DOTNET_outfiles_main).mdb)))$(if $(filter ms,$(DOTNET_implementation)),$(if $(DOTNET_srcs_final),$(if $(filter 1,$(DOTNET_CS_debug)),$(DOTNET_outbase_abs).pdb)))

DOTNET_outfiles += $(call MAKE_EncodeWord,$(DOTNET_CS_out_debug))


# Hook up doxygen
DOXYGEN_srcs += $(DOTNET_srcs)
DOXYGEN_depends += $(call MAKE_EncodeWord,$(DOTNET_outfiles_main))

