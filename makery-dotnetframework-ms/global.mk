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


DOTNETFRAMEWORK_MS_GENERATIONS_DESC ?= \
All possible Microsoft .NET generations
MAKERY_GLOBALS += DOTNETFRAMEWORK_MS_GENERATIONS
DOTNETFRAMEWORK_MS_GENERATIONS := 46 45 40 35 30 20 11 10


ifdef SYSTEM_ISWINDOWS


DOTNETFRAMEWORK_MS_DIR_DESC ?= \
Directory that may contain .NET frameworks
MAKERY_GLOBALS += DOTNETFRAMEWORK_MS_DIR
DOTNETFRAMEWORK_MS_DIR := $(SYSTEM_WINDIR)/Microsoft.NET/Framework64


DOTNETFRAMEWORK_MS_DIR_46_DESC ?= \
Directory that may contain .NET Framework v4.6.x
MAKERY_GLOBALS += DOTNETFRAMEWORK_MS_DIR_46
DOTNETFRAMEWORK_MS_DIR_46 :=

DOTNETFRAMEWORK_MS_DIR_45_DESC ?= \
Directory that may contain .NET Framework v4.5.x
MAKERY_GLOBALS += DOTNETFRAMEWORK_MS_DIR_45
DOTNETFRAMEWORK_MS_DIR_45 :=

DOTNETFRAMEWORK_MS_DIR_40_DESC ?= \
Directory that may contain .NET Framework v4.0
MAKERY_GLOBALS += DOTNETFRAMEWORK_MS_DIR_40
DOTNETFRAMEWORK_MS_DIR_40 := $(call SYSTEM_FindDir,$(DOTNETFRAMEWORK_MS_DIR)/v4.0*)

DOTNETFRAMEWORK_MS_DIR_35_DESC ?= \
Directory that may contain .NET Framework v3.5
MAKERY_GLOBALS += DOTNETFRAMEWORK_MS_DIR_35
DOTNETFRAMEWORK_MS_DIR_35 := $(call SYSTEM_FindDir,$(DOTNETFRAMEWORK_MS_DIR)/v3.5*)

DOTNETFRAMEWORK_MS_DIR_30_DESC ?= \
Directory that may contain .NET Framework v3.0
MAKERY_GLOBALS += DOTNETFRAMEWORK_MS_DIR_30
DOTNETFRAMEWORK_MS_DIR_30 := $(call SYSTEM_FindDir,$(DOTNETFRAMEWORK_MS_DIR)/v3.0*)

DOTNETFRAMEWORK_MS_DIR_20_DESC ?= \
Directory that may contain .NET Framework v2.0
MAKERY_GLOBALS += DOTNETFRAMEWORK_MS_DIR_20
DOTNETFRAMEWORK_MS_DIR_20 := $(call SYSTEM_FindDir,$(DOTNETFRAMEWORK_MS_DIR)/v2.0*)

DOTNETFRAMEWORK_MS_DIR_11_DESC ?= \
Directory that may contain .NET Framework v1.1
MAKERY_GLOBALS += DOTNETFRAMEWORK_MS_DIR_11
DOTNETFRAMEWORK_MS_DIR_11 := $(call SYSTEM_FindDir,$(DOTNETFRAMEWORK_MS_DIR)/v1.1*)

DOTNETFRAMEWORK_MS_DIR_10_DESC ?= \
Directory that may contain .NET Framework v1.0
MAKERY_GLOBALS += DOTNETFRAMEWORK_MS_DIR_10
DOTNETFRAMEWORK_MS_DIR_10 := $(call SYSTEM_FindDir,$(DOTNETFRAMEWORK_MS_DIR)/v1.0*)

DOTNETFRAMEWORK_MS_CSC_46_DESC ?= \
.NET Framework v4.6.x CSharp compiler
MAKERY_GLOBALS += DOTNETFRAMEWORK_MS_CSC_46
DOTNETFRAMEWORK_MS_CSC_46 :=

DOTNETFRAMEWORK_MS_CSC_45_DESC ?= \
.NET Framework v4.5.x CSharp compiler
MAKERY_GLOBALS += DOTNETFRAMEWORK_MS_CSC_45
DOTNETFRAMEWORK_MS_CSC_45 :=

DOTNETFRAMEWORK_MS_CSC_40_DESC ?= \
.NET Framework v4.0 CSharp compiler
MAKERY_GLOBALS += DOTNETFRAMEWORK_MS_CSC_40
DOTNETFRAMEWORK_MS_CSC_40 :=
ifneq ($(DOTNETFRAMEWORK_MS_DIR_40),)
DOTNETFRAMEWORK_MS_CSC_40 := $(call SYSTEM_FindFile,$(DOTNETFRAMEWORK_MS_DIR_40)/csc.exe)
endif

DOTNETFRAMEWORK_MS_CSC_35_DESC ?= \
.NET Framework v3.5 CSharp compiler
MAKERY_GLOBALS += DOTNETFRAMEWORK_MS_CSC_35
DOTNETFRAMEWORK_MS_CSC_35 :=
ifneq ($(DOTNETFRAMEWORK_MS_DIR_35),)
DOTNETFRAMEWORK_MS_CSC_35 := $(call SYSTEM_FindFile,$(DOTNETFRAMEWORK_MS_DIR_35)/csc.exe)
endif

DOTNETFRAMEWORK_MS_CSC_30_DESC ?= \
.NET Framework v3.0 CSharp compiler
MAKERY_GLOBALS += DOTNETFRAMEWORK_MS_CSC_30
DOTNETFRAMEWORK_MS_CSC_30 :=
ifneq ($(DOTNETFRAMEWORK_MS_DIR_30),)
DOTNETFRAMEWORK_MS_CSC_30 := $(call SYSTEM_FindFile,$(DOTNETFRAMEWORK_MS_DIR_30)/csc.exe)
endif

DOTNETFRAMEWORK_MS_CSC_20_DESC ?= \
.NET Framework v2.0 CSharp compiler
MAKERY_GLOBALS += DOTNETFRAMEWORK_MS_CSC_20
DOTNETFRAMEWORK_MS_CSC_20 :=
ifneq ($(DOTNETFRAMEWORK_MS_DIR_20),)
DOTNETFRAMEWORK_MS_CSC_20 := $(call SYSTEM_FindFile,$(DOTNETFRAMEWORK_MS_DIR_20)/csc.exe)
endif

DOTNETFRAMEWORK_MS_CSC_11_DESC ?= \
.NET Framework v1.1 CSharp compiler
MAKERY_GLOBALS += DOTNETFRAMEWORK_MS_CSC_11
DOTNETFRAMEWORK_MS_CSC_11 :=
ifneq ($(DOTNETFRAMEWORK_MS_DIR_11),)
DOTNETFRAMEWORK_MS_CSC_11 := $(call SYSTEM_FindFile,$(DOTNETFRAMEWORK_MS_DIR_11)/csc.exe)
endif

DOTNETFRAMEWORK_MS_CSC_10_DESC ?= \
.NET Framework v1.0 CSharp compiler
MAKERY_GLOBALS += DOTNETFRAMEWORK_MS_CSC_10
DOTNETFRAMEWORK_MS_CSC_10 :=
ifneq ($(DOTNETFRAMEWORK_MS_DIR_10),)
DOTNETFRAMEWORK_MS_CSC_10 := $(call SYSTEM_FindFile,$(DOTNETFRAMEWORK_MS_DIR_10)/csc.exe)
endif

DOTNETFRAMEWORK_4_RELEASE_DESC ?= \
.NET Framework v4 release code from registry
MAKERY_GLOBALS += DOTNETFRAMEWORK_4_RELEASE
DOTNETFRAMEWORK_4_RELEASE := \
$(strip $(call MAKE_Shell,reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" -v Release 2>/dev/null | grep 0x | tr -s ' ' | cut -d' ' -f4))

# 378389 378675 378758 379893
ifneq ($(filter 0x5c615 0x5c733 0x5c786 0x5cbf5,$(DOTNETFRAMEWORK_4_RELEASE)),)
DOTNETFRAMEWORK_MS_DIR_45 := $(DOTNETFRAMEWORK_MS_DIR_40)
DOTNETFRAMEWORK_MS_CSC_45 := $(DOTNETFRAMEWORK_MS_CSC_40)
DOTNETFRAMEWORK_MS_DIR_40 :=
DOTNETFRAMEWORK_MS_CSC_40 :=
# 393295 393297 394254 394271 394747 394748
else ifneq ($(filter 0x6004f 0x60051 0x6040e 0x6041f 0x605fb 0x605fc,$(DOTNETFRAMEWORK_4_RELEASE)),)
DOTNETFRAMEWORK_MS_DIR_46 := $(DOTNETFRAMEWORK_MS_DIR_40)
DOTNETFRAMEWORK_MS_CSC_46 := $(DOTNETFRAMEWORK_MS_CSC_40)
DOTNETFRAMEWORK_MS_DIR_40 :=
DOTNETFRAMEWORK_MS_CSC_40 :=
endif


endif

