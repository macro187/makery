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


CSHARP_trace_DESC := \
Define TRACE preprocessor var?
$(call PROJ_DeclareVar,CSHARP_trace)
CSHARP_trace_OPTIONS = 1 0


CSHARP_checked_DESC := \
Enable runtime arithmetic bounds checking?
$(call PROJ_DeclareVar,CSHARP_checked)
CSHARP_checked_OPTIONS = 1 0


CSHARP_warn_DESC := \
Compiler warning level (0-4)
$(call PROJ_DeclareVar,CSHARP_warn)
CSHARP_warn_OPTIONS = 4 3 2 1 0
CSHARP_warn_VALIDATE = Required


CSHARP_werror_DESC := \
Treat compiler warnings as errors?
$(call PROJ_DeclareVar,CSHARP_werror)
CSHARP_werror_OPTIONS = 1 0


CSHARP_defines_DESC := \
(append-only) Preprocessor variables to define (list)
$(call PROJ_DeclareVar,CSHARP_defines)


CSHARP_compiler_DESC := \
(read-only) CSharp compiler
$(call PROJ_DeclareVar,CSHARP_compiler)
CSHARP_compiler_VALIDATE = Required
CSHARP_compiler = \
$(DOTNETFRAMEWORK_$(call uc,$(DOTNETFRAMEWORK_implementation))_csharp_compiler)


CSHARP_debuginfo_DESC := \
(read-only) Name of debugging information file
$(call PROJ_DeclareVar,CSHARP_debuginfo)
CSHARP_debuginfo = \
$(DOTNETFRAMEWORK_$(call uc,$(DOTNETFRAMEWORK_implementation))_csharp_debuginfo)


# Defines
#
CSHARP_defines += $(if $(filter 1,$(DOTNET_debug)),DEBUG)

CSHARP_defines += $(if $(filter 1,$(CSHARP_trace)),TRACE)

CSHARP_defines += \
$(call uc,$(DOTNET_implementation))

CSHARP_defines += \
$(if $(DOTNETFRAMEWORK_generation),$(foreach gen,$(DOTNETFRAMEWORK_GENERATIONS),$(if $(call gte,$(DOTNETFRAMEWORK_generation),$(gen)),DOTNET$(gen))))


# Hook up srcs-find
#
SRCS_FIND_extension = cs


# Hook up doxygen
#
DOXYGEN_srcs += $(SRCS_files)
DOXYGEN_defines += $(CSHARP_defines)
DOXYGEN_tagprojects += $(foreach p,$(DOTNETREFERENCES_proj),$(if $(PROJ_GetVar,DOXYGEN_tagfile,$(p)),$(p)))

