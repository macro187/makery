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


# ------------------------------------------------------------------------------
# Include this file from project Makefiles
# ------------------------------------------------------------------------------


$(info => Configuring $(realpath $(or $(PROJ_dir),.)))


ifndef MAKERY_BOOTSTRAP


#
# Source .makeryrc.mk
#
-include ~/.makeryrc.mk


#
# "Manually" process global parts of base modules
#
include $(MAKERY)/makery-gmsl/global.mk
MODULES_GLOBAL += gmsl
include $(MAKERY)/makery-make/global.mk
MODULES_GLOBAL += make
include $(MAKERY)/makery-makery/global.mk
MODULES_GLOBAL += makery
include $(MAKERY)/makery-system/global.mk
MODULES_GLOBAL += system
include $(MAKERY)/makery-modules/global.mk
MODULES_GLOBAL += modules
include $(MAKERY)/makery-proj/global.mk
MODULES_GLOBAL += proj
$(call MODULES_DebugPrintGlobals,gmsl)
$(call MODULES_DebugPrintGlobals,make)
$(call MODULES_DebugPrintGlobals,makery)
$(call MODULES_DebugPrintGlobals,system)
$(call MODULES_DebugPrintGlobals,modules)
$(call MODULES_DebugPrintGlobals,proj)


MAKERY_BOOTSTRAP := 1
endif


#
# "Manually" process per-project parts of base modules
#
$(call MODULES_Use,gmsl)
$(call MODULES_Use,make)
$(call MODULES_Use,makery)
$(call MODULES_Use,system)
$(call MODULES_Use,modules)
$(call MODULES_Use,proj)
$(call MODULES_Use,out)


#
# Let the modules mechanism process remaining modules (global and per-project
# parts)
#
$(foreach mod,$(MODULES_use),$(call MODULES_Use,$(mod)))


#
# Load cached per-project variable values from previous run (if present)
#
ifneq ($(MAKERYUSECACHE),)
$(call PROJ_LoadVarCache)
endif


#
# Evaluate final values of per-project variables
#
$(call PROJ_FlattenVars)


#
# Cache final values of per-project variables
#
ifneq ($(MAKERYUSECACHE),)
$(call PROJ_SaveVarCache)
endif


$(call PROJ_DebugPrintVarInfo)


#
# Run validation checks on final per-project variable values
#
$(call PROJ_Validate)


#
# Process required projects.  This recurses back into this file for all
# required projects via their Makefiles.
#
$(call PROJ_ProcessRequired)


#
# Process rule-generating parts of modules.  This is done after processing
# required projects so information about them is available.
#
$(call PROJ_GenerateRules)


$(call PROJ_ClearVars)

