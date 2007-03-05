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


# Sniff csc(s)
#ifneq ($(OS_ISWINDOWS),)

#CSHARP_CSC_11 := \
#$(shell find \
#$(call SHELL_Escape,$(DOTNET_FRAMEWORK_DIR_11)) \
#-maxdepth 1 \
#-type f \
#-name "csc.exe" \
#| $(SHELL_CLEANPATH) \
#)

#CSHARP_CSC_20 := \
#$(shell find \
#$(call SHELL_Escape,$(DOTNET_FRAMEWORK_DIR_20)) \
#-maxdepth 1 \
#-type f \
#-name "csc.exe" \
#| $(SHELL_CLEANPATH) \
#)

#endif

