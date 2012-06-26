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


# Locate a module
#
# $1 - Module name
#
# A module is a project named "makery-<modulename>"
#
MODULES_Locate = \
$(call PROJ_Locate,makery-$(1))


MODULES_GLOBAL_DESC ?= \
(internal) Modules whose global.mk has been processed (list)
MODULES_GLOBAL := $(MODULES_GLOBAL)
MAKERY_GLOBALS += MODULES_GLOBAL


# Pull in a module
#
# $1 - Module name
#
MODULES_Use = \
$(eval $(call MODULES_USE_TEMPLATE,$(1),$(call MODULES_Locate,$(1))))

# $1 - Module name
# $2 - Module dir
#
define MODULES_USE_TEMPLATE
-include $(call MAKE_EncodePath,$(2)/requires.mk)
ifeq ($$(filter $(call MAKE_EncodeWord,$(1)),$$(MODULES_GLOBAL)),)
$$(call MAKERY_Debug Sourcing module '$(1)' from '$(2)')
-include $(call MAKE_EncodePath,$(2)/global.mk)
MODULES_GLOBAL += $(call MAKE_EncodeWord,$(1))
endif
ifeq ($$(filter $(call MAKE_EncodeWord,$(1)),$$(MODULES_proj)),)
-include $(call MAKE_EncodePath,$(2)/project.mk)
MODULES_proj += $(call MAKE_EncodeWord,$(1))
endif
endef

