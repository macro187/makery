# ------------------------------------------------------------------------------
# Copyright (c) 2012
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


DOTNETFRAMEWORK_implementation_OPTIONS += pnet

DOTNETFRAMEWORK_implementation_MASK += \
$(if $(DOTNETFRAMEWORK_PNET_ILRUN),,pnet)


DOTNETFRAMEWORK_generation_OPTIONS += $(DOTNETFRAMEWORK_PNET_GENERATIONS)

# ...mask those not supported
DOTNETFRAMEWORK_generation_MASK += \
$(if $(filter pnet,$(DOTNETFRAMEWORK_implementation)),$(filter-out $(DOTNETFRAMEWORK_PNET_GENERATIONS),$(DOTNETFRAMEWORK_generation_OPTIONS)))

# ...and mask those not available
DOTNETFRAMEWORK_generation_MASK += \
$(if $(filter pnet,$(DOTNETFRAMEWORK_implementation)),$(if $(DOTNETFRAMEWORK_PNET_CSCC),,$(DOTNETFRAMEWORK_PNET_GENERATIONS)))


DOTNETFRAMEWORK_PNET_exec_DESC := \
Command to run a .NET program using Portable.NET
$(call PROJ_DeclareVar,DOTNETFRAMEWORK_PNET_exec)
DOTNETFRAMEWORK_PNET_exec = \
$(call SYSTEM_ShellEscape,$(DOTNETFRAMEWORK_PNET_ILRUN))


DOTNETFRAMEWORK_PNET_csharp_compiler_DESC := \
Portable.NET CSharp compiler
$(call PROJ_DeclareVar,DOTNETFRAMEWORK_PNET_csharp_compiler)
DOTNETFRAMEWORK_PNET_csharp_compiler = \
$(DOTNETFRAMEWORK_PNET_CSCC)


