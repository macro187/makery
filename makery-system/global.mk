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



# Operating System
#
SYSTEM_NAME := $(call MAKE_Shell,uname -s)
SYSTEM_ISCYGWIN := $(strip $(findstring CYGWIN,$(SYSTEM_NAME)))
SYSTEM_ISMSYS := $(strip $(findstring MINGW,$(SYSTEM_NAME)))
SYSTEM_ISINTERIX := $(strip $(findstring Interix,$(SYSTEM_NAME)))
SYSTEM_ISWINDOWS := $(strip $(findstring Windows,$(SYSTEM_NAME))$(SYSTEM_ISCYGWIN)$(SYSTEM_ISMSYS)$(SYSTEM_ISINTERIX))


PWD := pwd


XDGOPEN := $(strip $(call MAKE_Shell,which xdg-open 2>&-))


SYSTEM_TEMPDIR := $(strip $(TMP))
ifeq ($(SYSTEM_TEMPDIR),)
SYSTEM_TEMPDIR := $(strip $(TEMP))
endif
ifeq ($(SYSTEM_TEMPDIR),)
SYSTEM_TEMPDIR := $(strip $(TMPDIR))
endif
ifeq ($(SYSTEM_TEMPDIR),)
SYSTEM_TEMPDIR := $(realpath /tmp)
endif
ifeq ($(SYSTEM_TEMPDIR),)
$(error Cant determine temp directory location, TMP, TEMP, and TMPDIR are all blank)
endif


# Pipe commands that return multiple items, one per line, to this
#
define SYSTEM_SHELL_ENCODEWORD
sed -e s/\ /\<SPACE\>/g | sed -e s/:/\<COLON\>/g
endef


# Escape special characters in a string for use in the shell
#
# $1 - The string
#
SYSTEM_ShellEscape = \
$(subst ?,\?,$(subst *,\*,$(subst [,\[,$(subst ],\],$(subst $(MAKE_CHAR_LB),\$(MAKE_CHAR_LB),$(subst $(MAKE_CHAR_RB),\$(MAKE_CHAR_RB),$(subst $(MAKE_CHAR_DOLLAR),\$(MAKE_CHAR_DOLLAR),$(subst <,\<,$(subst >,\>,$(subst $(MAKE_CHAR_QUOTE),\$(MAKE_CHAR_QUOTE),$(subst $(MAKE_CHAR_APOS),\$(MAKE_CHAR_APOS),$(subst $(MAKE_CHAR_SPACE),\$(MAKE_CHAR_SPACE),$(subst \,\\,$(1))))))))))))))


# Find a file
#
# Case-insensitive on Windows.
#
# $1 - Path to file(s), final component may be a shell pattern
#
# Returns the path of the first (alphabetically) matching file if found,
# otherwise nothing
#
SYSTEM_FindFile = \
$(call MAKE_DecodeWord,$(firstword $(sort $(call SYSTEM_FindFiles,$(1)))))


# Find files
#
# Case-insensitive on Windows.
#
# $1 - Path to file(s), final component may be a shell pattern
#
# Returns MAKE_EncodeWord()ed paths of matching files
#
ifneq ($(SYSTEM_ISWINDOWS),)
SYSTEM_FindFiles = \
$(call MAKE_Shell,find $(call SYSTEM_ShellEscape,$(call MAKE_Dir,$(1))) -maxdepth 1 -type f -iname $(call SYSTEM_ShellEscape,$(call MAKE_NotDir,$(1))) 2>&- | $(SYSTEM_SHELL_ENCODEWORD))
else
SYSTEM_FindFiles = \
$(call MAKE_Shell,find $(call SYSTEM_ShellEscape,$(call MAKE_Dir,$(1))) -maxdepth 1 -type f -name $(call SYSTEM_ShellEscape,$(call MAKE_NotDir,$(1))) 2>&- | $(SYSTEM_SHELL_ENCODEWORD))
endif


# Find a directory
#
# Case-insensitive on Windows.
#
# $1 - Path to directory(s), final component may be a shell pattern
#
# Returns the path of the first (alphabetically) matching directory if found,
# otherwise nothing
#
SYSTEM_FindDir = \
$(call MAKE_DecodeWord,$(firstword $(sort $(call SYSTEM_FindDirs,$(1)))))


# Find directories
#
# Case-insensitive on Windows.
#
# $1 - Path to directory(s), final component may be a shell pattern
#
# Returns MAKE_EncodeWord()ed paths of matching directories
#
ifneq ($(SYSTEM_ISWINDOWS),)
SYSTEM_FindDirs = \
$(call MAKE_Shell,find $(call SYSTEM_ShellEscape,$(call MAKE_Dir,$(1))) -maxdepth 1 -type d -iname $(call SYSTEM_ShellEscape,$(call MAKE_NotDir,$(1))) 2>&- | $(SYSTEM_SHELL_ENCODEWORD))
else
SYSTEM_FindDirs = \
$(call MAKE_Shell,find $(call SYSTEM_ShellEscape,$(call MAKE_Dir,$(1))) -maxdepth 1 -type d -name $(call SYSTEM_ShellEscape,$(call MAKE_NotDir,$(1))) 2>&- | $(SYSTEM_SHELL_ENCODEWORD))
endif


# Find files recursively under a directory
#
# $1 - Directory to look in
# $2 - Filename extension to find (optional)
# $3 - Subdirectories to avoid (list) (optional)
#
SYSTEM_FindFilesUnder = \
$(call MAKE_Shell,cd $(call SYSTEM_ShellEscape,$(1)) 2>&- && find * $(foreach dir,$(3),-name $(call SYSTEM_ShellEscape,$(call MAKE_DecodeWord,$(3))) -prune -o) -type f $(if $(2),-name \*.$(2)) -print | $(SYSTEM_SHELL_ENCODEWORD))


# Determine a directory's canonical absolute path
#
# $1 - Path
#
# Returns absolute path, or blank if the dir doesn't exist
#
SYSTEM_DirToAbs = \
$(MAKERY_TRACEBEGIN1)$(call MAKE_Shell,test -d $(call SYSTEM_ShellEscape,$(1)) && realpath -m $(call SYSTEM_ShellEscape,$(1)) 2>&-)$(MAKERY_TRACEEND1)


# Convert a posix-style path fragment (with forward-slashes) to a Windows-style
# path fragment (with backslashes)
#
# This function does no mapping, it just changes separators
#
# $1 - A posix-style path
#
SYSTEM_WinPathFragment = \
$(subst /,\,$(1))


# Map a posix path to an absolute Windows-style path to the same location from
# the perspective of Windows programs
#
# $1 - A posix path
#
SYSTEM_WinPath = \
$(call SYSTEM_WinPathFragment,$(1))

ifneq ($(SYSTEM_ISCYGWIN),)
SYSTEM_WinPath = \
$(subst /,\,$(subst /cygdrive/e,E:,$(subst /cygdrive/d,D:,$(subst /cygdrive/c,C:,$(1)))))
#$(call MAKE_Shell,cygpath -w $(call SYSTEM_ShellEscape,$(1)))

else ifneq ($(SYSTEM_ISINTERIX),)
SYSTEM_WinPath = \
$(call MAKE_Shell,unixpath2win $(call SYSTEM_ShellEscape,$(1)))

else ifneq ($(SYSTEM_ISMSYS),)
SYSTEM_WinPath = \
$(call SYSTEM_WinPathFragment,$(call MAKE_DecodeWord,$(patsubst /E/%,E:/%,$(patsubst /e/%,e:/%,$(patsubst /D/%,D:/%,$(patsubst /d/%,d:/%,$(patsubst /C/%,C:/%,$(patsubst /c/%,c:/%,$(call MAKE_EncodeWord,$(1))))))))))
endif


# Map a posix path to an absolute Windows-style path to the same location from
# the perspective of native Windows programs IF running on Windows
#
# $1 - A posix path
#
SYSTEM_WinPathOnWin = $(1)
ifneq ($(SYSTEM_ISWINDOWS),)
SYSTEM_WinPathOnWin = \
$(call SYSTEM_WinPath,$(1))
endif


# Convert a Windows-style path (backslashes) to a posix-style path
# (forward-slashes)
#
# This function does no mapping, it just changes separators
#
# $1 - A Windows-style path
#
SYSTEM_PosixPath = \
$(subst \,/,$(1))


# Map a Windows path to an absolute posix-style path to the same location from
# the perspective of posix programs
#
# $1 - A Windows path
#
SYSTEM_PosixPathAbs = \
$(call SYSTEM_PosixPath,$(1))

ifneq ($(SYSTEM_ISCYGWIN),)
SYSTEM_PosixPathAbs = \
$(call MAKE_Shell,cygpath -u $(call SYSTEM_ShellEscape,$(1)))

else ifneq ($(SYSTEM_ISINTERIX),)
SYSTEM_PosixPathAbs = \
$(call MAKE_Shell,winpath2unix $(call SYSTEM_ShellEscape,$(1)))

else ifneq ($(SYSTEM_ISMSYS),)
SYSTEM_PosixPathAbs = \
$(call SYSTEM_PosixPath,$(call MAKE_DecodeWord,$(patsubst E$(MAKE_CHAR_COLON_TOKEN)%,/E%,$(patsubst e$(MAKE_CHAR_COLON_TOKEN)%,/e%,$(patsubst D$(MAKE_CHAR_COLON_TOKEN)%,/D%,$(patsubst d$(MAKE_CHAR_COLON_TOKEN)%,/d%,$(patsubst C$(MAKE_CHAR_COLON_TOKEN)%,/C%,$(patsubst c$(MAKE_CHAR_COLON_TOKEN)%,/c%,$(call MAKE_EncodeWord,$(1))))))))))
endif


# Windows Directory
#
ifneq ($(SYSTEM_ISWINDOWS),)

ifneq ($(windir),)
SYSTEM_WINDIR := $(call SYSTEM_PosixPathAbs,$(windir))
else ifneq ($(WINDIR),)
SYSTEM_WINDIR := $(call SYSTEM_PosixPathAbs,$(WINDIR))
else
$(error Running on Windows but windir environment variable is not set)
endif

endif


# Windows "Program Files" directories
#
# Depending on the edition of Windows, one or the other or both may be present
#
SYSTEM_PROGRAMFILES :=
SYSTEM_PROGRAMFILESx86 :=

ifneq ($(SYSTEM_ISWINDOWS),)
ifneq ($(programfiles),)
SYSTEM_PROGRAMFILES := $(call SYSTEM_PosixPathAbs,$(programfiles))
else ifneq ($(PROGRAMFILES),)
SYSTEM_PROGRAMFILES := $(call SYSTEM_PosixPathAbs,$(PROGRAMFILES))
endif
SYSTEM_PROGRAMFILES := $(subst Program Files (x86),Program Files,$(SYSTEM_PROGRAMFILES))
SYSTEM_PROGRAMFILESx86 := $(subst Program Files,Program Files (x86),$(SYSTEM_PROGRAMFILES))
endif


# Find a file under one of the "Program Files" directories
#
# Case-insensitive.
# Prefers 64-bit (i.e. "Program Files\").
#
# $1 - Path to file under "Program Files\" or "Program Files (x86)\"
#
# Returns the full path to the file if found, otherwise nothing
#
ifneq ($(SYSTEM_ISWINDOWS),)
SYSTEM_FindProgramFilesFile = \
$(call MAKE_DecodeWord,$(lastword $(if $(SYSTEM_PROGRAMFILESx86),$(sort $(call SYSTEM_FindFiles,$(SYSTEM_PROGRAMFILESx86)/$(1)))) $(if $(SYSTEM_PROGRAMFILES),$(sort $(call SYSTEM_FindFiles,$(SYSTEM_PROGRAMFILES)/$(1))))))
endif


# Find a directory under one of the "Program Files" directories
#
# Case-insensitive.
# Prefers 64-bit (i.e. "Program Files\") and last alphabetically.
#
# $1 - Path to directory under "Program Files\" or "Program Files (x86)\",
#      final component can be a shell pattern
#
# Returns the full path to the directory if found, otherwise nothing
#
ifneq ($(SYSTEM_ISWINDOWS),)
SYSTEM_FindProgramFilesDir = \
$(call MAKE_DecodeWord,$(lastword $(if $(SYSTEM_PROGRAMFILESx86),$(sort $(call SYSTEM_FindDirs,$(SYSTEM_PROGRAMFILESx86)/$(1)))) $(if $(SYSTEM_PROGRAMFILES),$(sort $(call SYSTEM_FindDirs,$(SYSTEM_PROGRAMFILES)/$(1))))))
endif


# Produce a command that opens a program, document, or URL as appropriate on
# the user's desktop
#
# $1 - Program, document, URL, etc.
#
SYSTEM_DesktopOpen = @echo Pretending to open '$(1)'

ifneq ($(SYSTEM_ISCYGWIN)$(SYSTEM_ISMSYS),)
SYSTEM_DesktopOpen = start "" $(1)

else ifneq ($(XDGOPEN),)
SYSTEM_DesktopOpen = $(XDGOPEN) $(1) 2>&1 >&-

else ifneq ($(SYSTEM_ISINTERIX),)
#TODO

endif

