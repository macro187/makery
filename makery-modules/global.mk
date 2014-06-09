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


MODULES_CONTEXT_DESC ?= \
(internal) Stack to track current module while processing (list)
MODULES_CONTEXT := $(MODULES_CONTEXT)
MAKERY_GLOBALS += MODULES_CONTEXT


# Compute a module's variable name prefix given its name
#
# e.g. module-name => MODULE_NAME
#
# $1 - Module name
#
MODULES_VariablePrefix = \
$(subst -,_,$(call uc,$(1)))


# Specify that this module require another to build
#
# $1 - Module name
#
MODULES_Requires = \
$(MAKERY_TRACEBEGIN1)$(call MODULES_Use,$(1),requires)$(MAKERY_TRACEEND1)


# Specify that another module require this one to build
#
# $1 - Module name
#
MODULES_RequiredBy = \
$(MAKERY_TRACEBEGIN1)$(call MODULES_Use,$(1),requiredby)$(MAKERY_TRACEEND1)


# Pull in a module
#
# $1 - Module name
# $2 - Build dependency type ('requires', 'requiredby', or '')
#
MODULES_Use = \
$(MAKERY_TRACEBEGIN2)$(eval $(call MODULES_USE_TEMPLATE,$(1),$(call MODULES_Locate,$(1)),$(call MODULES_VariablePrefix,$(1)),$(2)))$(MAKERY_TRACEEND2)
#
# $1 - Module name
# $2 - Module dir
# $3 - Module variable prefix
# $4 - Build dependency type
#
define MODULES_USE_TEMPLATE

#
# Remember build dependency
#
ifeq ($(4),requires)
MODULES_requiredby_$$(call first,$$(MODULES_CONTEXT)) := $$(MODULES_requiredby_$$(call first,$$(MODULES_CONTEXT)))
MODULES_requiredby_$$(call first,$$(MODULES_CONTEXT)) += $(1)
endif
ifeq ($(4),requiredby)
MODULES_requiredby_$(1) := $$(MODULES_requiredby_$(1))
MODULES_requiredby_$(1) += $$(call first,$$(MODULES_CONTEXT))
endif

#
# Dependencies
#
$$(call MAKERY_TraceBegin,-include $(2)/depends.mk)
MODULES_CONTEXT := $(1) $$(MODULES_CONTEXT)
-include $(call MAKE_EncodePath,$(2)/depends.mk)
MODULES_CONTEXT := $$(call rest,$$(MODULES_CONTEXT))
$$(call MAKERY_TraceEnd,-include $(2)/depends.mk)

#
# Global
#
ifeq ($$(filter $(call MAKE_EncodeWord,$(1)),$$(MODULES_GLOBAL)),)

$$(call MAKERY_Debug Sourcing module '$(1)' from '$(2)')

$$(call MAKERY_TraceBegin,-include $(2)/global.mk)
-include $(call MAKE_EncodePath,$(2)/global.mk)
$$(call MAKERY_TraceEnd,-include $(2)/global.mk)

MODULES_GLOBAL += $(call MAKE_EncodeWord,$(1))

endif

#
# Project
#
ifeq ($$(filter $(call MAKE_EncodeWord,$(1)),$$(MODULES_proj)),)

$(3)_outdir_DESC ?= Output directory for $(1) module
$$(call PROJ_DeclareVar,$(3)_outdir)
$(3)_outdir = $$(OUT_dir)/$(1)

$(3)_dotfile_DESC ?= Dotfile for $(1) module
$$(call PROJ_DeclareVar,$(3)_dotfile)
$(3)_dotfile = $$(OUT_dir)/_$(1)

$$(call MAKERY_TraceBegin,-include $(2)/project.mk)
-include $(call MAKE_EncodePath,$(2)/project.mk)
$$(call MAKERY_TraceEnd,-include $(2)/project.mk)
MODULES_proj += $(call MAKE_EncodeWord,$(1))

endif

endef

