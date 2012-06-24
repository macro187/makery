# ------------------------------------------------------------------------------
# Copyright (c) 2007, 2008, 2009, 2010, 2011
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


$(call PROJ_DeclareVar,CONFIG_fields)
CONFIG_fields_DESC ?= Ordered list of config fields (list)


#$(call CONFIG_DeclareField,CONFIG_test)
#CONFIG_test_DESC ?= A test config field
#CONFIG_test_ALL = a b c d e
#
#CONFIG_test_MASK_BAD = c e
#CONFIG_test_MASK_BAD_DESC ?= Theyre bad!
#CONFIG_test_MASKS += BAD
#
#CONFIG_test_MASK_HATEA = a
#CONFIG_test_MASK_HATEA_DESC ?= I hate A!
#CONFIG_test_MASKS += HATEA


$(call PROJ_DeclareVar,CONFIG_string)
CONFIG_string_DESC ?= A string representing the current config
CONFIG_string = $(patsubst -%,%,$(subst $(MAKE_CHAR_SPACE),,$(foreach f,$(CONFIG_fields),-$($(f)))))
