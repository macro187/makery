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


# Add MS .NET to the list of implementation options
#
DOTNETFRAMEWORK_implementation_OPTIONS += ms

# ...and mask if unavailable
DOTNETFRAMEWORK_implementation_MASK += \
$(if $(strip $(foreach gen,$(DOTNETFRAMEWORK_MS_GENERATIONS),$(DOTNETFRAMEWORK_MS_CSC_$(gen)))),,ms)


# Add MS .NET generations
#
DOTNETFRAMEWORK_generation_OPTIONS += $(DOTNETFRAMEWORK_MS_GENERATIONS)

# ...mask those not supported
DOTNETFRAMEWORK_generation_MASK += \
$(if $(filter ms,$(DOTNETFRAMEWORK_implementation)),$(filter-out $(DOTNETFRAMEWORK_MS_GENERATIONS),$(DOTNETFRAMEWORK_generation_OPTIONS)))

# ...and mask those not available
DOTNETFRAMEWORK_generation_MASK += \
$(if $(filter ms,$(DOTNETFRAMEWORK_implementation)),$(foreach gen,$(DOTNETFRAMEWORK_MS_GENERATIONS),$(if $(DOTNETFRAMEWORK_MS_CSC_$(gen)),,$(gen))))


DOTNETFRAMEWORK_MS_csharp_compiler_DESC := \
Microsoft CSharp compiler
$(call PROJ_DeclareVar,DOTNETFRAMEWORK_MS_csharp_compiler)
DOTNETFRAMEWORK_MS_csharp_compiler = \
$(DOTNETFRAMEWORK_MS_CSC_$(DOTNETFRAMEWORK_generation))


DOTNETFRAMEWORK_MS_csharp_debuginfo_DESC := \
Microsoft CSharp debug info output file
$(call PROJ_DeclareVar,DOTNETFRAMEWORK_MS_csharp_debuginfo)
DOTNETFRAMEWORK_MS_csharp_debuginfo = \
$(if $(filter 1,$(DOTNET_debug)),$(call MAKE_DecodeWord,$(basename $(call MAKE_EncodeWord,$(DOTNETASSEMBLY_primary)))).pdb)


