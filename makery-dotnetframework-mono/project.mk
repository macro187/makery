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


# Add Mono to list of .NET implemenetations
#
DOTNETFRAMEWORK_implementation_OPTIONS += mono

# ...and mask if unavailable
DOTNETFRAMEWORK_implementation_MASK += \
$(if $(DOTNETFRAMEWORK_MONO_MONO),,mono)


# Add Mono generations to list
#
DOTNETFRAMEWORK_generation_OPTIONS += $(DOTNETFRAMEWORK_MONO_GENERATIONS)

# ...mask those not supported by Mono
DOTNETFRAMEWORK_generation_MASK += \
$(if $(filter mono,$(DOTNETFRAMEWORK_implementation)),$(filter-out $(DOTNETFRAMEWORK_MONO_GENERATIONS),$(DOTNETFRAMEWORK_generation_OPTIONS)))

# ...and mask those not available
DOTNETFRAMEWORK_generation_MASK += \
$(if $(filter mono,$(DOTNETFRAMEWORK_implementation)),$(foreach gen,$(DOTNETFRAMEWORK_MONO_GENERATIONS),$(if $(DOTNETFRAMEWORK_MONO_MCS_$(gen)),,$(gen))))


DOTNETFRAMEWORK_MONO_exec_DESC := \
Command to run a .NET program using Mono
$(call PROJ_DeclareVar,DOTNETFRAMEWORK_MONO_exec)

DOTNETFRAMEWORK_MONO_exec = \
$(call SYSTEM_ShellEscape,$(DOTNETFRAMEWORK_MONO_MONO))

DOTNETFRAMEWORK_MONO_exec += \
$(if $(filter 1,$(DOTNETFRAMEWORK_debug)),--debug)

DOTNETFRAMEWORK_MONO_exec += \
$(if $(filter 1,$(DOTNETFRAMEWORK_optimize)),--optimize,--optimize=-all)


DOTNETFRAMEWORK_MONO_csharp_compiler_DESC := \
Mono CSharp compiler
$(call PROJ_DeclareVar,DOTNETFRAMEWORK_MONO_csharp_compiler)
DOTNETFRAMEWORK_MONO_csharp_compiler = \
$(DOTNETFRAMEWORK_MONO_MCS_$(DOTNETFRAMEWORK_generation))


DOTNETFRAMEWORK_MONO_csharp_debuginfo_DESC := \
Mono CSharp debug info output file
$(call PROJ_DeclareVar,DOTNETFRAMEWORK_MONO_csharp_debuginfo)
DOTNETFRAMEWORK_MONO_csharp_debuginfo = \
$(if $(filter 1,$(DOTNET_debug)),$(DOTNETASSEMBLY_primary).mdb)


