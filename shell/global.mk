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
# Shell versions of some MAKE_ functions
# ------------------------------------------------------------------------------

# Pipe commands that return multiple items, one per line, to this
define SHELL_ENCODEWORD
sed -e s/\ /\<space\>/g | sed -e s/:/\<colon\>/g
endef

# Pipe commands that return paths to this
define SHELL_CLEANPATH
sed -e s/\\\\/\\//g
endef



# ------------------------------------------------------------------------------
# Escape special characters in a string for use in the shell
# $1 - The string
# ------------------------------------------------------------------------------

# TODO: Escape more characters

SHELL_Escape = \
$(subst $(MAKE_CHAR_SPACE),\$(MAKE_CHAR_SPACE),$(subst \,\\,$(1)))



# ------------------------------------------------------------------------------
# Prints a heading for the current target
# ------------------------------------------------------------------------------

define SHELL_TARGETHEADING
@printf \\n\\n===\>\ $(call SHELL_Escape,$@)\\n
endef



# ------------------------------------------------------------------------------
# Determine a directory's canonical absolute path
#
# Parameters
# $1 - Path
#
# Returns
# Absolute path, or blank if the dir doesn't exist
# ------------------------------------------------------------------------------

SHELL_DirToAbs = \
$(MAKERY_Trace1)$(shell test -d $(call SHELL_Escape,$(1)) && cd $(call SHELL_Escape,$(1)) && pwd | $(SHELL_CLEANPATH))


# ------------------------------------------------------------------------------
# Determine a directory's absolute path given it's (possibly) relative path
# from an origin directory
#
# Parameters
# $1 - (possibly) relative path
# $2 - origin dir
#
# Remarks
# $2 doesn't really matter if $1 is not relative, but it still must exist
#
# Returns
# Absolute path, or blank if either argument is blank, or blank if dir
# specified in either argument does not exist
# ------------------------------------------------------------------------------

SHELL_RelDirToAbs = \
$(MAKERY_Trace2)$(if $(1),$(if $(2),$(shell test -d $(call SHELL_Escape,$(2)) && cd $(call SHELL_Escape,$(2)) && test -d $(call SHELL_Escape,$(1)) && cd $(call SHELL_Escape,$(1)) && pwd | $(SHELL_CLEANPATH))))

