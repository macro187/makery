# ------------------------------------------------------------------------------
# Copyright (c) 2007 Ron MacNeil <macro187 AT users DOT sourceforge DOT net>
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
# Frameworks, versions, availability
# ------------------------------------------------------------------------------

# Overall types of frameworks
DOTNET_FRAMEWORKS := ms mono pnet


# Sniff frameworks on Windows
ifneq ($(OS_ISWINDOWS),)


DOTNET_FRAMEWORKS_DIR := $(OS_WINDIR)/Microsoft.NET/Framework

# XXX: These will break if more than one dir for a given ver exists

# Location of 1.1 framework
DOTNET_FRAMEWORK_DIR_11 := \
$(shell find \
$(call SHELL_Escape,$(DOTNET_FRAMEWORKS_DIR)) \
-maxdepth 1 \
-type d \
-name "v1.1*" \
| $(SHELL_CLEANPATH) \
)

# Location of 2.0 framework
DOTNET_FRAMEWORK_DIR_20 := \
$(shell find \
$(call SHELL_Escape,$(DOTNET_FRAMEWORKS_DIR)) \
-maxdepth 1 \
-type d \
-name "v2.0*" \
| $(SHELL_CLEANPATH) \
)

# TODO Sniff out the 3.0 and 3.5 frameworks as required


endif

