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
# Operating system information
# ------------------------------------------------------------------------------

OS_NAME := $(shell uname -s)
OS_ISWINDOWS := $(findstring Windows,$(OS_NAME))$(findstring CYGWIN,$(OS_NAME))
OS_ISCYGWIN := $(findstring CYGWIN,$(OS_NAME))


# ------------------------------------------------------------------------------
# Windows-only stuff
# ------------------------------------------------------------------------------
ifneq ($(OS_ISWINDOWS),)

# Windows directory
OS_WINDIR := $(call MAKE_CleanPath,$(windir))
ifeq ($(OS_WINDIR),)
OS_WINDIR := $(call MAKE_CleanPath,$(WINDIR))
endif
ifeq ($(OS_WINDIR),)
$(error windir environment variable is not set, unable to determine OS_WINDIR)
endif

endif


# Convert a slash-based path to a Windows backslash-based one, for use when
# calling certain Windows-based programs that can't handle forward-slash paths
# $1 - A slash-based path
ifneq ($(OS_ISCYGWIN),)
OS_WinPath = \
$(shell cygpath -w $(call SHELL_Escape,$(1)))
else
OS_WinPath = \
$(subst /,\,$(1))
endif

