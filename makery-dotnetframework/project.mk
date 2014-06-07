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


DOTNETFRAMEWORK_implementation_DESC ?= \
.NET implementation to use
$(call PROJ_DeclareVar,DOTNETFRAMEWORK_implementation)
DOTNETFRAMEWORK_implementation_VALIDATE = Required
DOTNETFRAMEWORK_implementation_DEFAULT = \
$(firstword $(DOTNETFRAMEWORK_implementation_AVAIL))


DOTNETFRAMEWORK_generation_DESC ?= \
.NET generation to use
$(call PROJ_DeclareVar,DOTNETFRAMEWORK_generation)
DOTNETFRAMEWORK_generation_VALIDATE += Required
DOTNETFRAMEWORK_generation_DEFAULT = \
$(lastword $(sort $(DOTNETFRAMEWORK_generation_AVAIL)))


DOTNETFRAMEWORK_debug_DESC ?= \
Enable debug execution of .NET programs?
$(call PROJ_DeclareVar,DOTNETFRAMEWORK_debug)
DOTNETFRAMEWORK_debug_OPTIONS = 1 0
DOTNETFRAMEWORK_debug_DEFAULT = 1


DOTNETFRAMEWORK_optimize_DESC ?= \
Enable optimized execution of .NET programs?
$(call PROJ_DeclareVar,DOTNETFRAMEWORK_optimize)
DOTNETFRAMEWORK_optimize_OPTIONS = 1 0
DOTNETFRAMEWORK_optimize_DEFAULT = \
$(if $(filter 1,$(DOTNETFRAMEWORK_debug)),0,1)


DOTNETFRAMEWORK_exec_DESC ?= \
(read-only) Program used to run .NET binaries
$(call PROJ_DeclareVar,DOTNETFRAMEWORK_exec)
DOTNETFRAMEWORK_exec = \
$(DOTNETFRAMEWORK_$(call uc,$(DOTNETFRAMEWORK_implementation))_exec)


