# ------------------------------------------------------------------------------
# Copyright (c) 2007, 2008, 2009
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
# Detect available MS frameworks
# ------------------------------------------------------------------------------
ifneq ($(OS_ISWINDOWS),)


DOTNET_MS_FRAMEWORK_GENERATIONS := 35 30 20 11 10

DOTNET_MS_FRAMEWORKS_DIR := $(OS_WINDIR)/Microsoft.NET/Framework

# XXX These will break if more than one subdirectory for a given version exists
# XXX The existence of the subdirectory doesn't guarantee it contains the entire framework

DOTNET_MS_FRAMEWORK_35 := \
$(shell find \
$(call SHELL_Escape,$(DOTNET_MS_FRAMEWORKS_DIR)) \
-maxdepth 1 \
-type d \
-name "v3.5*" \
| $(SHELL_CLEANPATH) \
)

DOTNET_MS_FRAMEWORK_30 := \
$(shell find \
$(call SHELL_Escape,$(DOTNET_MS_FRAMEWORKS_DIR)) \
-maxdepth 1 \
-type d \
-name "v3.0*" \
| $(SHELL_CLEANPATH) \
)

DOTNET_MS_FRAMEWORK_20 := \
$(shell find \
$(call SHELL_Escape,$(DOTNET_MS_FRAMEWORKS_DIR)) \
-maxdepth 1 \
-type d \
-name "v2.0*" \
| $(SHELL_CLEANPATH) \
)

DOTNET_MS_FRAMEWORK_11 := \
$(shell find \
$(call SHELL_Escape,$(DOTNET_MS_FRAMEWORKS_DIR)) \
-maxdepth 1 \
-type d \
-name "v1.1*" \
| $(SHELL_CLEANPATH) \
)

DOTNET_MS_FRAMEWORK_10 := \
$(shell find \
$(call SHELL_Escape,$(DOTNET_MS_FRAMEWORKS_DIR)) \
-maxdepth 1 \
-type d \
-name "v1.0*" \
| $(SHELL_CLEANPATH) \
)


endif

