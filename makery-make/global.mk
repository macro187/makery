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


# Returning argument unaltered
#
MAKE_Identity = $(1)



# ------------------------------------------------------------------------------
# Special Characters
# ------------------------------------------------------------------------------

# Special Characters
#
MAKE_CHAR_BLANK     :=
MAKE_CHAR_SPACE     := $(MAKE_CHAR_BLANK) $(MAKE_CHAR_BLANK)
MAKE_CHAR_TAB       := $(MAKE_CHAR_BLANK)	$(MAKE_CHAR_BLANK)
MAKE_CHAR_APOS      := '#'
MAKE_CHAR_QUOTE     := "#"
MAKE_CHAR_COMMA     := ,
MAKE_CHAR_EQUALS    := =
MAKE_CHAR_COLON     := :
MAKE_CHAR_BS        := \\#
MAKE_CHAR_LT        := <
MAKE_CHAR_GT        := >
define MAKE_CHAR_NEWLINE


endef


# Encoded sequences for special characters
#
MAKE_CHAR_BLANK_ENCODED     := <BLANK>
MAKE_CHAR_SPACE_ENCODED     := <SPACE>
MAKE_CHAR_TAB_ENCODED       := <TAB>
MAKE_CHAR_APOS_ENCODED      := <APOS>
MAKE_CHAR_QUOTE_ENCODED     := <QUOTE>
MAKE_CHAR_COMMA_ENCODED     := <COMMA>
MAKE_CHAR_EQUALS_ENCODED    := <EQUALS>
MAKE_CHAR_COLON_ENCODED     := <COLON>
MAKE_CHAR_BS_ENCODED        := <BS>
MAKE_CHAR_LT_ENCODED        := <LT>
MAKE_CHAR_GT_ENCODED        := <GT>
MAKE_CHAR_NEWLINE_ENCODED   := <NEWLINE>



# ------------------------------------------------------------------------------
# Words
# ------------------------------------------------------------------------------

# Encode special characters as sequences in a string
#
# $1 - Unencoded string
#
MAKE_EncodeWord = \
$(subst $(MAKE_CHAR_COLON),$(MAKE_CHAR_COLON_ENCODED),$(subst $(MAKE_CHAR_NEWLINE),$(MAKE_CHAR_NEWLINE_ENCODED),$(subst $(MAKE_CHAR_SPACE),$(MAKE_CHAR_SPACE_ENCODED),$(subst $(MAKE_CHAR_LT),$(MAKE_CHAR_LT_ENCODED),$(subst $(MAKE_CHAR_GT),$(MAKE_CHAR_GT_ENCODED),$(1))))))


# Decode special character sequences in a string
#
# $1 - Encoded string
#
MAKE_DecodeWord = \
$(subst $(MAKE_CHAR_GT_ENCODED),$(MAKE_CHAR_GT),$(subst $(MAKE_CHAR_LT_ENCODED),$(MAKE_CHAR_LT),$(subst $(MAKE_CHAR_SPACE_ENCODED),$(MAKE_CHAR_SPACE),$(subst $(MAKE_CHAR_NEWLINE_ENCODED),$(MAKE_CHAR_NEWLINE),$(subst $(MAKE_CHAR_COLON_ENCODED),$(MAKE_CHAR_COLON),$(1))))))


# Call a function on each word in a string after decoding special characters in
# it
#
# $1 - Function name
# $2 - String containing encoded words
#
MAKE_CallForEach = \
$(foreach word,$(2),$(call $(1),$(call MAKE_DecodeWord,$(word))))


# Calls two functions one after another on each word in a string after decoding
# special characters in it
#
# $1 - First function name
# $2 - Second function name
# $3 - String containing encoded words
#
MAKE_CallForEach2 = \
$(foreach word,$(3),$(call $(2),$(call $(1),$(call MAKE_DecodeWord,$(word)))))



# ------------------------------------------------------------------------------
# Paths
# ------------------------------------------------------------------------------

# Escape a path for use within Makefiles (eg. in rule dependency lists)
#
# $1 - The path
#
MAKE_EncodePath = \
$(subst $(MAKE_CHAR_SPACE),\$(MAKE_CHAR_SPACE),$(1))


# Get a path's parent dir name (not full path)
#
# $1 - MAKE_EncodeWord'ed path(s)
#
MAKE_PathParentName = \
$(notdir $(patsubst %/,%,$(dir $(patsubst %/,%,$(1)))))



# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------

# Clear variables with a particular prefix
#
# $1 - Prefix
#
MAKE_ClearVarsWithPrefix = \
$(if $(1),$(eval $(call MAKE_ClearVarsWithPrefix_TEMPLATE,$(1))),$(error No prefix provided))

define \
MAKE_ClearVarsWithPrefix_TEMPLATE
$(foreach v,$(filter $(1)%,$(.VARIABLES)),$(MAKE_CHAR_NEWLINE)$(v) :=#)
endef



# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------

# $(shell) alias to permit tracing etc.
#
MAKE_Shell = \
$(shell $(1))
#$(info $(1))$(shell $(1))



# ------------------------------------------------------------------------------
# Disable Built-in Rules
# ------------------------------------------------------------------------------

MAKEFLAGS += -r
.SUFFIXES:

