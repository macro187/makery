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


DOTNETFRAMEWORK_MS_GENERATIONS := 45 40 35 30 20 11 10


ifdef SYSTEM_ISWINDOWS


DOTNETFRAMEWORK_MS_DIR := $(SYSTEM_WINDIR)/Microsoft.NET/Framework


DOTNETFRAMEWORK_MS_DIR_40 := \
$(call MAKE_Shell,find \
$(call SYSTEM_ShellEscape,$(DOTNETFRAMEWORK_MS_DIR)) \
-maxdepth 1 \
-type d \
-name "v4.0*" \
| $(SYSTEM_SHELL_CLEANPATH) \
)

DOTNETFRAMEWORK_MS_DIR_45 := \
$(DOTNETFRAMEWORK_MS_DIR_40)

DOTNETFRAMEWORK_MS_DIR_35 := \
$(call MAKE_Shell,find \
$(call SYSTEM_ShellEscape,$(DOTNETFRAMEWORK_MS_DIR)) \
-maxdepth 1 \
-type d \
-name "v3.5*" \
| $(SYSTEM_SHELL_CLEANPATH) \
)

DOTNETFRAMEWORK_MS_DIR_30 := \
$(call MAKE_Shell,find \
$(call SYSTEM_ShellEscape,$(DOTNETFRAMEWORK_MS_DIR)) \
-maxdepth 1 \
-type d \
-name "v3.0*" \
| $(SYSTEM_SHELL_CLEANPATH) \
)

DOTNETFRAMEWORK_MS_DIR_20 := \
$(call MAKE_Shell,find \
$(call SYSTEM_ShellEscape,$(DOTNETFRAMEWORK_MS_DIR)) \
-maxdepth 1 \
-type d \
-name "v2.0*" \
| $(SYSTEM_SHELL_CLEANPATH) \
)

DOTNETFRAMEWORK_MS_DIR_11 := \
$(call MAKE_Shell,find \
$(call SYSTEM_ShellEscape,$(DOTNETFRAMEWORK_MS_DIR)) \
-maxdepth 1 \
-type d \
-name "v1.1*" \
| $(SYSTEM_SHELL_CLEANPATH) \
)

DOTNETFRAMEWORK_MS_DIR_10 := \
$(call MAKE_Shell,find \
$(call SYSTEM_ShellEscape,$(DOTNETFRAMEWORK_MS_DIR)) \
-maxdepth 1 \
-type d \
-name "v1.0*" \
| $(SYSTEM_SHELL_CLEANPATH) \
)


DOTNETFRAMEWORK_MS_CSC_40 :=
ifneq ($(DOTNETFRAMEWORK_MS_DIR_40),)
DOTNETFRAMEWORK_MS_CSC_40 := \
$(call MAKE_Shell,find \
$(call SYSTEM_ShellEscape,$(DOTNETFRAMEWORK_MS_DIR_40)) \
-maxdepth 1 \
-name "csc.exe" \
| $(SYSTEM_SHELL_CLEANPATH) \
)
endif

DOTNETFRAMEWORK_MS_CSC_45 := \
$(DOTNETFRAMEWORK_MS_CSC_40)

DOTNETFRAMEWORK_MS_CSC_35 :=
ifneq ($(DOTNETFRAMEWORK_MS_DIR_35),)
DOTNETFRAMEWORK_MS_CSC_35 := \
$(call MAKE_Shell,find \
$(call SYSTEM_ShellEscape,$(DOTNETFRAMEWORK_MS_DIR_35)) \
-maxdepth 1 \
-name "csc.exe" \
| $(SYSTEM_SHELL_CLEANPATH) \
)
endif

DOTNETFRAMEWORK_MS_CSC_30 :=
ifneq ($(DOTNETFRAMEWORK_MS_DIR_30),)
DOTNETFRAMEWORK_MS_CSC_30 := \
$(call MAKE_Shell,find \
$(call SYSTEM_ShellEscape,$(DOTNETFRAMEWORK_MS_DIR_30)) \
-maxdepth 1 \
-name "csc.exe" \
| $(SYSTEM_SHELL_CLEANPATH) \
)
endif

DOTNETFRAMEWORK_MS_CSC_20 :=
ifneq ($(DOTNETFRAMEWORK_MS_DIR_20),)
DOTNETFRAMEWORK_MS_CSC_20 := \
$(call MAKE_Shell,find \
$(call SYSTEM_ShellEscape,$(DOTNETFRAMEWORK_MS_DIR_20)) \
-maxdepth 1 \
-name "csc.exe" \
| $(SYSTEM_SHELL_CLEANPATH) \
)
endif

DOTNETFRAMEWORK_MS_CSC_11 :=
ifneq ($(DOTNETFRAMEWORK_MS_DIR_11),)
DOTNETFRAMEWORK_MS_CSC_11 := \
$(call MAKE_Shell,find \
$(call SYSTEM_ShellEscape,$(DOTNETFRAMEWORK_MS_DIR_11)) \
-maxdepth 1 \
-name "csc.exe" \
| $(SYSTEM_SHELL_CLEANPATH) \
)
endif

DOTNETFRAMEWORK_MS_CSC_10 :=
ifneq ($(DOTNETFRAMEWORK_MS_DIR_10),)
DOTNETFRAMEWORK_MS_CSC_10 := \
$(call MAKE_Shell,find \
$(call SYSTEM_ShellEscape,$(DOTNETFRAMEWORK_MS_DIR_10)) \
-maxdepth 1 \
-name "csc.exe" \
| $(SYSTEM_SHELL_CLEANPATH) \
)
endif


DOTNETFRAMEWORK_HAVE_45 := \
$(if $(strip $(call MAKE_Shell,reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client" -v Version 2>/dev/null)),1)

ifeq ($(DOTNETFRAMEWORK_HAVE_45),)
DOTNETFRAMEWORK_MS_DIR_45 :=
DOTNETFRAMEWORK_MS_CSC_45 :=
endif


endif

