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


$(info ===> Configuring $(if $(PROJ_dir),$(PROJ_dir),.))


ifndef MAKERY_BOOTSTRAP

-include ~/.makeryrc.mk

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

MAKERY_BOOTSTRAP := 1

endif


$(call MODULES_Use,gmsl)
$(call MODULES_Use,make)
$(call MODULES_Use,makery)
$(call MODULES_Use,system)
$(call MODULES_Use,modules)
$(call MODULES_Use,proj)
$(call MODULES_Use,out)


$(foreach mod,$(MODULES_use),$(call MODULES_Use,$(mod)))
$(call PROJ_LoadVarCache)
$(call PROJ_FlattenVars)
$(call PROJ_SaveVarCache)
$(call PROJ_DebugPrintVarInfo)
$(call PROJ_Validate)
$(call PROJ_ProcessRequired)
$(call PROJ_GenerateRules)
$(call PROJ_ClearVars)

