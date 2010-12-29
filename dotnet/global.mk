# ------------------------------------------------------------------------------
# Copyright (c) 2007, 2008, 2009, 2010
# Ron MacNeil <macro187 AT users DOT sourceforge DOT net>
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
# Frameworks
# ------------------------------------------------------------------------------

DOTNET_FRAMEWORKS := ms mono pnet



# ------------------------------------------------------------------------------
# Framework Generations
# ------------------------------------------------------------------------------

DOTNET_GENERATIONS := 40 35 30 20 11 10



# ------------------------------------------------------------------------------
# C# Language Versions
# ------------------------------------------------------------------------------

DOTNET_CSVERSIONS = 40 30 20 10

DOTNET_40_CSVERSION := 40
DOTNET_35_CSVERSION := 30
DOTNET_30_CSVERSION := 20
DOTNET_20_CSVERSION := 20
DOTNET_11_CSVERSION := 10
DOTNET_10_CSVERSION := 10



# ------------------------------------------------------------------------------
# Command-line path arguments to .NET-generated programs
# ------------------------------------------------------------------------------

ifneq ($(OS_ISCYGWIN)$(OS_ISMSYS),)
DOTNET_ArgPath = \
$(if $(filter ms,$(DOTNET_implementation)),$(call OS_WinPath,$(1)),$(1))
else
DOTNET_ArgPath = $(1)
endif



# ------------------------------------------------------------------------------
# MS
# ------------------------------------------------------------------------------
ifneq ($(OS_ISWINDOWS),)


#
# Frameworks parent directory
#
DOTNET_MS_FRAMEWORKSDIR := $(OS_WINDIR)/Microsoft.NET/Framework

#
# Per-generation framework directories
#
# XXX These will break if more than one subdirectory for a given version exists
# XXX The existence of the subdirectory doesn't guarantee it contains the
#     entire framework

DOTNET_MS_40_FRAMEWORKDIR := \
$(shell find \
$(call SHELL_Escape,$(DOTNET_MS_FRAMEWORKSDIR)) \
-maxdepth 1 \
-type d \
-name "v4.0*" \
| $(SHELL_CLEANPATH) \
)

DOTNET_MS_35_FRAMEWORKDIR := \
$(shell find \
$(call SHELL_Escape,$(DOTNET_MS_FRAMEWORKSDIR)) \
-maxdepth 1 \
-type d \
-name "v3.5*" \
| $(SHELL_CLEANPATH) \
)

DOTNET_MS_30_FRAMEWORKDIR := \
$(shell find \
$(call SHELL_Escape,$(DOTNET_MS_FRAMEWORKSDIR)) \
-maxdepth 1 \
-type d \
-name "v3.0*" \
| $(SHELL_CLEANPATH) \
)

DOTNET_MS_20_FRAMEWORKDIR := \
$(shell find \
$(call SHELL_Escape,$(DOTNET_MS_FRAMEWORKSDIR)) \
-maxdepth 1 \
-type d \
-name "v2.0*" \
| $(SHELL_CLEANPATH) \
)

DOTNET_MS_11_FRAMEWORKDIR := \
$(shell find \
$(call SHELL_Escape,$(DOTNET_MS_FRAMEWORKSDIR)) \
-maxdepth 1 \
-type d \
-name "v1.1*" \
| $(SHELL_CLEANPATH) \
)

DOTNET_MS_10_FRAMEWORKDIR := \
$(shell find \
$(call SHELL_Escape,$(DOTNET_MS_FRAMEWORKSDIR)) \
-maxdepth 1 \
-type d \
-name "v1.0*" \
| $(SHELL_CLEANPATH) \
)


#
# Per-generation C# compilers
#
DOTNET_MS_40_COMPILER_CS := \
$(shell find \
$(call SHELL_Escape,$(DOTNET_MS_40_FRAMEWORKDIR)) \
-name "csc.exe" \
| $(SHELL_CLEANPATH) \
)

DOTNET_MS_35_COMPILER_CS := \
$(shell find \
$(call SHELL_Escape,$(DOTNET_MS_35_FRAMEWORKDIR)) \
-name "csc.exe" \
| $(SHELL_CLEANPATH) \
)

DOTNET_MS_30_COMPILER_CS := \
$(shell find \
$(call SHELL_Escape,$(DOTNET_MS_30_FRAMEWORKDIR)) \
-name "csc.exe" \
| $(SHELL_CLEANPATH) \
)

DOTNET_MS_20_COMPILER_CS := \
$(shell find \
$(call SHELL_Escape,$(DOTNET_MS_20_FRAMEWORKDIR)) \
-name "csc.exe" \
| $(SHELL_CLEANPATH) \
)

DOTNET_MS_11_COMPILER_CS := \
$(shell find \
$(call SHELL_Escape,$(DOTNET_MS_11_FRAMEWORKDIR)) \
-name "csc.exe" \
| $(SHELL_CLEANPATH) \
)

DOTNET_MS_10_COMPILER_CS := \
$(shell find \
$(call SHELL_Escape,$(DOTNET_MS_10_FRAMEWORKDIR)) \
-name "csc.exe" \
| $(SHELL_CLEANPATH) \
)


endif



# ------------------------------------------------------------------------------
# Mono
# ------------------------------------------------------------------------------

DOTNET_MONO := $(shell which mono 2>&-)
DOTNET_MCS := $(shell which mcs 2>&-)
DOTNET_GMCS := $(shell which gmcs 2>&-)
DOTNET_DMCS := $(shell which dmcs 2>&-)

DOTNET_MONO_40_COMPILER_CS := $(DOTNET_DMCS)
DOTNET_MONO_35_COMPILER_CS := $(DOTNET_GMCS)
DOTNET_MONO_30_COMPILER_CS := $(DOTNET_GMCS)
DOTNET_MONO_20_COMPILER_CS := $(DOTNET_GMCS)
DOTNET_MONO_11_COMPILER_CS := $(DOTNET_MCS)
DOTNET_MONO_10_COMPILER_CS := $(DOTNET_MCS)

DOTNET_MONO_CSVERSION_40_SWITCHES :=
DOTNET_MONO_CSVERSION_30_SWITCHES := -langversion:3
DOTNET_MONO_CSVERSION_20_SWITCHES := -langversion:ISO-2
DOTNET_MONO_CSVERSION_10_SWITCHES := -langversion:ISO-1


# ------------------------------------------------------------------------------
# Pnet
# ------------------------------------------------------------------------------

DOTNET_ILRUN := $(shell which ilrun 2>&-)
DOTNET_CSCC := $(shell which cscc 2>&-)

# no support for .NET generation >= 2.0
DOTNET_PNET_11_COMPILER_CS := $(DOTNET_CSCC)
DOTNET_PNET_10_COMPILER_CS := $(DOTNET_CSCC)

