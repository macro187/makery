# ------------------------------------------------------------------------------
# Copyright (c) 2007, 2008, 2009, 2010, 2011, 2012
# Ron MacNeil <macro@hotmail.com>
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
# Operating System
# ------------------------------------------------------------------------------

SYSTEM_NAME := $(call MAKE_Shell,uname -s)
SYSTEM_ISCYGWIN := $(findstring CYGWIN,$(SYSTEM_NAME))
SYSTEM_ISMSYS := $(findstring MINGW,$(SYSTEM_NAME))
SYSTEM_ISINTERIX := $(findstring Interix,$(SYSTEM_NAME))
SYSTEM_ISWINDOWS := $(findstring Windows,$(SYSTEM_NAME))$(SYSTEM_ISCYGWIN)$(SYSTEM_ISMSYS)$(SYSTEM_ISINTERIX)



# ------------------------------------------------------------------------------
# Commands
# ------------------------------------------------------------------------------

PWD := pwd

ifneq ($(SYSTEM_ISMSYS),)
PWD := pwd -W
endif


XDGOPEN := $(strip $(call MAKE_Shell,which xdg-open 2>&-))


# ------------------------------------------------------------------------------
# Shell versions of some MAKE_ functions
# ------------------------------------------------------------------------------

# Pipe commands that return multiple items, one per line, to this
define SYSTEM_SHELL_ENCODEWORD
sed -e s/\ /\<space\>/g | sed -e s/:/\<colon\>/g
endef

# Pipe commands that return paths to this
define SYSTEM_SHELL_CLEANPATH
sed -e s/\\\\/\\//g
endef



# ------------------------------------------------------------------------------
# Escape special characters in a string for use in the shell
# $1 - The string
# ------------------------------------------------------------------------------

SYSTEM_ShellEscape = \
$(subst $(MAKE_CHAR_QUOTE),\$(MAKE_CHAR_QUOTE),$(subst $(MAKE_CHAR_APOS),\$(MAKE_CHAR_APOS),$(subst $(MAKE_CHAR_SPACE),\$(MAKE_CHAR_SPACE),$(subst \,\\,$(1)))))


# Determine whether a directory exists
#
# $1 - Path of directory
#
SYSTEM_DirExists = \
$(findstring EXISTS,$(call MAKE_Shell,test -d $(call SYSTEM_ShellEscape,$(1)) && echo EXISTS))


# Find files recursively under a directory
#
# $1 - Directory to look in
# $2 - Filename extension to find (optional)
# $3 - Subdirectories to avoid (list) (optional)
#
SYSTEM_FindFiles = \
$(call MAKE_Shell,test -d $(call SYSTEM_ShellEscape,$(1)) && cd $(call SYSTEM_ShellEscape,$(1)) && find * $(foreach dir,$(3),-name $(call SYSTEM_ShellEscape,$(call MAKE_DecodeWord,$(3))) -prune -o) -type f $(if $(2),-name \*.$(2),) -print | $(SYSTEM_SHELL_CLEANPATH) | $(SYSTEM_SHELL_ENCODEWORD))


# ------------------------------------------------------------------------------
# Determine a directory's canonical absolute path
#
# Parameters
# $1 - Path
#
# Returns
# Absolute path, or blank if the dir doesn't exist
# ------------------------------------------------------------------------------

SYSTEM_DirToAbs = \
$(MAKERY_TRACEBEGIN1)$(call MAKE_Shell,test -d $(call SYSTEM_ShellEscape,$(1)) && cd $(call SYSTEM_ShellEscape,$(1)) && $(PWD) | $(SYSTEM_SHELL_CLEANPATH))$(MAKERY_TRACEEND1)



# ------------------------------------------------------------------------------
# Convert a posix-style path (forward-slashes) to a Windows-style path
# (backslashes)
#
# This function does no mapping, it just changes separators
#
# $1 - A posix-style path
# ------------------------------------------------------------------------------

SYSTEM_WinPath = \
$(subst /,\,$(1))



# ------------------------------------------------------------------------------
# Map a posix path to an absolute Windows-style path to the same location from
# the perspective of Windows programs
#
# $1 - A posix path
# ------------------------------------------------------------------------------

SYSTEM_WinPathAbs = \
$(call SYSTEM_WinPath,$(1))

ifneq ($(SYSTEM_ISCYGWIN),)
SYSTEM_WinPathAbs = \
$(call MAKE_Shell,cygpath -w $(call SYSTEM_ShellEscape,$(1)))

else ifneq ($(SYSTEM_ISINTERIX),)
SYSTEM_WinPathAbs = \
$(call MAKE_Shell,unixpath2win $(call SYSTEM_ShellEscape,$(1)))
endif



# ------------------------------------------------------------------------------
# Convert a Windows-style path (backslashes) to a posix-style path
# (forward-slashes)
#
# This function does no mapping, it just changes separators
#
# $1 - A Windows-style path
# ------------------------------------------------------------------------------

SYSTEM_PosixPath = \
$(subst \,/,$(1))



# ------------------------------------------------------------------------------
# Map a Windows path to an absolute posix-style path to the same location from
# the perspective of posix programs
#
# $1 - A Windows path
# ------------------------------------------------------------------------------

SYSTEM_PosixPathAbs = \
$(call SYSTEM_PosixPath,$(1))

ifneq ($(SYSTEM_ISCYGWIN),)
SYSTEM_PosixPathAbs = \
$(call MAKE_Shell,cygpath -u $(call SYSTEM_ShellEscape,$(1)))
else ifneq ($(SYSTEM_ISINTERIX),)
SYSTEM_PosixPathAbs = \
$(call MAKE_Shell,winpath2unix $(call SYSTEM_ShellEscape,$(1)))
endif



# ------------------------------------------------------------------------------
# Windows Directory
# ------------------------------------------------------------------------------
ifneq ($(SYSTEM_ISWINDOWS),)

ifneq ($(windir),)
SYSTEM_WINDIR := $(call SYSTEM_PosixPathAbs,$(windir))
else ifneq ($(WINDIR),)
SYSTEM_WINDIR := $(call SYSTEM_PosixPathAbs,$(WINDIR))
else
$(error Running on Windows but windir environment variable is not set)
endif

endif


# Windows "Program Files" directory
#
ifneq ($(SYSTEM_ISWINDOWS),)
SYSTEM_PROGRAMFILES :=

ifneq ($(programfiles),)
SYSTEM_PROGRAMFILES := $(call SYSTEM_PosixPathAbs,$(programfiles))

ifneq ($(PROGRAMFILES),)
SYSTEM_PROGRAMFILES := $(call SYSTEM_PosixPathAbs,$(PROGRAMFILES))

endif


# Produce a command that opens a program, document, or URL as appropriate on
# the user's desktop
#
# $1 - Program, document, URL, etc.
#
SYSTEM_DesktopOpen =

ifneq ($(SYSTEM_ISCYGWIN),)
SYSTEM_DesktopOpen = cmd /c start $(1)

else ifneq ($(SYSTEM_ISMSYS),)
SYSTEM_DesktopOpen = cmd //c start $(1)

else ifneq ($(XDGOPEN),)
SYSTEM_DesktopOpen = $(XDGOPEN) $(1)

else ifneq ($(SYSTEM_ISINTERIX),)
#TODO

endif

