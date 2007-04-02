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
# Module locations
# ------------------------------------------------------------------------------

# Paths to search for modules in
# - You can do the following in your ~/.makeryrc.mk:
#   MODULES_PATHS += $(call MAKE_EncodeWord,/path/to/my/modules)
MODULES_PATHS := $(call MAKE_EncodeWord,$(MAKERY)) $(MODULES_PATHS)



# Locate a given module's dir in MODULES_PATHS
# $1 - Module name
MODULES_Locate = \
$(call MAKE_DecodeWord,$(firstword $(foreach dir,$(MODULES_PATHS),$(if $(shell test -d $(call SHELL_Escape,$(call MAKE_DecodeWord,$(dir))/$(1)) && echo yes),$(dir)/$(1)))))



# ------------------------------------------------------------------------------
# List of modules whose global sections have been processed
# ------------------------------------------------------------------------------

MODULES_GLOBAL := $(MODULES_GLOBAL)
MODULES_GLOBAL_DESC ?= \
(internal) Modules whose global.mk has been processed (list)
MAKERY_GLOBALS += MODULES_GLOBAL



# ------------------------------------------------------------------------------
# Function for pulling in a module
# $1 - module name (ie. the module's directory name)
# ------------------------------------------------------------------------------

MODULES_Use = \
$(eval $(call MODULES_USE_TEMPLATE,$(1),$(call MODULES_Locate,$(1))))

# $1 - Module name
# $2 - Module dir
define MODULES_USE_TEMPLATE
$(if $(2),,$(error Unable to locate module '$(1)'))
-include $(2)/requires.mk
ifeq ($$(filter $(call MAKE_EncodeWord,$(1)),$$(MODULES_GLOBAL)),)
#ifneq ($$(MAKERY_DEBUG),)
#$$(warning $$(call MAKE_Message,Sourcing module '$(1)' from '$(2)'))
#endif
-include $(2)/global.mk
MODULES_GLOBAL += $(call MAKE_EncodeWord,$(1))
endif
ifeq ($$(filter $(call MAKE_EncodeWord,$(1)),$$(MODULES_proj)),)
-include $(2)/project.mk
MODULES_proj += $(call MAKE_EncodeWord,$(1))
endif
endef

