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
# One-time bootstrap
# ------------------------------------------------------------------------------

ifndef MAKERY_BOOTSTRAPPED

-include ~/.makeryrc.mk

include $(MAKERY)/makery/global.mk
MODULES_GLOBAL += makery
include $(MAKERY)/gmsl/global.mk
MODULES_GLOBAL += gmsl
include $(MAKERY)/make/global.mk
MODULES_GLOBAL += make
include $(MAKERY)/shell/global.mk
MODULES_GLOBAL += shell
include $(MAKERY)/os/global.mk
MODULES_GLOBAL += os
include $(MAKERY)/modules/global.mk
MODULES_GLOBAL += modules
include $(MAKERY)/proj/global.mk
MODULES_GLOBAL += proj

MAKERY_BOOTSTRAPPED := 1
endif #ndef MAKERY_BOOTSTRAPPED



# ------------------------------------------------------------------------------
# Per-project processing starts here
# ------------------------------------------------------------------------------

$(call MODULES_Use,makery)
$(call MODULES_Use,gmsl)
$(call MODULES_Use,make)
$(call MODULES_Use,shell)
$(call MODULES_Use,os)
$(call MODULES_Use,modules)
$(call MODULES_Use,proj)

$(call MODULES_Use,config)



$(warning $(call MAKE_Message,Project ('$(PROJ_dir)')))



ifneq ($(MAKERY_DEBUG),)
$(warning $(call MAKE_Message,Module search paths$(foreach path,$(MODULES_PATHS),$(MAKE_CHAR_NEWLINE)$(call MAKE_DecodeWord,$(path)))))
endif


# Pull modules specified by the project
ifneq ($(MAKERY_DEBUG),)
$(warning $(call MAKE_Message,Processing modules...))
endif
$(foreach mod,$(MODULES_use),$(call MODULES_Use,$(mod)))


ifneq ($(MAKERY_DEBUG),)
$(warning $(call MAKE_Message,Project Variables ('$(PROJ_dir)')$(call MAKE_DumpVars,$(PROJ_vars))))
endif


$(call PROJ_Validate)


$(call PROJ_ProcessRequired)


ifneq ($(MAKERY_DEBUG),)
$(warning $(call MAKE_Message,Generating rules... ('$(PROJ_dir)')))
endif
$(call PROJ_GenerateRules)


# Debug: Globals
ifneq ($(MAKERY_DEBUG),)
ifneq ($(PROJ_ismain),)
$(warning $(call MAKE_Message,Global Variables$(call MAKE_DumpVars,$(MAKERY_GLOBALS))))
endif
endif


$(call PROJ_ClearVars)

