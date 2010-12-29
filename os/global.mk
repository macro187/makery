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

OS_NAME := $(SHELL_OS_NAME)
OS_ISCYGWIN := $(findstring CYGWIN,$(OS_NAME))
OS_ISMSYS := $(SHELL_ISMSYS)
OS_ISWINDOWS := $(findstring Windows,$(OS_NAME))$(OS_CYGWIN)$(OS_ISMSYS)


# ------------------------------------------------------------------------------
# Operating system utilities
# ------------------------------------------------------------------------------

# Make a Windows path (backslashes, c:\ at the beginning, etc.) out of a posix
# path (forward-slashes)
#
# For use when working with certain Windows-based programs that don't like
# posix (forward-slash) paths
#
# $1 - A posix path
#
ifneq ($(OS_ISCYGWIN),)
OS_WinPath = \
$(shell cygpath -w $(call SHELL_Escape,$(1)))
else
OS_WinPath = \
$(subst /,\,$(1))
endif


# Make a posix path (forward-slashes)
# For use when working with certain Windows-based programs that don't like
# posix (forward-slash) paths
#
# $1 - A Windows path
#
ifneq ($(OS_ISCYGWIN),)
OS_PosixPath = \
$(shell cygpath -u $(call SHELL_Escape,$(1)))
else
OS_PosixPath = \
$(subst \,/,$(1))
endif


# ------------------------------------------------------------------------------
# Windows
# ------------------------------------------------------------------------------
ifneq ($(OS_ISWINDOWS),)

# Windows directory
ifneq ($(windir),)
OS_WINDIR := $(call OS_PosixPath,$(windir))
else ifneq ($(WINDIR),)
OS_WINDIR := $(call OS_PosixPath,$(WINDIR))
else
$(error Running on Windows but windir environment variable is not set)
endif

endif

