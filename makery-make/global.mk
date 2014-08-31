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


# Return argument unaltered
#
MAKE_Identity = $(1)


# Special Character constants
#
MAKE_CHAR_BLANK     :=
MAKE_CHAR_DOLLAR    := $$
MAKE_CHAR_HASH      := \#
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
MAKE_CHAR_LB        := (
MAKE_CHAR_RB        := )
MAKE_CHAR_AMP       := &
MAKE_CHAR_AT        := @
define MAKE_CHAR_NEWLINE


endef


# Special character tokens
#
MAKE_CHAR_DOLLAR_TOKEN  := <DOLLAR>
MAKE_CHAR_HASH_TOKEN    := <HASH>
MAKE_CHAR_SPACE_TOKEN   := <SPACE>
MAKE_CHAR_TAB_TOKEN     := <TAB>
MAKE_CHAR_APOS_TOKEN    := <APOS>
MAKE_CHAR_QUOTE_TOKEN   := <QUOTE>
MAKE_CHAR_COMMA_TOKEN   := <COMMA>
MAKE_CHAR_EQUALS_TOKEN  := <EQUALS>
MAKE_CHAR_COLON_TOKEN   := <COLON>
MAKE_CHAR_BS_TOKEN      := <BS>
MAKE_CHAR_LT_TOKEN      := <LT>
MAKE_CHAR_GT_TOKEN      := <GT>
MAKE_CHAR_LB_TOKEN      := <LB>
MAKE_CHAR_RB_TOKEN      := <RB>
MAKE_CHAR_AMP_TOKEN     := <AMP>
MAKE_CHAR_AT_TOKEN      := <AT>
MAKE_CHAR_NEWLINE_TOKEN := <NEWLINE>


# Encode special characters as tokens in a string
#
# $1 - Unencoded string
#
MAKE_EncodeWord = \
$(subst $(MAKE_CHAR_DOLLAR),$(MAKE_CHAR_DOLLAR_TOKEN),$(subst $(MAKE_CHAR_HASH),$(MAKE_CHAR_HASH_TOKEN),$(subst $(MAKE_CHAR_SPACE),$(MAKE_CHAR_SPACE_TOKEN),$(subst $(MAKE_CHAR_TAB),$(MAKE_CHAR_TAB_TOKEN),$(subst $(MAKE_CHAR_APOS),$(MAKE_CHAR_APOS_TOKEN),$(subst $(MAKE_CHAR_QUOTE),$(MAKE_CHAR_QUOTE_TOKEN),$(subst $(MAKE_CHAR_COMMA),$(MAKE_CHAR_COMMA_TOKEN),$(subst $(MAKE_CHAR_EQUALS),$(MAKE_CHAR_EQUALS_TOKEN),$(subst $(MAKE_CHAR_COLON),$(MAKE_CHAR_COLON_TOKEN),$(subst $(MAKE_CHAR_BS),$(MAKE_CHAR_BS_TOKEN),$(subst $(MAKE_CHAR_NEWLINE),$(MAKE_CHAR_NEWLINE_TOKEN),$(subst $(MAKE_CHAR_LB),$(MAKE_CHAR_LB_TOKEN),$(subst $(MAKE_CHAR_RB),$(MAKE_CHAR_RB_TOKEN),$(subst $(MAKE_CHAR_AMP),$(MAKE_CHAR_AMP_TOKEN),$(subst $(MAKE_CHAR_AT),$(MAKE_CHAR_AT_TOKEN),$(subst $(MAKE_CHAR_LT),$(MAKE_CHAR_LT_TOKEN),$(subst $(MAKE_CHAR_GT),$(MAKE_CHAR_GT_TOKEN),$(1))))))))))))))))))


# Decode special character tokens in a string
#
# $1 - Encoded string
#
MAKE_DecodeWord = \
$(subst $(MAKE_CHAR_GT_TOKEN),$(MAKE_CHAR_GT),$(subst $(MAKE_CHAR_LT_TOKEN),$(MAKE_CHAR_LT),$(subst $(MAKE_CHAR_DOLLAR_TOKEN),$(MAKE_CHAR_DOLLAR),$(subst $(MAKE_CHAR_HASH_TOKEN),$(MAKE_CHAR_HASH),$(subst $(MAKE_CHAR_SPACE_TOKEN),$(MAKE_CHAR_SPACE),$(subst $(MAKE_CHAR_TAB_TOKEN),$(MAKE_CHAR_TAB),$(subst $(MAKE_CHAR_APOS_TOKEN),$(MAKE_CHAR_APOS),$(subst $(MAKE_CHAR_QUOTE_TOKEN),$(MAKE_CHAR_QUOTE),$(subst $(MAKE_CHAR_COMMA_TOKEN),$(MAKE_CHAR_COMMA),$(subst $(MAKE_CHAR_EQUALS_TOKEN),$(MAKE_CHAR_EQUALS),$(subst $(MAKE_CHAR_COLON_TOKEN),$(MAKE_CHAR_COLON),$(subst $(MAKE_CHAR_BS_TOKEN),$(MAKE_CHAR_BS),$(subst $(MAKE_CHAR_NEWLINE_TOKEN),$(MAKE_CHAR_NEWLINE),$(subst $(MAKE_CHAR_LB_TOKEN),$(MAKE_CHAR_LB),$(subst $(MAKE_CHAR_RB_TOKEN),$(MAKE_CHAR_RB),$(subst $(MAKE_CHAR_AMP_TOKEN),$(MAKE_CHAR_AMP),$(subst $(MAKE_CHAR_AT_TOKEN),$(MAKE_CHAR_AT),$(1))))))))))))))))))


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


# Escape a path for use within Makefiles (eg. in rule dependency lists)
#
# $1 - The path
#
MAKE_EncodePath = \
$(subst $(MAKE_CHAR_SPACE),\$(MAKE_CHAR_SPACE),$(1))


# Get the directory part of a path
#
# Same as Make's built in $(dir) function except handles spaces
#
# $1 - Path (may include spaces)
#
MAKE_Dir = \
$(call MAKE_DecodeWord,$(dir $(call MAKE_EncodeWord,$(1))))


# Get the non-directory part of a path
#
# Same as Make's built in $(notdir) function except handles spaces
#
# $1 - Path (may include spaces)
#
MAKE_NotDir = \
$(call MAKE_DecodeWord,$(notdir $(call MAKE_EncodeWord,$(1))))


# Get a path's parent dir name (not full path)
#
# $1 - MAKE_EncodeWord'ed path(s)
#
MAKE_PathParentName = \
$(notdir $(patsubst %/,%,$(dir $(patsubst %/,%,$(1)))))


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


# $(shell) alias to permit tracing etc.
#
ifdef MAKERYTRACE
MAKE_Shell = \
$(info [begin] MAKE_Shell($(1)))$(shell $(1))$(info [end]   MAKE_Shell($(1)))
else
MAKE_Shell = \
$(shell $(1))
endif


# $(eval) alias to permit tracing and debugging
ifdef MAKERYTRACE
MAKE_Eval = \
$(info [begin] MAKE_Eval())$(info $(call MAKE_EVAL_DUMP,$(1)))$(eval $(1))$(info [end]   MAKE_Eval())
else
MAKE_Eval = \
$(call MAKE_EVAL_DUMP,$(1))$(eval $(1))
endif

ifdef MAKERYDEBUG
define MAKE_EVAL_DUMP
[debug] MAKE_Eval()
--------------------------------------------------------------------------------
$1
--------------------------------------------------------------------------------
endef
else
endif


# Disable Built-in Rules
#
MAKEFLAGS += -r
.SUFFIXES:

