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


DOTNETFRAMEWORK_MONO_GENERATIONS := 46 45 40


DOTNETFRAMEWORK_MONO_MONO := $(strip $(call MAKE_Shell,which mono 2>&-))
DOTNETFRAMEWORK_MONO_MCS := $(strip $(call MAKE_Shell,which mcs 2>&-))


ifdef DOTNETFRAMEWORK_MONO_MCS
DOTNETFRAMEWORK_MONO_MCS_VERSION := $(strip $(call MAKE_Shell,mcs --version))
endif


#
# Mono v4.4 or later => .NET 4.6
# Mono v4.0 through v4.3 => .NET 4.5
#
ifneq ($(findstring version 4.,$(DOTNETFRAMEWORK_MONO_MCS_VERSION)),)
DOTNETFRAMEWORK_MONO_MCS_46 := $(DOTNETFRAMEWORK_MONO_MCS)
endif
ifneq ($(findstring version 4.0.,$(DOTNETFRAMEWORK_MONO_MCS_VERSION)),)
DOTNETFRAMEWORK_MONO_MCS_46 :=
DOTNETFRAMEWORK_MONO_MCS_45 := $(DOTNETFRAMEWORK_MONO_MCS)
endif
ifneq ($(findstring version 4.1.,$(DOTNETFRAMEWORK_MONO_MCS_VERSION)),)
DOTNETFRAMEWORK_MONO_MCS_46 :=
DOTNETFRAMEWORK_MONO_MCS_45 := $(DOTNETFRAMEWORK_MONO_MCS)
endif
ifneq ($(findstring version 4.2.,$(DOTNETFRAMEWORK_MONO_MCS_VERSION)),)
DOTNETFRAMEWORK_MONO_MCS_46 :=
DOTNETFRAMEWORK_MONO_MCS_45 := $(DOTNETFRAMEWORK_MONO_MCS)
endif
ifneq ($(findstring version 4.3.,$(DOTNETFRAMEWORK_MONO_MCS_VERSION)),)
DOTNETFRAMEWORK_MONO_MCS_46 :=
DOTNETFRAMEWORK_MONO_MCS_45 := $(DOTNETFRAMEWORK_MONO_MCS)
endif

#
# Mono v3.x => .NET 4.5
#
ifneq ($(findstring version 3.,$(DOTNETFRAMEWORK_MONO_MCS_VERSION)),)
DOTNETFRAMEWORK_MONO_MCS_45 := $(DOTNETFRAMEWORK_MONO_MCS)
endif

#
# Mono v2.10 or later => .NET 4.0
#
ifneq ($(findstring version 2.10,$(DOTNETFRAMEWORK_MONO_MCS_VERSION)),)
DOTNETFRAMEWORK_MONO_MCS_40 := $(DOTNETFRAMEWORK_MONO_MCS)
endif

