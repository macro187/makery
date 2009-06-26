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
# Basics
# ------------------------------------------------------------------------------

# Function returning it's first argument unaltered
MAKE_Identity = $(1)



# ------------------------------------------------------------------------------
# Special Characters
# ------------------------------------------------------------------------------

MAKE_CHAR_BLANK :=
MAKE_CHAR_SPACE := $(MAKE_CHAR_BLANK) $(MAKE_CHAR_BLANK)
MAKE_CHAR_TAB := $(MAKE_CHAR_BLANK)	$(MAKE_CHAR_BLANK)
MAKE_CHAR_APOS := '#'
MAKE_CHAR_QUOTE := "#"
MAKE_CHAR_COMMA := ,
MAKE_CHAR_EQUALS := =
MAKE_CHAR_COLON := :
#MAKE_CHAR_HASH := # TODO
MAKE_CHAR_BS := \\#
define MAKE_CHAR_NEWLINE


endef



# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------

# Clear variables with a particular prefix
# $1 Prefix
MAKE_ClearVarsWithPrefix = \
$(if $(1),$(eval $(call MAKE_ClearVarsWithPrefix_TEMPLATE,$(1))),$(error No prefix provided))

define \
MAKE_ClearVarsWithPrefix_TEMPLATE
$(foreach v,$(filter $(1)%,$(.VARIABLES)),$(MAKE_CHAR_NEWLINE)$(v) :=#)
endef



# ------------------------------------------------------------------------------
# Special Character Encoding
# - Encodes/decodes special characters in Make words
# ------------------------------------------------------------------------------

# Encoding sequence begin/end characters
MAKE_ENCODINGSEQUENCE_BEGIN := <
MAKE_ENCODINGSEQUENCE_END := >

# A special character encoding sequnce with a given code
# $1 - Code
MAKE_MakeEncodingSequence = \
$(MAKE_ENCODINGSEQUENCE_BEGIN)$(1)$(MAKE_ENCODINGSEQUENCE_END)

# A given string with a given character encoded as an encoding sequence of a
# given code
# $1 - Character
# $2 - Code
# $3 - String
MAKE_EncodeChar = \
$(subst $(1),$(call MAKE_MakeEncodingSequence,$(2)),$(3))

# A given string with encoding sequences of a given code decoded to a given
# character
# $1 - Code
# $2 - Character
# $3 - String
MAKE_DecodeChar = \
$(subst $(call MAKE_MakeEncodingSequence,$(1)),$(2),$(3))

# A given string with any ENCODINGSEQUENCE_BEGIN characters encoded as a
# "seqbegin" encoding sequence
# $1 - String
MAKE_PreEncode = \
$(call MAKE_EncodeChar,$(MAKE_ENCODINGSEQUENCE_BEGIN),seqbegin,$(1))

# A given string with any "seqbegin" encoding sequences decoded to
# ENCODINGSEQUENCE_BEGIN characters
# $1 - String
MAKE_PostDecode = \
$(call MAKE_DecodeChar,seqbegin,$(MAKE_ENCODINGSEQUENCE_BEGIN),$(1))



# ------------------------------------------------------------------------------
# Word encoding
# - Facilitates lists of items containing special characters including
#   whitespace
# ------------------------------------------------------------------------------

# A given string with problematic special characters (including whitespace)
# encoded as encoding sequences
# $1 - String
MAKE_EncodeWord = \
$(call MAKE_EncodeChar,$(MAKE_CHAR_COLON),colon,$(call MAKE_EncodeChar,$(MAKE_CHAR_NEWLINE),newline,$(call MAKE_EncodeChar,$(MAKE_CHAR_SPACE),space,$(call MAKE_PreEncode,$(1)))))
#$(subst $(MAKE_CHAR_SPACE),<space>,$(subst <,<seqbegin>,$(1)))
#$(call MAKE_EncodeChar,$(MAKE_CHAR_SPACE),space,$(call MAKE_PreEncode,$(1)))

# A decoded version of a given MAKE_EncodeWord'd string
# $1 - String
MAKE_DecodeWord = \
$(call MAKE_PostDecode,$(call MAKE_DecodeChar,space,$(MAKE_CHAR_SPACE),$(call MAKE_DecodeChar,newline,$(MAKE_CHAR_NEWLINE),$(call MAKE_DecodeChar,colon,$(MAKE_CHAR_COLON),$(1)))))
#$(subst <seqbegin>,<,$(subst <space>,$(MAKE_CHAR_SPACE),$(1)))
#$(call MAKE_PostDecode,$(call MAKE_DecodeChar,space,$(MAKE_CHAR_SPACE),$(1)))

# Calls a given function on each word in a given string after
# MAKE_DecodeWord'ing it
# $1 - Function name
# $2 - String containing encoded words
MAKE_CallForEach = \
$(foreach word,$(2),$(call $(1),$(call MAKE_DecodeWord,$(word))))

# Calls two given functions on each word in a given string after
# MAKE_DecodeWord'ing it
# $1 - First function name
# $2 - Second function name
# $3 - String containing encoded words
MAKE_CallForEach2 = \
$(foreach word,$(3),$(call $(2),$(call $(1),$(call MAKE_DecodeWord,$(word)))))



# ------------------------------------------------------------------------------
# Path Encoding
# ------------------------------------------------------------------------------

# Escape a path for use within Makefiles (eg. in rule dependency lists)
# $1 - The path
MAKE_EncodePath = \
$(subst $(MAKE_CHAR_SPACE),\$(MAKE_CHAR_SPACE),$(1))


# Normalize a path by converting any slashes to backslashes
MAKE_CleanPath = \
$(subst \,/,$(1))


# Get a path's parent dir name (not full path)
# $1 MAKE_EncodeWord'ed path(s)
MAKE_PathParentName = \
$(notdir $(patsubst %/,%,$(dir $(patsubst %/,%,$(1)))))



# ------------------------------------------------------------------------------
# Messages
# ------------------------------------------------------------------------------

# Produces a heading suitable for use with $(warning)
# $1 - Heading text
MAKE_Heading = \
$(MAKE_CHAR_NEWLINE)$(MAKE_CHAR_NEWLINE)===> $(1)$(MAKE_CHAR_NEWLINE)

# Produces an informational message suitable for use with $(warning)
# $1 - Message text
MAKE_Message = \
$(MAKE_Heading)

# Produces a message displaying a variable and it's value suitable for use
# with $(warning)
# $1 - Variable name
MAKE_DumpVar = \
$(1) = '$($(1))'$(if $($(1)_DESC),$(MAKE_CHAR_NEWLINE)    $($(1)_DESC))
#$(1) = '$($(1))'

#$(1)$(MAKE_CHAR_NEWLINE)$(if $($(1)_DESC),$(MAKE_CHAR_TAB)$($(1)_DESC)$(MAKE_CHAR_NEWLINE))$(MAKE_CHAR_TAB)'$($(1))'

# A dump of the names and values of a given list of variables
# $1 - Variable list
MAKE_DumpVars = \
$(foreach varname,$(1),$(MAKE_CHAR_NEWLINE)$(call MAKE_DumpVar,$(varname)))



# ------------------------------------------------------------------------------
# Disable built-in make suffix rules
# ------------------------------------------------------------------------------

.SUFFIXES:

