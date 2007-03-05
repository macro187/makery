# ------------------------------------------------------------------------------
# MAKERY.MK
# Makery's entry point
# ------------------------------------------------------------------------------


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
# Bootstrap
# - Only happens once, at the very beginning
# ------------------------------------------------------------------------------

ifndef MAKERY_BOOTSTRAP


# $MAKERY variable check
ifndef MAKERY
$(error The MAKERY variable has not been set, how did you include this file?)
endif


# Source per-user preferences from .makeryrc.mk if available
-include ~/.makeryrc.mk


# Global variable list
MAKERY_GLOBALS :=

# Debug flag
MAKERY_DEBUG ?=
MAKERY_GLOBALS += MAKERY_DEBUG


# Bootstrap system modules
include $(MAKERY)/gmsl/global.mk
MODULES_GLOBAL += gmsl

include $(MAKERY)/make/global.mk
MODULES_GLOBAL += make

include $(MAKERY)/shell/global.mk
MODULES_GLOBAL += shell

include $(MAKERY)/os/global.mk
MODULES_GLOBAL += os

include $(MAKERY)/proj/global.mk
MODULES_GLOBAL += proj

include $(MAKERY)/modules/global.mk
MODULES_GLOBAL += modules


MAKERY_BOOTSTRAP := 1
endif #ndef MAKERY_BOOTSTRAP



# ------------------------------------------------------------------------------
# System modules
# ------------------------------------------------------------------------------

$(call MODULES_Use,gmsl)
$(call MODULES_Use,make)
$(call MODULES_Use,shell)
$(call MODULES_Use,os)
$(call MODULES_Use,proj)

$(warning $(call MAKE_Message,Project ('$(PROJ_dir)')))

$(call MODULES_Use,modules)
$(call MODULES_Use,config)



# ------------------------------------------------------------------------------
# Pull in modules specified in project's MODULES_use
# ------------------------------------------------------------------------------

ifneq ($(MAKERY_DEBUG),)
$(warning $(call MAKE_Message,Processing modules...))
endif

$(foreach mod,$(MODULES_use),$(call MODULES_Use,$(mod)))



# ------------------------------------------------------------------------------
# Debug print project variables
# ------------------------------------------------------------------------------

ifneq ($(MAKERY_DEBUG),)
$(warning $(call MAKE_Message,Project Variables ('$(PROJ_dir)')$(call MAKE_DumpVars,$(PROJ_vars))))
endif



# ------------------------------------------------------------------------------
# Process required projects
# - Restarts this whole process for each one (recursive)
# ------------------------------------------------------------------------------

$(call PROJ_ProcessRequired)



# ------------------------------------------------------------------------------
# Generate targets
# ------------------------------------------------------------------------------

ifneq ($(MAKERY_DEBUG),)
$(warning $(call MAKE_Message,Generating rules... ('$(PROJ_dir)')))
endif

$(call MODULES_GenerateRules)



# ------------------------------------------------------------------------------
# Debug print globals
# ------------------------------------------------------------------------------

ifneq ($(MAKERY_DEBUG),)
ifneq ($(PROJ_ismain),)
$(warning $(call MAKE_Message,Global Variables$(call MAKE_DumpVars,$(MAKERY_GLOBALS))))
endif
endif



# ------------------------------------------------------------------------------
# Clear project variables
# ------------------------------------------------------------------------------

$(call PROJ_ClearVars)

